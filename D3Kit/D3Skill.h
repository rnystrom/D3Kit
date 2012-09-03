//
//  Skill.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/17/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "AFImageRequestOperation.h"
#import "D3Rune.h"

@interface D3Skill : D3Object

+ (D3Skill*)activeSkillFromJSON:(NSDictionary*)json;
+ (D3Skill*)passiveSkillFromJSON:(NSDictionary*)json;

@property (strong, nonatomic) NSOperationQueue *queue;

@property (copy, nonatomic) NSString *description;
@property (copy, nonatomic) NSString *simpleDescription;
@property (copy, nonatomic) NSString *flavor;
@property (copy, nonatomic) NSString *iconString;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *slug;
@property (copy, nonatomic) NSString *tooltipParams;

@property (assign, nonatomic) NSInteger level;

@property (strong, nonatomic) D3Rune *rune;

@property (assign, nonatomic) BOOL isActive;

@property (strong, nonatomic) UIImage *icon;

- (AFImageRequestOperation*)requestIconWithImageProcessingBlock:(UIImage* (^)(UIImage *image))imageProcessingBlock success:(void (^)(NSURLRequest*, NSHTTPURLResponse*, UIImage*))success failure:(void (^)(NSURLRequest*, NSHTTPURLResponse*, NSError*))failure;

@end
