//
//  Career.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/14/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3HTTPClient.h"
#import "D3Hero.h"

@class D3Career;
@class D3HTTPClient;

/** This class represents a Diablo 3 account. It is populated by requesting information from Blizzard's API for Diablo 3.
 
 */

typedef void (^D3CareerRequestSuccess)(D3Career*);
typedef void (^D3CareerRequestFailure)(NSHTTPURLResponse*,NSError*);

@interface D3Career : D3Object

/**---------------------------------------------------------------------------------------
 * @name Parsing
 *  ---------------------------------------------------------------------------------------
 */

+ (D3Career*)careerFromJSON:(NSDictionary*)json;

/**---------------------------------------------------------------------------------------
 * @name API Request
 *  ---------------------------------------------------------------------------------------
 */

+ (void)getCareerForBattletag:(NSString*)battletag region:(NSString*)region success:(D3CareerRequestSuccess)success failure:(D3CareerRequestFailure)failure;
+ (NSDictionary*)availableRegions;

/**---------------------------------------------------------------------------------------
 * @name Helpers
 *  ---------------------------------------------------------------------------------------
 */

+ (BOOL)battletagIsValid:(NSString*)battletag;
+ (NSString*)battletagDivider;
+ (NSString*)apiParamFromBattletag:(NSString*)battletag;

/**---------------------------------------------------------------------------------------
 * @name Account information
 *  ---------------------------------------------------------------------------------------
 */

@property (strong, nonatomic) D3HTTPClient *httpClient;

@property (copy, nonatomic) NSString *battletag;
@property (copy, nonatomic) NSString *region;

@property (assign, nonatomic) D3Hero *lastHeroPlayed;

@property (strong, nonatomic) NSDate *lastUpdated;

@property (strong, nonatomic) NSArray *artisans;
@property (strong, nonatomic) NSArray *hardcoreArtisans;
@property (strong, nonatomic) NSArray *timePlayedArray;
@property (strong, nonatomic) NSArray *progression;
@property (strong, nonatomic) NSArray *heroes;
@property (strong, nonatomic) NSArray *fallenHeros;

/**---------------------------------------------------------------------------------------
 * @name Account statistics
 *  ---------------------------------------------------------------------------------------
 */

@property (assign, nonatomic) NSInteger killsMonsters;
@property (assign, nonatomic) NSInteger killsElites;
@property (assign, nonatomic) NSInteger killsHardcoreMonsters;

@property (assign, nonatomic) CGFloat timePlayedBarbarian;
@property (assign, nonatomic) CGFloat timePlayedDemonHunter;
@property (assign, nonatomic) CGFloat timePlayedMonk;
@property (assign, nonatomic) CGFloat timePlayedWitchDoctor;
@property (assign, nonatomic) CGFloat timePlayedWizard;

@end