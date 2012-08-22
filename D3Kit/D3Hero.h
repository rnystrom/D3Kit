//
//  Hero.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/14/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

@class D3Hero;

typedef void (^D3HeroRequestSuccess)(D3Hero*);
typedef void (^D3HeroRequestFailure)(NSError*);

#import "D3Skill.h"
#import "D3Artisan.h"
#import "D3Item.h"
#import "D3Follower.h"
#import "D3Object.h"

enum Gender {
    GenderMale = 0,
    GenderFemale = 1
};

@interface D3Hero : D3Object

+ (D3Hero*)heroFromPreviewJSON:(NSDictionary*)json;
+ (D3Hero*)fallenHeroFromJSON:(NSDictionary*)json;

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *progressHighestDifficulty;

@property (assign, nonatomic) BOOL hardcore;

@property (strong, nonatomic) D3Item *head;
@property (strong, nonatomic) D3Item *torso;
@property (strong, nonatomic) D3Item *feet;
@property (strong, nonatomic) D3Item *hands;
@property (strong, nonatomic) D3Item *shoulders;
@property (strong, nonatomic) D3Item *legs;
@property (strong, nonatomic) D3Item *bracers;
@property (strong, nonatomic) D3Item *mainHand;
@property (strong, nonatomic) D3Item *offHand;
@property (strong, nonatomic) D3Item *waist;
@property (strong, nonatomic) D3Item *rightFinger;
@property (strong, nonatomic) D3Item *leftFinger;
@property (strong, nonatomic) D3Item *neck;

@property (strong, nonatomic) NSArray *itemsArray;
@property (strong, nonatomic) NSArray *activeSkills;
@property (strong, nonatomic) NSArray *passiveSkills;
@property (strong, nonatomic) NSArray *progressionCompletion;

@property (strong, nonatomic) NSDictionary *progress;

@property (strong, nonatomic) D3Follower *templar;
@property (strong, nonatomic) D3Follower *scoundrel;
@property (strong, nonatomic) D3Follower *enchantress;

@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger ID;
@property (assign, nonatomic) NSInteger life;
@property (assign, nonatomic) NSInteger strength;
@property (assign, nonatomic) NSInteger dexterity;
@property (assign, nonatomic) NSInteger intelligence;
@property (assign, nonatomic) NSInteger vitality;
@property (assign, nonatomic) NSInteger armor;
@property (assign, nonatomic) NSInteger coldResist;
@property (assign, nonatomic) NSInteger fireResist;
@property (assign, nonatomic) NSInteger lightningResist;
@property (assign, nonatomic) NSInteger poisonResist;
@property (assign, nonatomic) NSInteger arcaneResist;
@property (assign, nonatomic) NSInteger physicalResist;

@property (assign, nonatomic) CGFloat damageIncrease;
@property (assign, nonatomic) CGFloat damageReduction;
@property (assign, nonatomic) CGFloat critChance;
@property (assign, nonatomic) CGFloat damage;

@property (strong, nonatomic) NSDate *lastUpdated;

- (void)finishLoadingWithSuccess:(D3HeroRequestSuccess)success failure:(D3HeroRequestFailure)failure;
- (NSString*)formattedClassName;

@end
