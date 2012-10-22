//
//  PostUpdateService.h
//  Buffer
//
//  Created by Andrew Yates on 08/10/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostUpdateService : NSObject

-(void)postUpdate:(NSString *)update_text forProfiles:(NSArray *)profiles withShortening:(BOOL)shortening withSender:(id)sender;

@end
