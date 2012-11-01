//
//  BufferProfileSelectionBackground.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 01/11/2012.
//  Copyright (c) 2012 Andrew Yates. All rights reserved.
//

#import "BufferProfileSelectionBackground.h"

@implementation BufferProfileSelectionBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius = 12.0f;
    //self.layer.borderWidth = 1.0f;
    //self.layer.borderColor = [UIColor colorWithWhite:0.0f alpha:1.0f].CGColor;
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    self.layer.shadowRadius = 5.0f;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
}

@end
