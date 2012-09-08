//
//  D3Defines.m
//  Profiles for Diablo 3
//
//  Created by Ryan Nystrom on 8/15/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Defines.h"

#pragma mark - URL

NSString * const kD3BaseURL = @"http://us.battle.net/api/d3";
NSString * const kD3BaseRegionURL = @"http://%@.battle.net/api/d3";
NSString * const kD3APIProfileParam = @"profile";
NSString * const kD3APIHeroParam = @"hero";
NSString * const kD3DataParam = @"data";
NSString * const kD3MediaURL = @"http://us.media.blizzard.com/d3/icons";
NSString * const kD3ItemParam = @"items/large";
NSString * const kD3SkillParam = @"skills/64";

#pragma mark - Notifications

NSString * const kD3CareerNotification = @"com.nystromproductions.profiles.career";
NSString * const kD3LastHeroPlayedNotification = @"com.nystromproductions.profiles.last-hero-played";
NSString * const kD3DoorsAnimatedOffScreenNotification = @"com.nystromproductions.profiles.doors-offscreen";
NSString * const kD3DoorsHeroNotification = @"com.nystromproductions.profiles.hero";
NSString * const kD3DoorsItemNotification = @"com.nystromproductions.profiles.item";
NSString * const kD3CareerNotificationUserInfoKey = @"D3_UserInfo_Career";
NSString * const kD3HeroNotificationUserInfoKey = @"D3_UserInfo_Hero";

NSString * urlForRegion(NSString * region) {
    return [NSString stringWithFormat:kD3BaseRegionURL,region];
}