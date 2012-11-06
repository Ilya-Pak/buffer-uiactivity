//
//  BufferProfileSelectionBackground.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 05/11/2012.
//  Copyright (c) 2012 Andrew Yates. All rights reserved.
//

#import "BufferProfileSelectionBackground.h"

@implementation BufferProfileSelectionBackground

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        [self drawBufferProfileViewBackground];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.autoresizesSubviews = YES;
        [self drawBufferProfileViewBackground];
    }
    return self;
}


- (void)drawBufferProfileViewBackground {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        // Add a border and a shadow.
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
        self.layer.cornerRadius = 12.0f;
        self.layer.shadowOpacity = 0.9f;
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowRadius = 5.0f;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
}

@end
