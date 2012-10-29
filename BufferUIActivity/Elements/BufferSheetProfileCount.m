//
//  BufferSheetProfileCount.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 29/10/2012.
//  Copyright (c) 2012 Andrew Yates. All rights reserved.
//

#import "BufferSheetProfileCount.h"

@implementation BufferSheetProfileCount

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    UIImage *countBG = [[UIImage imageNamed:@"BufferProfileCountBG.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [countBG drawInRect:rect];
}

@end
