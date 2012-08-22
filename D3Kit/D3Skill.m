//
//  Skill.m
//  Diablo
//
//  Created by Ryan Nystrom on 6/17/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Defines.h"
#import "D3Skill.h"

@interface D3Skill ()

+ (D3Skill*)skillFromJSON:(NSDictionary*)json;

@end

@implementation D3Skill

#pragma mark - Class methods

+ (D3Skill*)skillFromJSON:(NSDictionary *)json
{
    D3Skill *skill = [[D3Skill alloc] init];
    if ([json isKindOfClass:[NSDictionary class]]) {
        skill.description = json[@"description"];
        skill.simpleDescription = json[@"simpleDescription"];
        skill.flavor = json[@"flavor"];
        skill.iconString = json[@"icon"];
        skill.name = json[@"name"];
        skill.slug = json[@"slug"];
        skill.tooltipParams = json[@"tooltipUrl"];
        
        NSString *levelString = json[@"level"];
        skill.level = levelString.integerValue;
    }
    return skill;
}

+ (D3Skill*)activeSkillFromJSON:(NSDictionary*)json
{
    NSDictionary *skillJSON = json[@"skill"];
    NSDictionary *runeJSON = json[@"rune"];
    D3Skill *skill = [D3Skill skillFromJSON:skillJSON];
    skill.rune = [D3Rune runeFromJSON:runeJSON];
    skill.isActive = YES;
    return skill;
}

+ (D3Skill*)passiveSkillFromJSON:(NSDictionary*)json;
{
    D3Skill *skill = [D3Skill skillFromJSON:json[@"skill"]];
    skill.isActive = NO;
    return skill;
}


#pragma mark - Loading

- (AFImageRequestOperation*)requestIconWithImageProcessingBlock:(UIImage* (^)(UIImage *image))imageProcessingBlock success:(void (^)(NSURLRequest*, NSHTTPURLResponse*, UIImage*))success failure:(void (^)(NSURLRequest*, NSHTTPURLResponse*, NSError*))failure {
    if (! self.iconString) {
        return nil;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@.png",kD3MediaURL,kD3SkillParam,self.iconString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:imageProcessingBlock success:success failure:failure];
}


@end
