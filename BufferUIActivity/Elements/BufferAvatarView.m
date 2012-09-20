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
        self.opaque = NO;
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
    
    if([[bufferProfile valueForKey:@"service"] isEqualToString:@"twitter"]){
        networkImage = [UIImage imageNamed:@"twitter-icon.png"];
    }
    
    if([[bufferProfile valueForKey:@"service"] isEqualToString:@"facebook"]){
        networkImage = [UIImage imageNamed:@"facebook-icon.png"];
    }
    
    if([[bufferProfile valueForKey:@"service"] isEqualToString:@"gplus"]){
        networkImage = [UIImage imageNamed:@"gplus-icon.png"];
    }
    
    if([[bufferProfile valueForKey:@"service"] isEqualToString:@"linkedin"]){
        networkImage = [UIImage imageNamed:@"linkedin-icon.png"];
    }
    
    if([[bufferProfile valueForKey:@"service"] isEqualToString:@"appdotnet"]){
        networkImage = [UIImage imageNamed:@"appdotnet-icon.png"];
    }
    
    [networkImage drawInRect:CGRectMake(rect.size.width - 14, rect.size.height - 14, 13, 13)];
    
    self.layer.masksToBounds = YES;
    self.layer.opaque = NO;
    self.layer.cornerRadius = 6.0f;
}


@end
