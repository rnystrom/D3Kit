//
//  Rune.m
//  Diablo
//
//  Created by Ryan Nystrom on 6/30/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Rune.h"

@implementation D3Rune

+ (D3Rune*)runeFromJSON:(NSDictionary *)json
{
    D3Rune *rune = [[D3Rune alloc] init];
    if ([json isKindOfClass:[NSDictionary class]]) {
        rune.description = json[@"description"];
        rune.simpleDescription = json[@"simpleDescription"];
        rune.type = json[@"type"];
        rune.iconString = json[@"icon"];
        rune.name = json[@"name"];
        rune.slug = json[@"slug"];
        rune.tooltipParams = json[@"tooltipParams"];
        rune.orderIndex = ((NSString*)json[@"orderIndex"]).integerValue;
    }
    return rune;
}

@end
