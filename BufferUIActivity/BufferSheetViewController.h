//
//  BufferSheetViewController.h
//  BufferUIActivity
//
//  Created by Andrew Yates on 14/06/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BufferSheetBackground.h"
#import "CachingMethods.h"
#import "BufferAvatarView.h"

@interface BufferSheetViewController : UIViewController <UITextViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id bufferUIActivityDelegate;
@property (strong, nonatomic) UIViewController  *bufferPresentingView;
@property (nonatomic) UIInterfaceOrientation bufferPresentingViewOrientation;
@property (strong, nonatomic) IBOutlet UIImageView *bufferSheetBackgroundImage;

@property (strong, nonatomic) CachingMethods *bufferCache;
@property (strong, nonatomic) IBOutlet UIView *bufferSheetContainer;
@property (strong, nonatomic) IBOutlet UIView *bufferSheetErrorView;
@property (strong, nonatomic) IBOutlet UITextView *bufferSheetErrorLabel;
@property (strong, nonatomic) IBOutlet BufferSheetBackground *bufferSheetBackground;
@property (strong, nonatomic) IBOutlet UIButton *bufferAddButton;
@property (strong, nonatomic) IBOutlet UIScrollView *bufferTextViewContainer;
@property (strong, nonatomic) IBOutlet UITextView *bufferTextView;
@property (strong, nonatomic) IBOutlet UIButton *bufferProfileSelectionButton;
@property (strong, nonatomic) IBOutlet UIView *bufferProfileSelectionContainer;
@property (strong, nonatomic) IBOutlet UIView *bufferProfileSelectionView;
@property (strong, nonatomic) IBOutlet UIView *bufferProfileSelectionMask;
@property (strong, nonatomic) IBOutlet UITableView *bufferProfileSelectionTable;
@property (strong, nonatomic) NSMutableDictionary *bufferConfiguration;
@property (strong, nonatomic) NSMutableArray *bufferProfiles;
@property (strong, nonatomic) NSArray *bufferCharacterCountOrder;
@property (strong, nonatomic) NSMutableArray *bufferCharacterCount;
@property (strong, nonatomic) NSString *bufferActiveCharacterCount;
@property (strong, nonatomic) IBOutlet UILabel *bufferCharLabel;
@property (strong, nonatomic) IBOutlet UILabel *bufferProfileCountLabel;

@property (strong, nonatomic) IBOutlet BufferAvatarView *avatarView1;
@property (strong, nonatomic) IBOutlet BufferAvatarView *avatarView2;
@property (strong, nonatomic) IBOutlet BufferAvatarView *avatarView3;

@property (strong, nonatomic) IBOutlet UIView *avatar1Container;
@property (strong, nonatomic) IBOutlet UIView *avatar2Container;
@property (strong, nonatomic) IBOutlet UIView *avatar3Container;

@property (nonatomic) BOOL profileSelectionActive;

@property (strong, nonatomic) NSMutableArray *selectedProfiles;
@property (strong, nonatomic) NSMutableArray *selectedProfilesIndexes;

@property (strong, nonatomic) NSString *bufferTextCopy;
@property (strong, nonatomic) NSString *bufferUnshortenedLink;

@property (strong, nonatomic) UILabel *selectedProfileCount;

-(IBAction)toggleProfileSelection:(id)sender;

@end
