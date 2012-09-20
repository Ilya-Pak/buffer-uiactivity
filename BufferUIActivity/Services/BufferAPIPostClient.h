//
//  BufferAPIPostClient.h
//  Buffer
//
//  Created by Andrew Yates on 24/10/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface BufferAPIPostClient : AFHTTPClient
+ (BufferAPIPostClient *)sharedClient;
@end
