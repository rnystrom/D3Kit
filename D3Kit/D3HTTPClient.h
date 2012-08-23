//
//  D3HTTPClient.h
//  Profiles for Diablo 3
//
//  Created by Ryan Nystrom on 8/15/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3Defines.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "D3Career.h"

typedef void (^D3HTTPClientSuccess)(AFJSONRequestOperation *operation, id responseObject);
typedef void (^D3HTTPClientFailure)(AFJSONRequestOperation *operation, NSError *error);

@interface D3HTTPClient : AFHTTPClient

+(D3HTTPClient*)sharedClient;

- (void)getJSONPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, NSDictionary*))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

@end