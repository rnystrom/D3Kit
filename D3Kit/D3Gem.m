//
//  D3Gem.m
//  D3Kit
//
//  Created by Ryan Nystrom on 9/2/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "D3HTTPClient.h"
#import "D3Gem.h"

@implementation D3Gem

+ (D3Gem*)gemFromJSON:(NSDictionary*)json {
    D3Gem *gem = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        gem = [[D3Gem alloc] init];
        NSDictionary *itemJSON = json[@"item"];
        gem.attributes = [json[@"attributes"] copy];
        gem.ID = itemJSON[@"id"];
        gem.name = itemJSON[@"name"];
        gem.tooltipParam = itemJSON[@"tooltipParams"];
        gem.iconString = itemJSON[@"icon"];
    }
    return gem;
}


- (AFImageRequestOperation*)requestGemIconWithImageProcessingBlock:(UIImage* (^)(UIImage *image))imageProcessingBlock success:(D3GemImageRequestSuccess)success failure:(D3GemImageRequestFailure)failure {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@.png",kD3MediaURL,kD3ItemParam,self.iconString];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:imageProcessingBlock success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.icon = image;
            if (success) {
                success(request, response, image);
            }
        });
    } failure:failure];
    return operation;
}

@end
