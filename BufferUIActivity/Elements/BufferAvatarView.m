//
//  BufferAvatarView.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 17/09/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import "BufferAvatarView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BufferAvatarView

@synthesize bufferProfile, bufferCache;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
    }
    return self;
}

- (void)setBufferProfile:(NSMutableArray *)newBufferProfile {
	if (bufferProfile != newBufferProfile) {
		bufferProfile = newBufferProfile;
    }
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    bufferCache = [[CachingMethods alloc] init];
    
    [[UIColor whiteColor] setFill];
    UIRectFill( CGRectMake(1, 1, rect.size.width-2, rect.size.height-2) );
    
    
    NSString *avatarPath = [NSString stringWithFormat:@"%@/%@", [bufferCache offlineCachePath], [bufferProfile valueForKey:@"id"]];
    
    UIImage *avatarImage = nil;
    avatarImage = [UIImage imageWithContentsOfFile:avatarPath];
    [avatarImage drawInRect:CGRectMake(1, 1, rect.size.width-2, rect.size.height-2)];
    
    UIImage *networkImage = nil;
    NSString *networkIconPath;
    
    // Retina use 64px icons, else use 32px icons
    if ([[UIScreen mainScreen] scale] == 2.0) {
        networkIconPath = [NSString stringWithFormat:@"%@/%@-64", [bufferCache offlineCachePath], [bufferProfile valueForKey:@"service"]];
        
    } else {
        networkIconPath = [NSString stringWithFormat:@"%@/%@-32", [bufferCache offlineCachePath], [bufferProfile valueForKey:@"service"]];
    }
    
    networkImage = [UIImage imageWithContentsOfFile:networkIconPath];
    
    [networkImage drawInRect:CGRectMake(rect.size.width - 32, rect.size.height - 32, 32, 32)];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6.0f;
    self.layer.opaque = NO;
}


@end
