//
//  Career.m
//  Diablo
//
//  Created by Ryan Nystrom on 6/14/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Career.h"

@implementation D3Career

#pragma mark - Helpers

+ (NSString*)battletagDivider {
    return @"#";
}


+ (BOOL)battletagIsValid:(NSString*)battletag; {
    if ([battletag length] < 3) {
        return NO;
    }
    NSString *battletagDivider = [self battletagDivider];
    NSRange poundRange = [battletag rangeOfString:battletagDivider];
    return poundRange.location != NSNotFound;
}


+ (NSString*)apiParamFromBattletag:(NSString*)battletag {
    NSArray *splitbattletag = [battletag componentsSeparatedByString:[D3Career battletagDivider]];
    NSString *battletagName = splitbattletag [0];
    NSString *battletagNumber = [splitbattletag lastObject];
    return [NSString stringWithFormat:@"%@/%@-%@/",kD3APIProfileParam,battletagName,battletagNumber];
}


#pragma mark - Loading

+ (void)getCareerForBattletag:(NSString *)battletag success:(void (^)(D3Career *career))success failure:(void (^)(NSError *error))failure {
    if (! [D3Career battletagIsValid:battletag]) {
        if (failure) {
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"A valid battletag name and number is required." forKey:NSLocalizedDescriptionKey];
            NSError *error = [[NSError alloc] initWithDomain:@"com.nystromproductions.error" code:100 userInfo:errorDetail];
            failure(error);
        }
    }
    else {
        NSString *careerPath = [D3Career apiParamFromBattletag:battletag];
        [[D3HTTPClient sharedClient] getJSONPath:careerPath parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *json) {
            if ([json objectForKey:@"code"]) {
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:[NSString stringWithFormat:@"Battletag %@ could not be found.",battletag] forKey:NSLocalizedDescriptionKey];
                NSError *error = [[NSError alloc] initWithDomain:@"com.nystromproductions.error" code:100 userInfo:errorDetail];
                failure(error);
            }
            else {
                D3Career *career = [D3Career careerFromJSON:json];
                if (career) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [D3HTTPClient sharedClient].career = career;
                        [[NSNotificationCenter defaultCenter] postNotificationName:kD3CareerNotification object:nil];
                    });
                }
                if (success) {
                    success(career);
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}


#pragma mark - Parsing

// dummy data for now, ignores battletagName parameter
+ (D3Career*)careerFromJSON:(NSDictionary *)json {
    D3Career *career = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        career = [[D3Career alloc] init];
        
        NSString *secondsString = json[@"lastUpdated"];
        if (secondsString) {
            NSTimeInterval seconds = secondsString.doubleValue;
            career.lastUpdated = [NSDate dateWithTimeIntervalSince1970:seconds];
        }
        
        career.battletag = json[@"battleTag"];
        
        NSMutableArray *mutArtisans = [NSMutableArray array];
        if ([json[@"artisans"] isKindOfClass:[NSArray array]]) {
            for (id artisanJSON in (NSArray*)json[@"artisans"]) {
                D3Artisan *artisan = [D3Artisan artisanWithJSON:json];
                if (artisan) {
                    [mutArtisans addObject:artisan];
                }
            }
        }
        career.artisans = mutArtisans;

        NSMutableArray *mutHCArtisans = [NSMutableArray array];
        if ([json[@"hardcoreArtisans"] isKindOfClass:[NSArray class]]) {
            for (id artisanJSON in (NSArray*)json[@"hardcoreArtisans"]) {
                D3Artisan *artisan = [D3Artisan artisanWithJSON:json];
                if (artisan) {
                    [mutHCArtisans addObject:artisan];
                }
            }
        }
        career.hardcoreArtisans = mutHCArtisans;
        
        NSMutableArray *mutHeroes = [NSMutableArray array];
        if ([json[@"heroes"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *heroJSON in (NSArray*)json[@"heroes"]) {
                D3Hero *hero = [D3Hero heroFromPreviewJSON:heroJSON];
                if (hero) {
                    [mutHeroes addObject:hero];
                }
            }
        }
        career.heroes = mutHeroes;
        
        NSMutableArray *mutFallenHeroes = [NSMutableArray array];
        if ([json[@"fallenHeroes"] isKindOfClass:[NSArray array]]) {
            for (NSDictionary *heroJSON in (NSArray*)json[@"fallenHeroes"]) {
                D3Hero *fallenHero = [D3Hero fallenHeroFromJSON:heroJSON];
                if (fallenHero) {
                    [mutFallenHeroes addObject:fallenHero];
                }
            }
        }
        career.fallenHeros = mutFallenHeroes;
                
        NSString *lastPlayedIDString = json[@"lastHeroPlayed"];
        if (lastPlayedIDString) {
            NSInteger lastPlayedID = lastPlayedIDString.integerValue;
            for (D3Hero *hero in mutHeroes) {
                if (hero.ID == lastPlayedID) {
                    career.lastHeroPlayed = hero;
                    break;
                }
            }
        }
        
        NSDictionary *killsDictionary = json[@"kills"];
        if ([killsDictionary isKindOfClass:[NSDictionary class]]) {
            NSString *killsMonstersString = json[@"monsters"];
            NSString *killsElitesString = json[@"elites"];
            NSString *killsHardcoreMonstersString = json[@"hardcoreMonsters"];
            
            career.killsMonsters = killsMonstersString.integerValue;
            career.killsElites = killsElitesString.integerValue;
            career.killsHardcoreMonsters = killsHardcoreMonstersString.integerValue;
        }
        
        NSDictionary *timeDictionary = json[@"timePlayed"];
        if ([timeDictionary isKindOfClass:[NSDictionary class]]) {
            NSString *timePlayedBarbarianString = timeDictionary[@"barbarian"];
            NSString *timePlayedDemonHunterString = timeDictionary[@"demon-hunter"];
            NSString *timePlayedMonkString = timeDictionary[@"monk"];
            NSString *timePlayedWitchDoctorString = timeDictionary[@"witch-doctor"];
            NSString *timePlayedWizardString = timeDictionary[@"wizard"];
            
            career.timePlayedBarbarian = timePlayedBarbarianString.floatValue;
            career.timePlayedDemonHunter = timePlayedDemonHunterString.floatValue;
            career.timePlayedMonk = timePlayedMonkString.floatValue;
            career.timePlayedWitchDoctor = timePlayedWitchDoctorString.floatValue;
            career.timePlayedWizard = timePlayedWizardString.floatValue;
            
            career.timePlayedArray = @[
            @(career.timePlayedBarbarian),
            @(career.timePlayedDemonHunter),
            @(career.timePlayedMonk),
            @(career.timePlayedWitchDoctor),
            @(career.timePlayedWizard)
            ];
        }
//            career.progression = json[@"progression"];
    }
    return career;
}

@end
