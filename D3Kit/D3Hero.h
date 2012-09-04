//
//  Hero.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/14/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

@class D3Hero;
@class D3Career;

typedef void (^D3HeroRequestSuccess)(D3Hero*);
typedef void (^D3HeroRequestFailure)(NSHTTPURLResponse*,NSError*);

#import "D3Skill.h"
#import "D3Artisan.h"
#import "D3Item.h"
#import "D3Follower.h"

enum Gender {
    GenderMale = 0,
    GenderFemale = 1
};

@interface D3Hero : D3Object

+ (D3Hero*)heroFromPreviewJSON:(NSDictionary*)json;
+ (D3Hero*)fallenHeroFromJSON:(NSDictionary*)json;

@property (weak, nonatomic) D3Career *career;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *className;
@property (copy, nonatomic) NSString *progressHighestDifficulty;

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
@property (assign, nonatomic) NSInteger paragonLevel;
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
@property (assign, nonatomic) NSInteger blockAmountMax;
@property (assign, nonatomic) NSInteger blockAmountMin;
@property (assign, nonatomic) NSInteger primaryResource;
@property (assign, nonatomic) NSInteger secondaryResource;
@property (assign, nonatomic) NSInteger eliteKills;

@property (assign, nonatomic) CGFloat damageIncrease;
@property (assign, nonatomic) CGFloat damageReduction;
@property (assign, nonatomic) CGFloat critChance;
@property (assign, nonatomic) CGFloat damage;
@property (assign, nonatomic) CGFloat goldFind;
@property (assign, nonatomic) CGFloat magicFind;
@property (assign, nonatomic) CGFloat lifeOnHit;
@property (assign, nonatomic) CGFloat lifePerKill;
@property (assign, nonatomic) CGFloat lifeSteal;
@property (assign, nonatomic) CGFloat thorns;
@property (assign, nonatomic) CGFloat blockChance;

@property (strong, nonatomic) NSDate *lastUpdated;

- (void)finishLoadingWithSuccess:(D3HeroRequestSuccess)success failure:(D3HeroRequestFailure)failure;
- (NSString*)formattedClassName;

@end
