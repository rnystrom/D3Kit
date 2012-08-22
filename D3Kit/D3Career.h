//
//  Career.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/14/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Hero.h"
#import "D3Object.h"

@class D3Career;

typedef void (^D3CareerRequestSuccess)(D3Career*);
typedef void (^D3CareerRequestFailure)(NSError*);

@interface D3Career : D3Object

+ (D3Career*)careerFromJSON:(NSDictionary*)json;
+ (void)getCareerForBattletag:(NSString*)battletag success:(D3CareerRequestSuccess)success failure:(D3CareerRequestFailure)failure;
+ (BOOL)battletagIsValid:(NSString*)battletag;
+ (NSString*)battletagDivider;
+ (NSString*)apiParamFromBattletag:(NSString*)battletag;

@property (strong, nonatomic) NSString *battletag;

@property (assign, nonatomic) D3Hero *lastHeroPlayed;

@property (strong, nonatomic) NSDate *lastUpdated;

@property (assign, nonatomic) NSInteger killsMonsters;
@property (assign, nonatomic) NSInteger killsElites;
@property (assign, nonatomic) NSInteger killsHardcoreMonsters;

@property (assign, nonatomic) CGFloat timePlayedBarbarian;
@property (assign, nonatomic) CGFloat timePlayedDemonHunter;
@property (assign, nonatomic) CGFloat timePlayedMonk;
@property (assign, nonatomic) CGFloat timePlayedWitchDoctor;
@property (assign, nonatomic) CGFloat timePlayedWizard;

@property (strong, nonatomic) NSArray *artisans;
@property (strong, nonatomic) NSArray *hardcoreArtisans;
@property (strong, nonatomic) NSArray *timePlayedArray;
@property (strong, nonatomic) NSArray *progression;
@property (strong, nonatomic) NSArray *heroes;
@property (strong, nonatomic) NSArray *fallenHeros;

@end