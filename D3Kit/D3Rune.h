//
//  Rune.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/30/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Object.h"

@interface D3Rune : D3Object

+ (D3Rune*)runeFromJSON:(NSDictionary *)json;

@property (copy, nonatomic) NSString *description;
@property (copy, nonatomic) NSString *simpleDescription;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *iconString;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *slug;
@property (copy, nonatomic) NSString *tooltipParams;
@property (assign, nonatomic) NSInteger orderIndex;

@end
