//
//  BufferSheetTextView.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 18/09/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import "BufferSheetTextView.h"

@implementation BufferSheetTextView

// Thanks http://stackoverflow.com/questions/3492045/drawing-ruled-lines-on-a-uitextview-for-iphone and DETweeter

@synthesize rowHeight;
@synthesize lineWidth;
@synthesize lineColor;

#pragma mark - Setup & Teardown

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
        [self bufferSheetTextViewInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self bufferSheetTextViewInit];
    }
    
    return self;
}

- (void)bufferSheetTextViewInit {    
    self.backgroundColor = [UIColor clearColor];
    self.contentMode = UIViewContentModeRedraw;
    self.opaque = YES;
    
    self.rowHeight = 19.0f;
    self.lineWidth = 1.0f;
    self.lineColor = [UIColor colorWithWhite:0.3f alpha:0.15f];
}


#pragma mark - Superclass Overrides

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, self.lineWidth);
    CGFloat strokeOffset = (self.lineWidth / 2);
    
    if (self.rowHeight > 0.0f) {
        CGRect rowRect = CGRectMake(rect.origin.x, self.rowHeight+5, rect.size.width, self.rowHeight);
        NSInteger rowNumber = 1;
        while (rowRect.origin.y < self.frame.size.height + 500.0f) {
            CGContextMoveToPoint(context, rowRect.origin.x + strokeOffset, rowRect.origin.y + strokeOffset);
            CGContextAddLineToPoint(context, rowRect.origin.x + rowRect.size.width + strokeOffset, rowRect.origin.y + strokeOffset);
            CGContextDrawPath(context, kCGPathStroke);
            
            rowRect.origin.y += self.rowHeight;
            rowNumber++;
        }
    }
}

@end
