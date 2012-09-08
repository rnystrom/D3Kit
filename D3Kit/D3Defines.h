//
//  D3Defines.h
//  Profiles for Diablo 3
//
//  Created by Ryan Nystrom on 8/15/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

// Always use dev mode on simulator
#if !TARGET_IPHONE_SIMULATOR && !TARGET_OS_MAC
    #define D3_PRODUCTION_MODE 1
#endif

// Comment to disable logging
#define D3_LOGGING_MODE 1

extern NSString * const kD3BaseURL;
extern NSString * const kD3BaseRegionURL;
extern NSString * const kD3MediaURL;
extern NSString * const kD3APIProfileParam;
extern NSString * const kD3APIHeroParam;
extern NSString * const kD3DataParam;
extern NSString * const kD3ItemParam;
extern NSString * const kD3SkillParam;

extern NSString * const kD3CareerNotification;
extern NSString * const kD3CareerNotificationUserInfoKey;
extern NSString * const kD3HeroNotification;
extern NSString * const kD3HeroNotificationUserInfoKey;
extern NSString * const kD3LastHeroPlayedNotification;
extern NSString * const kD3DoorsAnimatedOffScreenNotification;
extern NSString * const kD3DoorsHeroNotification;
extern NSString * const kD3DoorsItemNotification;

extern NSString * urlForRegion(NSString * region);