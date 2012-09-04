//
//  Item.m
//  Diablo
//
//  Created by Ryan Nystrom on 6/16/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3HTTPClient.h"
#import "D3Item.h"
#import "D3Gem.h"

@interface D3Item ()

@end

@implementation D3Item

+ (D3Item*)itemFromPreviewJSON:(NSDictionary*)json withType:(NSInteger)type {
    D3Item *item = [[D3Item alloc] init];
    if ([json isKindOfClass:[NSDictionary class]]) {
        item.colorString = json[@"displayColor"];
        item.name = json[@"name"];
        item.iconString = json[@"icon"];
        item.tooltipParams = json[@"tooltipParams"];
        item.itemType = type;
    }
    return item;
}


- (id)init {
    if (self = [super init]) {
        // i dont like this because its stored for *every* Item
        _queue = [[NSOperationQueue alloc] init];
        _name = @"Not Available";
        _requiredLevel = 0;
        _itemLevel = 0;
        _itemType = D3ItemGeneralTypeArmor;
        _armor = 0;
        _minDamage = 0;
        _maxDamage = 0;
    }
    return self;
}


#pragma mark - Setters

- (void)setTypeString:(NSString *)typeString {
    typeString = [typeString stringByReplacingOccurrencesOfString:@"Generic" withString:@""];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([A-Z]*)([^A-Z]*)" options:kNilOptions error:&error];
    NSArray *matches = [regex matchesInString:typeString options:0 range:NSMakeRange(0, [typeString length])];
    NSMutableArray *mutArray = [NSMutableArray array];
    [matches enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSTextCheckingResult class]]) {
            NSTextCheckingResult *result = (NSTextCheckingResult*)obj;
            NSRange range = result.range;
            NSString *substring = [typeString substringWithRange:range];
            if (substring) {
                [mutArray addObject:substring];
            }
        }
    }];
    _typeString = [mutArray componentsJoinedByString:@" "];
}


#pragma mark - Getters

- (UIColor*)displayColorFromDictionary {
    if (self.colorString) {
        return @{
        @"white"    : [UIColor whiteColor],
        @"blue"     : [UIColor blueColor],
        @"yellow"   : [UIColor yellowColor],
        @"orange"   : [UIColor orangeColor],
        @"green"    : [UIColor greenColor],
        @"null"     : [UIColor redColor]
        }[self.colorString];
    }
    return [UIColor redColor];
}


- (NSString*)getDisplayValue {
    switch (self.itemType) {
        case D3ItemGeneralTypeArmor:
            return [NSString stringWithFormat:@"%i",self.armor];
            break;
        case D3ItemGeneralTypeWeapon:
            return [NSString stringWithFormat:@"%.1f",self.dps];
            break;
    }
    return nil;
}


- (NSString*)getRequiredLevelString {
    return [NSString stringWithFormat:@"Required Level: %i",self.requiredLevel];
}


- (NSString*)getItemLevelString {
    return [NSString stringWithFormat:@"Item Level: %i",self.itemLevel];
}


- (NSString*)getDisplayValueUnit {
    if (self.itemType == D3ItemGeneralTypeArmor) {
        return @"Armor";
    }
    else if (self.itemType == D3ItemGeneralTypeWeapon) {
        return [NSString stringWithFormat:@"Damage Per Second\n%i-%i Damage\n%.2f Attacks Per Second",self.minDamage,self.maxDamage,self.attacksPerSecond];
    }
    return @"";
}


- (NSString*)setItemsFormattedString {
    if (self.isPartOfSet) {
        return [self.setItems componentsJoinedByString:@"\n"];
    }
    return nil;
}


- (NSString*)setBonusesFormattedString {
    if (self.isPartOfSet) {
        __block NSMutableString *mutString = nil;
        [self.setBonuses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json = (NSDictionary*)obj;
                NSArray *attributes = json[@"attributes"];
                NSString *attributesString = [attributes componentsJoinedByString:@", "];
                NSString *setString = [NSString stringWithFormat:@"(%@) %@",json[@"required"],attributesString];
                if (! mutString) {
                    mutString = [NSMutableString stringWithString:setString];
                }
                else {
                    [mutString appendFormat:@"\n%@",setString];
                }
            }
        }];
        return mutString;
    }
    return nil;
}


- (BOOL)isShield {
    NSRange range = [[self.typeString lowercaseString] rangeOfString:@"shield"];
    return range.location != NSNotFound;
}


- (BOOL)isRanged {
    NSRange range = [[self.typeString lowercaseString] rangeOfString:@"bow"];
    return range.location != NSNotFound;
}


- (BOOL)isQuiver {
    NSRange range = [[self.typeString lowercaseString] rangeOfString:@"quiver"];
    return range.location != NSNotFound;
}


#pragma mark - Loading

// return a request so we can batch all of the items into one burst
- (AFImageRequestOperation*)requestForItemIconWithImageProcessingBlock:(UIImage* (^)(UIImage *image))imageProcessingBlock success:(void (^)(NSURLRequest*, NSHTTPURLResponse*, UIImage*))success failure:(void (^)(NSURLRequest*, NSHTTPURLResponse*, NSError*))failure {
    if (! self.iconString) {
        return nil;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@.png",kD3MediaURL,kD3ItemParam,self.iconString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:imageProcessingBlock success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.icon = image;
            if (success) {
                success(request, response, image);
            }
        });
    } failure:failure];
    return operation;
}


- (AFJSONRequestOperation*)requestForItemWithSuccess:(void (^)(D3Item*))success failure:(void (^)(NSHTTPURLResponse*, NSError*))failure {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@",kD3BaseURL,kD3DataParam,self.tooltipParams];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        [self parseFullJSON:JSON];
        self.isFullyLoaded = YES;
        if (success) {
            success(self);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (failure) {
            failure(response, error);
        }
    }];
    return operation;
}


#pragma mark - Parsing

- (void)parseFullJSON:(NSDictionary*)json {
    if ([json isKindOfClass:[NSDictionary class]]) {        
        // if weapon
        NSDictionary *minDamage = json[@"minDamage"];
        NSDictionary *maxDamage = json[@"maxDamage"];
        NSDictionary *dps = json[@"dps"];
        NSDictionary *attacksPerSecond = json[@"attacksPerSecond"];
        
        // if armor
        NSDictionary *armor = json[@"armor"];
        
        NSString *requiredLevel = json[@"requiredLevel"];
        NSString *itemLevel = json[@"itemLevel"];
        self.attributes = json[@"attributes"];
        self.flavorText = json[@"flavorText"];
        self.itemLevel = itemLevel.integerValue;
        self.requiredLevel = requiredLevel.integerValue;
        
        switch (self.itemType) {
            case D3ItemGeneralTypeArmor: {
                if ([armor isKindOfClass:[NSDictionary class]]) {
                    self.armor = ((NSString*)armor[@"min"]).integerValue;
                }
            }
                break;
            case D3ItemGeneralTypeTrinket: {
                
            }
                break;
            case D3ItemGeneralTypeWeapon: {
                if ([minDamage isKindOfClass:[NSDictionary class]]) {
                    self.minDamage = ((NSString*)minDamage[@"min"]).integerValue;
                }
                if ([maxDamage isKindOfClass:[NSDictionary class]]) {
                    self.maxDamage = ((NSString*)maxDamage[@"min"]).integerValue;
                }
                if ([dps isKindOfClass:[NSDictionary class]]) {
                    self.dps = ((NSString*)dps[@"min"]).floatValue;
                }
                if ([attacksPerSecond isKindOfClass:[NSDictionary class]]) {
                    self.attacksPerSecond = ((NSString*)attacksPerSecond[@"min"]).floatValue;
                }
            }
                break;
        }
        
        NSDictionary *set = json[@"set"];
        if ([set isKindOfClass:[NSDictionary class]]) {
            self.isPartOfSet = YES;
            self.setName = set[@"name"];
            
            NSArray *setItems = set[@"items"];
            NSMutableArray *mutItems = [NSMutableArray array];
            [setItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *item = (NSDictionary*)obj;
                    [mutItems addObject:item[@"name"]];
                }
            }];
            self.setItems = mutItems;
            self.setBonuses = set[@"ranks"];
        }
        
        NSArray *gems = json[@"gems"];
        NSMutableArray *mutGems = [NSMutableArray array];
        if ([gems isKindOfClass:[NSArray class]]) {
            [gems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *gemJSON = (NSDictionary*)obj;
                    D3Gem *gem = [D3Gem gemFromJSON:gemJSON];
                    if (gem) {
                        [mutGems addObject:gem];
                    }
                }
            }];
        }
        self.gems = mutGems;
        
        NSDictionary *attributesRaw = json[@"attributesRaw"];
        if ([attributesRaw isKindOfClass:[NSDictionary class]]) {
            NSDictionary *socketsRaw = attributesRaw[@"Sockets"];
            if ([socketsRaw isKindOfClass:[NSDictionary class]]) {
                NSString *socketsString = socketsRaw[@"max"];
                self.sockets = socketsString.integerValue;
            }
        }
        
        NSDictionary *type = json[@"type"];
        if ([type isKindOfClass:[NSDictionary class]]) {
            self.typeString = type[@"id"];
            
            if ([self isShield]) {
                self.itemType = D3ItemGeneralTypeArmor;
            }
            
            NSNumber *twoHanded = type[@"twoHanded"];
            self.isTwoHand = twoHanded.boolValue;
        }
    }
}


@end
