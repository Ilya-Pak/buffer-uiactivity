//
//  BufferAvatarView.h
//  BufferUIActivity
//
//  Created by Andrew Yates on 17/09/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachingMethods.h"

@interface BufferAvatarView : UIView {
    NSMutableArray *bufferProfile;
    CachingMethods *bufferCache;
}

@property (strong, nonatomic) NSMutableArray *bufferProfile;
@property (strong, nonatomic) CachingMethods *bufferCache;

@end
