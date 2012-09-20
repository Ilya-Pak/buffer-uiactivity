//
//  ProfileCell.m
//  Buffer
//
//  Created by Andrew Yates on 07/11/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import "ProfileCell.h"
#import "ProfileCellView.h"

@implementation ProfileCell

@synthesize profileCellView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
		CGRect pcvFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
		profileCellView = [[ProfileCellView alloc] initWithFrame:pcvFrame];
		profileCellView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self.contentView addSubview:profileCellView];
        
        self.opaque = YES;
	}
	return self;
}


- (void)setBufferProfile:(NSMutableArray *)bufferProfile {
	profileCellView.bufferProfile = bufferProfile;
}

- (void)setState:(NSString *)profileState {
	profileCellView.profileState = profileState;
}

- (void)redisplay {
    profileCellView.moving = NO;
	[profileCellView setNeedsDisplay];
}

- (void)prepareForMove {
    profileCellView.moving = YES;
}

- (void)notMoving {
    profileCellView.moving = NO;
}


@end
