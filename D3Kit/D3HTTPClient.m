//
//  D3HTTPClient.m
//  Profiles for Diablo 3
//
//  Created by Ryan Nystrom on 8/15/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3HTTPClient.h"

@implementation D3HTTPClient {
    dispatch_queue_t _callbackQueue;
}

#pragma mark - Singleton

+ (D3HTTPClient*)sharedClient {
	static D3HTTPClient *sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedClient = [[[self class] alloc] initWithBaseURL:[NSURL URLWithString:urlForRegion(@"us")]];
	});
	return sharedClient;
}


#pragma mark - NSObject

- (id)init {
    if (self = [super init]) {
        _callbackQueue = dispatch_queue_create("com.nystromproductions.profiles.network-callback-queue", 0);
    }
    return self;
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - AFHTTPClient

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
	NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
#ifdef D3_LOGGING_MODE
    NSLog(@"%@",request.URL);
#endif
	return request;
}


- (void)enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)operation {
	operation.successCallbackQueue = _callbackQueue;
	operation.failureCallbackQueue = _callbackQueue;
	[super enqueueHTTPRequestOperation:operation];
}


#pragma mark - JSON

- (void)getJSONPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, NSDictionary*))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    [self getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *parsingError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&parsingError];
        if (parsingError && failure) {
            failure(operation, parsingError);
        }
        else if (success) {
            success(operation, json);
        }
    } failure:failure];
}


@end