//
//  FirstViewController.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 14/06/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import "FirstViewController.h"
#import "BufferUIActivity.h"
#import "BufferSheetViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}




-(IBAction)openUIActivityView:(id)sender {
    NSString *text = @"Hello world";
    NSString *url = @"http://bufferapp.com";
    
    
    NSArray *activityItems = @[text, url];
    
    BufferUIActivity *bufferActivity = [[BufferUIActivity alloc] init];
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[ bufferActivity ]];
    
    [self presentViewController:activityView animated:YES completion:^{
        
    }];
}


-(IBAction)openBufferSheet:(id)sender {
    NSString *text = @"Hello world http://bufferapp.com";
    
    BufferSheetViewController *bufferSheet = [[BufferSheetViewController alloc] init];
    
    bufferSheet.bufferTextCopy = text;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: bufferSheet];
    
    navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:navController animated:YES completion:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return YES;
}

@end
