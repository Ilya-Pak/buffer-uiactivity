//
//  BufferAPIClient.h
//  Buffer
//
//  Created by Andrew Yates on 13/10/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface BufferAPIClient : AFHTTPClient
+ (BufferAPIClient *)sharedClient;
@end
