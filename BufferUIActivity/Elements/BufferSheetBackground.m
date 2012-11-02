//
//  BufferSheetBackground.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 17/09/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import "BufferSheetBackground.h"
#import <QuartzCore/QuartzCore.h>

@implementation BufferSheetBackground

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        [self drawBufferSheetbackground];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.autoresizesSubviews = YES;
        [self drawBufferSheetbackground];
    }
    return self;
}


- (void)drawBufferSheetbackground {
    // Add a border and a shadow.
    self.layer.cornerRadius = 12.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:1.0f].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    self.layer.shadowRadius = 5.0f;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    
    self.sheetBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.sheetBackgroundView.layer.masksToBounds = YES;
    self.sheetBackgroundView.layer.cornerRadius = self.layer.cornerRadius + 1.0f;
    self.sheetBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BufferSheetBackground.png"]];
    self.sheetBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self insertSubview:self.sheetBackgroundView atIndex:0];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.sheetBackgroundView.frame = self.bounds;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
}

@end
