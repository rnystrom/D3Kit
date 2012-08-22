//
//  Artisan.m
//  Diablo
//
//  Created by Ryan Nystrom on 6/14/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Artisan.h"

@implementation D3Artisan

+ (D3Artisan*)artisanWithJSON:(NSDictionary*)json
{
    if (! [NSThread isMainThread]) {
        D3Artisan *artisan = [[D3Artisan alloc] init];
        [artisan setSlug:[json objectForKey:@"slug"]];
        [artisan setLevel:((NSString*)[json objectForKey:@"level"]).integerValue];
        [artisan setStepCurrent:((NSString*)[json objectForKey:@"step-current"]).integerValue];
        [artisan setStepMax:((NSString*)[json objectForKey:@"step-max"]).integerValue];
        return artisan;
    }
    return nil;
}

@end
