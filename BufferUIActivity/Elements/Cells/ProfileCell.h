//
//  ProfileCell.h
//  Buffer
//
//  Created by Andrew Yates on 07/11/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

@class ProfileCellView;

@interface ProfileCell : UITableViewCell {
    ProfileCellView *profileCellView;
}

@property (nonatomic, strong) ProfileCellView *profileCellView;

- (void)setBufferProfile:(NSMutableArray *)bufferProfile;
- (void)setState:(NSString *)profileState;
- (void)redisplay;
- (void)prepareForMove;
- (void)notMoving;

@end