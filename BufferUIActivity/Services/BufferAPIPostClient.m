//
//  BufferAPIPostClient.m
//  Buffer
//
//  Created by Andrew Yates on 24/10/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import "BufferAPIPostClient.h"
#import "AFJSONRequestOperation.h"

@implementation BufferAPIPostClient


+ (BufferAPIPostClient *)sharedClient {
    static BufferAPIPostClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.bufferapp.com/1/"]];
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
    
    //[self setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    
    return self;
}

@end