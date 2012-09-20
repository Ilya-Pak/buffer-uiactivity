//
//  BufferAPIClient.m
//  Buffer
//
//  Created by Andrew Yates on 13/10/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import "BufferAPIClient.h"
#import "AFJSONRequestOperation.h"


@implementation BufferAPIClient

NSString * const BufferAPIBaseURLString = @"https://api.bufferapp.com/1/";

+ (BufferAPIClient *)sharedClient {
    static BufferAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:BufferAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end