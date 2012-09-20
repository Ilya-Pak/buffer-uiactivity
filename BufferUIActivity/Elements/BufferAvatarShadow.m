//
//  BufferAvatarShadow.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 17/09/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import "BufferAvatarShadow.h"
#import <QuartzCore/QuartzCore.h>

@implementation BufferAvatarShadow

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self drawBufferAvatarShadow];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self drawBufferAvatarShadow];
    }
    return self;
}


- (void)drawBufferAvatarShadow {
    self.layer.cornerRadius = 12.0f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 2.0;
    self.backgroundColor = [UIColor clearColor];
    self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.layer.shadowOpacity = 0.5f;
}

@end
