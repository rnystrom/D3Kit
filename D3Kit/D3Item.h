//
//  Item.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/16/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "AFImageRequestOperation.h"
#import "D3Object.h"

@class D3Item;

typedef void (^D3ItemImageRequestSuccess)(NSURLRequest*, NSHTTPURLResponse*, UIImage*);
typedef void (^D3ItemImageRequestFailure)(NSURLRequest*, NSHTTPURLResponse*, NSError*);
typedef void (^D3ItemRequestSuccess)(D3Item*);
typedef void (^D3ItemRequestFailure)(NSHTTPURLResponse*, NSError*);

enum D3ItemType {
    D3ItemTypeHead = 0,
    D3ItemTypeShoulders = 1,
    D3ItemTypeNeck = 2,
    D3ItemTypeHands = 3,
    D3ItemTypeBracers = 4,
    D3ItemTypeLeftFinger = 5,
    D3ItemTypeRightFinger = 6,
    D3ItemTypeWaist = 7,
    D3ItemTypeLegs = 8,
    D3ItemTypeMainHand = 9,
    D3ItemTypeOffHand = 10,
    D3ItemTypeFeet = 11,
    D3ItemTypeTorso = 12
};

enum D3ItemGeneralType {
    D3ItemGeneralTypeWeapon = 0,
    D3ItemGeneralTypeArmor = 1,
    D3ItemGeneralTypeTrinket = 2
};

@interface D3Item : D3Object

+ (D3Item*)itemFromPreviewJSON:(NSDictionary*)json withType:(NSInteger)type;

@property (strong, nonatomic) NSOperationQueue *queue;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *colorString;
@property (copy, nonatomic) NSString *tooltipParams;
@property (copy, nonatomic) NSString *flavorText;
@property (copy, nonatomic) NSString *iconString;
@property (copy, nonatomic) NSString *setName;
@property (copy, nonatomic) NSString *typeString;
@property (getter = getDisplayValue, nonatomic, readonly) NSString *displayValue;
@property (getter = getDisplayValueUnit, nonatomic, readonly) NSString *displayValueUnit;
@property (getter = getRequiredLevelString, nonatomic, readonly) NSString *requiredLevelString;
@property (getter = getItemLevelString, nonatomic, readonly) NSString *itemLevelString;

@property (getter = displayColorFromDictionary, nonatomic, readonly) UIColor *displayColor;

@property (assign, nonatomic) NSInteger requiredLevel;
@property (assign, nonatomic) NSInteger itemLevel;
@property (assign, nonatomic) NSInteger itemType;
@property (assign, nonatomic) NSInteger armor;
@property (assign, nonatomic) NSInteger minDamage;
@property (assign, nonatomic) NSInteger maxDamage;
@property (assign, nonatomic) NSInteger sockets;

@property (assign, nonatomic) CGFloat dps;
@property (assign, nonatomic) CGFloat attacksPerSecond;

@property (strong, nonatomic) NSArray *attributes;
@property (strong, nonatomic) NSArray *gems;
@property (strong, nonatomic) NSArray *setItems;
@property (strong, nonatomic) NSArray *setBonuses;

@property (strong, nonatomic) UIImage *icon;

@property (assign, nonatomic) BOOL isPartOfSet;
@property (assign, nonatomic) BOOL isTwoHand;

- (AFImageRequestOperation*)requestForItemIconWithImageProcessingBlock:(UIImage* (^)(UIImage *image))imageProcessingBlock success:(D3ItemImageRequestSuccess)success failure:(D3ItemImageRequestFailure)failure;
- (AFJSONRequestOperation*)requestForItemWithSuccess:(D3ItemRequestSuccess)success failure:(D3ItemRequestFailure)failure;
- (NSString*)setItemsFormattedString;
- (NSString*)setBonusesFormattedString;
- (BOOL)isShield;
- (BOOL)isRanged;
- (BOOL)isQuiver;

@end