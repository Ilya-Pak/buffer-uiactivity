//
//  BufferSheetVignette.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 01/11/2012.
//  Copyright (c) 2012 Andrew Yates. All rights reserved.
//

#import "BufferSheetVignette.h"

@implementation BufferSheetVignette

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClipToRect(context, rect);
    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithWhite:0.0 alpha:0.5].CGColor, [UIColor colorWithWhite:0.0 alpha:1.0].CGColor, nil];
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, NULL);
    
    // Radial gradient
    float radius = MIN(rect.size.width, rect.size.height);
    CGPoint center = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);

	[super drawRect:rect];
}


@end
