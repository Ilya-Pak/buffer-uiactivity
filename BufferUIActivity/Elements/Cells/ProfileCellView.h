//
//  ProfileCellView.h
//  Buffer
//
//  Created by Andrew Yates on 07/11/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ProfileCellView : UIView {
    NSString *profileState;
    NSMutableArray *bufferProfile;
    BOOL highlighted;
	BOOL editing;
    BOOL moving;
}

@property (strong, nonatomic) NSMutableArray *bufferProfile;
@property (strong, nonatomic) NSString *profileState;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, getter=isEditing) BOOL editing;
@property (nonatomic) BOOL moving;

@end
