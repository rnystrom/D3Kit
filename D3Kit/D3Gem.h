//
//  D3Gem.h
//  D3Kit
//
//  Created by Ryan Nystrom on 9/2/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Object.h"
#import <UIKit/UIKit.h>

@interface D3Gem : D3Object

+ (D3Gem*)gemFromJSON:(NSDictionary*)json;

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *colorString;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *tooltipParam;
@property (copy, nonatomic) NSString *iconString;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSArray *attributes;

@end
