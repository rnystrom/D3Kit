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

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *simpleDescription;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *iconString;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSString *tooltipParams;
@property (assign, nonatomic) NSInteger orderIndex;

@end
