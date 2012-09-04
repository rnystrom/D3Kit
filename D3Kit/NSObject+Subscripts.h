//
//  NSObjec+Subscripts.h
//  D3Kit
//
//  Created by Ryan Nystrom on 9/4/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

@interface NSObject(subscripts)

- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
- (id)objectForKeyedSubscript:(id)key;

@end
