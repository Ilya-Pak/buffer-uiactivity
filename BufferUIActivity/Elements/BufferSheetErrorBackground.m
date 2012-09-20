//
//  BufferSheetErrorBackground.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 19/09/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import "BufferSheetErrorBackground.h"
#import <QuartzCore/QuartzCore.h>

@implementation BufferSheetErrorBackground

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
}

@end
