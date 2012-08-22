//
//  Hero.m
//  Diablo
//
//  Created by Ryan Nystrom on 6/14/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Hero.h"

@implementation D3Hero

+ (D3Hero*)heroFromPreviewJSON:(NSDictionary*)json
{
    D3Hero *hero = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        hero = [[D3Hero alloc] init];
        
        hero.isFullyLoaded = NO;
        hero.className = json[@"class"];
        hero.gender = [json[@"gender"] isEqual:[NSNumber numberWithInt:0]] ? @"Male" : @"Female";
        hero.name = json[@"name"];
        
        NSString *hardcoreString = json[@"hardcore"];
        hero.hardcore = hardcoreString.boolValue;
        
        NSString *levelString = json[@"level"];
        hero.level = levelString.integerValue;
        
        NSString *idString = json[@"id"];
        hero.ID = idString.integerValue;
        
        NSString *secondsString = json[@"lastUpdated"];
        if (secondsString) {
            NSTimeInterval seconds = secondsString.doubleValue;
            hero.lastUpdated = [NSDate dateWithTimeIntervalSince1970:seconds];
        }
    }
    return hero;
}


+ (D3Hero*)fallenHeroFromJSON:(NSDictionary*)json
{
    return nil;
}


#pragma mark - Loading

- (void)finishLoadingWithSuccess:(void (^)(D3Hero *hero))success failure:(void (^)(NSError *error))failure {
    NSString *careerParam = [D3Career apiParamFromBattletag:[D3HTTPClient sharedClient].career.battletag];
    NSString *heroPath = [NSString stringWithFormat:@"%@%@/%i",careerParam,kD3APIHeroParam,self.ID];
    [[D3HTTPClient sharedClient] getJSONPath:heroPath parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *json) {
        self.isFullyLoaded = YES;
        [self parseFullJSON:json];
        if (success) {
            success(self);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


#pragma mark - Parsing

- (void)parseFullJSON:(NSDictionary*)json {
    if ([json isKindOfClass:[NSDictionary class]]) {
        NSDictionary *itemsDictionary = json[@"items"];
        if ([itemsDictionary isKindOfClass:[NSDictionary class]]) {
            self.head = [D3Item itemFromPreviewJSON:itemsDictionary[@"head"] withType:D3ItemGeneralTypeArmor];
            self.torso = [D3Item itemFromPreviewJSON:itemsDictionary[@"torso"] withType:D3ItemGeneralTypeArmor];
            self.feet = [D3Item itemFromPreviewJSON:itemsDictionary[@"feet"] withType:D3ItemGeneralTypeArmor];
            self.hands = [D3Item itemFromPreviewJSON:itemsDictionary[@"hands"] withType:D3ItemGeneralTypeArmor];
            self.shoulders = [D3Item itemFromPreviewJSON:itemsDictionary[@"shoulders"] withType:D3ItemGeneralTypeArmor];
            self.legs = [D3Item itemFromPreviewJSON:itemsDictionary[@"legs"] withType:D3ItemGeneralTypeArmor];
            self.bracers = [D3Item itemFromPreviewJSON:itemsDictionary[@"bracers"] withType:D3ItemGeneralTypeArmor];
            self.waist = [D3Item itemFromPreviewJSON:itemsDictionary[@"waist"] withType:D3ItemGeneralTypeArmor];
            
            self.rightFinger = [D3Item itemFromPreviewJSON:itemsDictionary[@"rightFinger"] withType:D3ItemGeneralTypeTrinket];
            self.leftFinger = [D3Item itemFromPreviewJSON:itemsDictionary[@"leftFinger"] withType:D3ItemGeneralTypeTrinket];
            self.neck = [D3Item itemFromPreviewJSON:itemsDictionary[@"neck"] withType:D3ItemGeneralTypeTrinket];
            
            self.mainHand = [D3Item itemFromPreviewJSON:itemsDictionary[@"mainHand"] withType:D3ItemGeneralTypeWeapon];
            self.offHand = [D3Item itemFromPreviewJSON:itemsDictionary[@"offHand"] withType:D3ItemGeneralTypeWeapon];
            
            self.itemsArray = @[
            self.head,
            self.shoulders,
            self.neck,
            self.hands,
            self.bracers,
            self.leftFinger,
            self.rightFinger,
            self.waist,
            self.legs,
            self.mainHand,
            self.offHand,
            self.feet,
            self.torso
            ];
        }
        
        NSDictionary *followersDictionary = json[@"followers"];
        if ([followersDictionary isKindOfClass:[NSDictionary class]]) {
            self.templar = [D3Follower followerFromJSON:followersDictionary[@"templar"]];
            self.enchantress = [D3Follower followerFromJSON:followersDictionary[@"enchantress"]];
            self.scoundrel = [D3Follower followerFromJSON:followersDictionary[@"scoundrel"]];
        }
        
        NSDictionary *statsDictionary = json[@"stats"];
        if ([statsDictionary isKindOfClass:[NSDictionary class]]) {
            self.damageIncrease = ((NSString*)statsDictionary[@"damageIncrease"]).floatValue;
            self.damageReduction = ((NSString*)statsDictionary[@"damageReduction"]).floatValue;
            self.critChance = ((NSString*)statsDictionary[@"critChance"]).floatValue;
            self.life = ((NSString*)statsDictionary[@"life"]).integerValue;
            self.strength = ((NSString*)statsDictionary[@"strength"]).integerValue;
            self.dexterity = ((NSString*)statsDictionary[@"dexterity"]).integerValue;
            self.intelligence = ((NSString*)statsDictionary[@"intelligence"]).integerValue;
            self.vitality = ((NSString*)statsDictionary[@"vitality"]).integerValue;
            self.armor = ((NSString*)statsDictionary[@"armor"]).integerValue;
            self.coldResist = ((NSString*)statsDictionary[@"coldResist"]).integerValue;
            self.fireResist = ((NSString*)statsDictionary[@"fireResist"]).integerValue;
            self.lightningResist = ((NSString*)statsDictionary[@"lightningResist"]).integerValue;
            self.poisonResist = ((NSString*)statsDictionary[@"poisonResist"]).integerValue;
            self.arcaneResist = ((NSString*)statsDictionary[@"arcaneResist"]).integerValue;
            self.physicalResist = ((NSString*)statsDictionary[@"physicalResist"]).integerValue;
            self.damage = ((NSString*)statsDictionary[@"damage"]).floatValue;
        }
        
        NSDictionary *skillsDictionary = json[@"skills"];
        if ([skillsDictionary isKindOfClass:[NSDictionary class]]) {
            NSArray *activeArray = skillsDictionary[@"active"];
            NSArray *passiveArray = skillsDictionary[@"passive"];
            
            NSMutableArray *mutActives = [NSMutableArray array];
            NSMutableArray *mutPassives = [NSMutableArray array];
            
            if ([activeArray isKindOfClass:[NSArray class]]) {
                [activeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *activeJSON = (NSDictionary*)obj;
                        D3Skill *skill = [D3Skill activeSkillFromJSON:activeJSON];
                        if (skill) {
                            [mutActives addObject:skill];
                        }
                    }
                }];
            }
            
            if ([passiveArray isKindOfClass:[NSArray class]]) {
                [passiveArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *passiveJSON = (NSDictionary*)obj;
                        D3Skill *skill = [D3Skill passiveSkillFromJSON:passiveJSON];
                        if (skill) {
                            [mutPassives addObject:skill];
                        }
                    }
                }];
            }
            
            self.activeSkills = mutActives;
            self.passiveSkills = mutPassives;
        }
        
        NSDictionary *progressDictionary = json[@"progress"];
        if ([progressDictionary isKindOfClass:[NSDictionary class]]) {
            // store this in case we want to access it again
            self.progress = progressDictionary;
            // NSNumber %s for each act
            __block NSMutableArray *actsProgression;
            
            NSDictionary *normalDictionary = progressDictionary[@"normal"];
            NSDictionary *nightmareDictionary = progressDictionary[@"nightmare"];
            NSDictionary *hellDictionary = progressDictionary[@"hell"];
            NSDictionary *infernoDictionary = progressDictionary[@"inferno"];
            
            NSArray *difficulties = @[ infernoDictionary, hellDictionary, nightmareDictionary, normalDictionary ];
            __block NSArray *difficultyTitles = @[ @"Inferno", @"Hell", @"Nightmare", @"Normal" ];
            [difficulties enumerateObjectsUsingBlock:^(NSDictionary *json, NSUInteger idx, BOOL *stop){
                // for later use
                __block BOOL *blockStop = stop;
                
                self.progressHighestDifficulty = difficultyTitles[idx];
                
                if ([json isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *act1 = json[@"act1"];
                    NSDictionary *act2 = json[@"act2"];
                    NSDictionary *act3 = json[@"act3"];
                    NSDictionary *act4 = json[@"act4"];
                    
                    NSArray *acts = @[ act1, act2, act3, act4 ];
                    actsProgression = [NSMutableArray array];
                    [acts enumerateObjectsUsingBlock:^(NSDictionary *actsJSON, NSUInteger actsIdx, BOOL *actsStop){
                        NSArray *quests = actsJSON[@"quests"];
                        if ([quests isKindOfClass:[NSArray class]]) {
                            NSNumber *completed = actsJSON[@"completed"];
                            // save some parsing time
                            if (completed.boolValue) {
                                *blockStop = YES;
                                [actsProgression addObject:[NSNumber numberWithFloat:1.0f]];
                            }
                            else {
                                CGFloat totalQuests = [quests count];
                                __block CGFloat completedQuests = 0.0f;
                                [quests enumerateObjectsUsingBlock:^(NSDictionary *questsJSON, NSUInteger questsIdx, BOOL *questsStop){
                                    NSNumber *completedQuest = questsJSON[@"completed"];
                                    completedQuests += completedQuest.floatValue;
                                }];
                                if (completedQuests > 0.0f) {
                                    *blockStop = YES;
                                }
                                [actsProgression addObject:[NSNumber numberWithFloat:(completedQuests / totalQuests)]];
                            }
                        }
                    }];
                }
            }];
            self.progressionCompletion = actsProgression;
        }
    }
}


#pragma mark - Getters

- (NSString*)formattedClassName {
    if (self.className) {
        return [[self.className capitalizedString] stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    }
    return nil;
}


@end
