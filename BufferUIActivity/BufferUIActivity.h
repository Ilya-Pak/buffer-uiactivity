//
//  BufferUIActivity.h
//  BufferUIActivity
//
//  Created by Andrew Yates on 14/06/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BufferUIActivity : UIActivity {
    NSArray *activityBufferItem;
}

@property (strong, nonatomic) NSArray *activityBufferItem;

@end
