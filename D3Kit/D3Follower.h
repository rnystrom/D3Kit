//
//  Follower.h
//  Diablo
//
//  Created by Ryan Nystrom on 6/16/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Object.h"

@interface D3Follower : D3Object

+ (D3Follower*)followerFromJSON:(NSDictionary*)json;

@end
