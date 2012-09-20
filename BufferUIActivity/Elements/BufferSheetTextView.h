//
//  BufferSheetTextView.h
//  BufferUIActivity
//
//  Created by Andrew Yates on 18/09/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BufferSheetTextView : UITextView

@property (nonatomic) CGFloat rowHeight;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, retain) UIColor *lineColor;

@end
