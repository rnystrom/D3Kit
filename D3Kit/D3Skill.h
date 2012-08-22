//
//  Skill.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/17/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "AFImageRequestOperation.h"
#import "D3Rune.h"
#import "D3Object.h"

@interface D3Skill : D3Object

+ (D3Skill*)activeSkillFromJSON:(NSDictionary*)json;
+ (D3Skill*)passiveSkillFromJSON:(NSDictionary*)json;

@property (strong, nonatomic) NSOperationQueue *queue;

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *simpleDescription;
@property (strong, nonatomic) NSString *flavor;
@property (strong, nonatomic) NSString *iconString;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSString *tooltipParams;

@property (assign, nonatomic) NSInteger level;

@property (strong, nonatomic) D3Rune *rune;

@property (assign, nonatomic) BOOL isActive;

@property (strong, nonatomic) UIImage *icon;

- (AFImageRequestOperation*)requestIconWithImageProcessingBlock:(UIImage* (^)(UIImage *image))imageProcessingBlock success:(void (^)(NSURLRequest*, NSHTTPURLResponse*, UIImage*))success failure:(void (^)(NSURLRequest*, NSHTTPURLResponse*, NSError*))failure;

@end
