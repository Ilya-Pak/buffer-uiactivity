//
//  BufferUIActivity.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 14/06/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import "BufferUIActivity.h"
#import "BufferSheetViewController.h"

@implementation BufferUIActivity

@synthesize activityBufferItem;

- (NSString *)activityType {
    return @"Buffer";
}

- (NSString *)activityTitle {
    return @"Buffer";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"BufferIcon"];
}

- (UIViewController *)activityViewController {
    BufferSheetViewController *bufferSheetViewController = [[BufferSheetViewController alloc] init];
    
    bufferSheetViewController.bufferTextCopy = [NSString stringWithFormat:@"%@ %@", [self.activityBufferItem objectAtIndex:0], [self.activityBufferItem objectAtIndex:1]];
    
    bufferSheetViewController.bufferUIActivityDelegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: bufferSheetViewController];

    navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    return navController;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return TRUE;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    self.activityBufferItem = activityItems;
}

@end