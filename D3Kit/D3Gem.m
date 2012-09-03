//
//  D3Gem.m
//  D3Kit
//
//  Created by Ryan Nystrom on 9/2/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Gem.h"

@implementation D3Gem

+ (D3Gem*)gemFromJSON:(NSDictionary*)json {
    D3Gem *gem = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        gem = [[D3Gem alloc] init];
        NSDictionary *itemJSON = json[@"item"];
        gem.attributes = [json[@"attributes"] copy];
        gem.ID = itemJSON[@"id"];
        gem.name = itemJSON[@"name"];
        gem.tooltipParam = itemJSON[@"tooltipParams"];
        gem.icon = itemJSON[@"icon"];
    }
    return gem;
}

@end
