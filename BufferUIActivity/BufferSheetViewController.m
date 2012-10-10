//
//  BufferSheetViewController.m
//  BufferUIActivity
//
//  Created by Andrew Yates on 14/06/2012.
//  Copyright (c) 2012 Buffer Inc. All rights reserved.
//

#import "BufferSheetViewController.h"
#import "ProfilesService.h"
#import "PostUpdateService.h"
#import "ConfigurationService.h"
#import "TwitterText.h"
#import "ProfileCell.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMOAuth2SignIn.h"

@implementation BufferSheetViewController

@synthesize bufferUIActivityDelegate, bufferSheetContainer, bufferAddButton, bufferSheetErrorView, bufferSheetErrorLabel, bufferSheetBackground, bufferTextViewContainer, bufferTextView, bufferProfileSelectionView, bufferProfileSelectionTable, bufferConfiguration, bufferProfiles, bufferCharLabel, bufferTextCopy, bufferProfileCountLabel, bufferCache, bufferCharacterCountOrder;
@synthesize avatar1Container, avatar2Container, avatar3Container, avatarView1, avatarView2, avatarView3;
@synthesize profileSelectionActive;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [bufferProfileSelectionView setHidden:YES];
    
    bufferTextView.backgroundColor = [UIColor clearColor];
    
    [bufferTextView becomeFirstResponder];
    
    profileSelectionActive = YES;
    
    bufferCache = [[CachingMethods alloc] init];
    
    if(bufferTextCopy){
        bufferTextView.text = bufferTextCopy;
    }
    
    self.selectedProfiles = [[NSMutableArray alloc] init];
    self.selectedProfilesIndexes = [[NSMutableArray alloc] init];
    
    [self updateAvatarStack];
    
    if(![[NSUserDefaults standardUserDefaults] stringForKey:@"buffer_accesstoken"]){
        [self performSelector:@selector(presentAuth) withObject:nil afterDelay:0.1];
    } else {
        [NSThread detachNewThreadSelector:@selector(getConfiguration) toTarget:self withObject:nil];
        [NSThread detachNewThreadSelector:@selector(getProfiles) toTarget:self withObject:nil];
    }
    
    [self performSelector:@selector(animateSheetIn) withObject:nil afterDelay:0.4];
    
    self.bufferActiveCharacterCount = @"";
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = TRUE;
}

-(void)animateSheetIn {
    [bufferSheetContainer setHidden:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        bufferSheetContainer.frame = CGRectMake(0, 0, 320, 245);
    } completion:^(BOOL finished) {
        [bufferProfileSelectionView setHidden:NO];
        [avatar1Container setHidden:NO];
        [avatar2Container setHidden:NO];
        [avatar3Container setHidden:NO];
    }];
}


#pragma mark - Buffer OAuth

-(GTMOAuth2Authentication *)authForBuffer {
    // Add your Buffer Client ID and Secret Here
    NSString *clientID = @"";
    NSString *clientSecret = @"";
    
    NSURL *tokenURL = [NSURL URLWithString:@"https://api.bufferapp.com/1/oauth2/token.json"];
    
    NSString *redirectURI = @"urn:ietf:wg:oauth:2.0:oob";
    
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2Authentication authenticationWithServiceProvider:@"Buffer"
                                                             tokenURL:tokenURL
                                                          redirectURI:redirectURI
                                                             clientID:clientID
                                                         clientSecret:clientSecret];
    
    return auth;
}

-(void)presentAuth {
    GTMOAuth2Authentication *auth = [self authForBuffer];
    
    NSURL *authURL = [NSURL URLWithString:@"https://bufferapp.com/oauth2/authorize"];
    
    SEL sel = @selector(oauth2ViewController:finishedWithAuth:error:);
    
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [GTMOAuth2ViewControllerTouch controllerWithAuthentication:auth
                                                               authorizationURL:authURL
                                                               keychainItemName:nil
                                                                       delegate:self
                                                               finishedSelector:sel];
    
    [viewController setBrowserCookiesURL:[NSURL URLWithString:@"https://bufferapp.com/"]];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController pushViewController:viewController animated:NO];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    viewController.navigationItem.leftBarButtonItem = backButton;
}

- (void)oauth2ViewController:(GTMOAuth2ViewControllerTouch *)viewController
            finishedWithAuth:(GTMOAuth2Authentication *)auth
                       error:(NSError *)error {
    if (error != nil) {
        NSLog(@"Error: %@", error);
    } else {
        
        NSUserDefaults *accountAccessToken = [NSUserDefaults standardUserDefaults];
        [accountAccessToken setObject:auth.accessToken forKey:@"buffer_accesstoken"];
        [accountAccessToken synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenRetrieved" object:nil];
        
        [NSThread detachNewThreadSelector:@selector(getProfiles) toTarget:self withObject:nil];
        
    }
}


#pragma mark - Get Profiles

-(void)getProfiles {
    @autoreleasepool {
        
        // Load Cached Profiles
        self.bufferProfiles = [self.bufferCache getCachedProfiles];
        
        if([self.bufferProfiles isKindOfClass:[NSArray class]] && [self.bufferProfiles count] != 0){
            [NSThread detachNewThreadSelector:@selector(loadBufferProfilesIntoView) toTarget:self withObject:nil];
        }
        
        // Reload Profiles
        ProfilesService *service = [[ProfilesService alloc] init];
        [service getBufferProfiles:self];
    }
}

-(void)loadBufferProfiles:(NSMutableArray *)loaded_profiles {
    if(![self.bufferProfiles isEqualToArray: loaded_profiles]){
        self.bufferProfiles = loaded_profiles;
        [bufferCache cacheProfileList:self.bufferProfiles];
    }
    [NSThread detachNewThreadSelector:@selector(loadBufferProfilesIntoView) toTarget:self withObject:nil];
}

-(void)loadBufferProfilesIntoView {
    @autoreleasepool {
        
        [self.selectedProfiles removeAllObjects];
        [self.selectedProfilesIndexes removeAllObjects];
        
        // Select Default Profiles
        for (int i = 0; i < self.bufferProfiles.count; i++) {
            NSString *avatar = [[bufferProfiles objectAtIndex:i] valueForKey:@"avatar"];
            
            
            NSString *imagePath = [NSString stringWithFormat:@"%@/%@", [bufferCache offlineCachePath], [[self.bufferProfiles objectAtIndex:i] valueForKey:@"id"]];
            
            BOOL avatarExists = [[NSFileManager defaultManager] fileExistsAtPath:imagePath];
            if(!avatarExists){
                [bufferCache addAvatartoCacheforProfile:[[self.bufferProfiles objectAtIndex:i] valueForKey:@"id"] fromURL:avatar];
            }
            
            if([[[[self.bufferProfiles objectAtIndex:i] valueForKey:@"default"] stringValue] isEqualToString:@"1"]){
                [self.selectedProfiles addObject:[[self.bufferProfiles objectAtIndex:i] valueForKey:@"id"]];
                [self.selectedProfilesIndexes addObject:[NSString stringWithFormat:@"%d", i]];
            }
        }
        
        bufferProfileCountLabel.text = [NSString stringWithFormat:@"%d", [self.selectedProfiles count]];
        
        [self updateAvatarStack];
        
        [self detectCharacterLimit];
        [bufferProfileSelectionTable reloadData];
    }
}


#pragma mark - Get Configuration

-(void)getConfiguration {
    if([[bufferCache getCachedConfiguration] count] != 0){
        self.bufferConfiguration = [bufferCache getCachedConfiguration];
        
        // Set up for character count order.
        [self loadConfiguration:self.bufferConfiguration];
    }
    
    ConfigurationService *service = [[ConfigurationService alloc] init];
    [service getConfigurationWithSender:self];
}

-(void)loadConfiguration:(NSMutableArray *)loaded_configuration {
    if(![self.bufferConfiguration isEqualToArray: loaded_configuration]){
        self.bufferConfiguration = loaded_configuration;
        [bufferCache cacheConfiguration:self.bufferConfiguration];
        [self updateAvatarStack];
    }
    
    // Get services and load Character counts. Reiterate over them to order them smallest to biggest which we'll then use to activate the correct count.
    NSMutableArray *services = [self.bufferConfiguration valueForKey:@"services"];
    NSArray *serviceNames = [[self.bufferConfiguration valueForKey:@"services"] allKeys];
    
    NSMutableArray *serviceCharacterCounts = [[NSMutableArray alloc] init];
    for(NSString *service in serviceNames){
        [serviceCharacterCounts addObject:(NSNumber *)[[services valueForKey:service] valueForKey:@"character_limit"]];
    }
    
    
    
    // Tidy this up!
    NSDictionary *dataSourceDict = [NSDictionary dictionaryWithObjects:serviceCharacterCounts
                                                           forKeys:serviceNames];
    
    NSSortDescriptor *scoreSort = [NSSortDescriptor sortDescriptorWithKey:@"COUNT" ascending:YES];
    NSSortDescriptor *wordSort = [NSSortDescriptor sortDescriptorWithKey:@"SERVICE" ascending:NO];
    NSArray *sorts = [NSArray arrayWithObjects:scoreSort, wordSort, nil];
    
    
    NSMutableArray *unsortedArrayOfDict = [NSMutableArray array];
    
    for (NSString *word in dataSourceDict) {
        NSString *score = [dataSourceDict objectForKey:word];
        [unsortedArrayOfDict addObject: [NSDictionary dictionaryWithObjectsAndKeys:word, @"SERVICE", score, @"COUNT",  nil]];
    }
    
    NSArray *sortedArrayOfDict = [unsortedArrayOfDict sortedArrayUsingDescriptors:sorts];
    
    NSDictionary *sortedDict = [sortedArrayOfDict valueForKeyPath:@"SERVICE"];
    
    NSLog(@"%@", sortedDict);
    self.bufferCharacterCountOrder = (NSArray *)sortedDict;
    
}


// Profile Selection Table
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bufferProfiles.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    ProfileCell *profile_cell = (ProfileCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    BufferAvatarView *avatarView;
    
    if (profile_cell == nil) {
        profile_cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        avatarView = [[BufferAvatarView alloc] initWithFrame:CGRectMake(12, 10, 40, 40)];
        [avatarView setTag:123];
    } else {
        avatarView = (BufferAvatarView *)[profile_cell viewWithTag:123];
    }
    
    NSMutableArray* obj = [self.bufferProfiles objectAtIndex:indexPath.row];
    [profile_cell setBufferProfile:obj];
    [avatarView setBufferProfile:obj];
    
    if([self.selectedProfiles indexOfObject:[obj valueForKey:@"id"]] != NSNotFound){
        [profile_cell setState:@"selected"];
    } else {
        [profile_cell setState:@""];
    }
    
    profile_cell.accessibilityLabel = [NSString stringWithFormat:@"%@ %@", [obj valueForKey:@"service_username"], [obj valueForKey:@"service"]];
    
    [profile_cell addSubview:avatarView];
    
    avatarView = nil;
    
    return profile_cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self toggleAccountWithIndex:[NSString stringWithFormat:@"%d", indexPath.row]];
    
}

#pragma mark - Account Selection
-(void)toggleAccountWithIndex:(NSString *)index {
    if([self.selectedProfilesIndexes indexOfObject:index] != NSNotFound){
        [self.selectedProfilesIndexes removeObjectAtIndex:[self.selectedProfilesIndexes indexOfObject:index]];
    } else {
        [self.selectedProfilesIndexes addObject:index];
    }
    
    NSString *profileID = [[self.bufferProfiles objectAtIndex:(NSInteger)[index intValue]] valueForKey:@"id"];
    
    if([self.selectedProfiles indexOfObject:profileID] != NSNotFound){
        [self.selectedProfiles removeObjectAtIndex:[self.selectedProfiles indexOfObject:profileID]];
    } else {
        [self.selectedProfiles addObject:profileID];
    }
    
    bufferProfileCountLabel.text = [NSString stringWithFormat:@"%d", [self.selectedProfiles count]];
    
    [bufferProfileSelectionTable reloadData];
    [self detectCharacterLimit];
    [self updateAvatarStack];
}

-(void)updateAvatarStack {
    [self rotateImage:avatar2Container duration:0.2 curve:0 degrees:0];
    [self rotateImage:avatar3Container duration:0.2 curve:0 degrees:0];
    
    if([self.selectedProfiles count] == 0){
        [avatarView1 setBufferProfile:nil];
        
        [UIView animateWithDuration:1 animations:^{
            avatarView2.alpha = 0;
            avatarView3.alpha = 0;
        }];
        
        [avatarView2 setBufferProfile:nil];
        [avatarView3 setBufferProfile:nil];
        
    } else if([self.selectedProfiles count] == 1){
        [avatarView1 setBufferProfile:[self.bufferProfiles objectAtIndex:(NSInteger)[[self.selectedProfilesIndexes objectAtIndex:0] intValue]]];
        
        [UIView animateWithDuration:0.3 animations:^{
            avatarView2.alpha = 0;
            avatarView3.alpha = 0;
        } completion:^(BOOL finished) {
            [avatarView2 setBufferProfile:nil];
            [avatarView3 setBufferProfile:nil];
        }];
    } else if([self.selectedProfiles count] == 2){
        [avatarView1 setBufferProfile:[self.bufferProfiles objectAtIndex:(NSInteger)[[self.selectedProfilesIndexes objectAtIndex:0] intValue]]];
        [avatarView2 setBufferProfile:[self.bufferProfiles objectAtIndex:(NSInteger)[[self.selectedProfilesIndexes objectAtIndex:1] intValue]]];
        
        [UIView animateWithDuration:0.3 animations:^{
            avatarView2.alpha = 1;
            avatarView3.alpha = 0;
        } completion:^(BOOL finished) {
            [avatarView3 setBufferProfile:nil];
        }];
        
        [self rotateImage:avatar2Container duration:0.6 curve:0 degrees:15];
        
    } else if([self.selectedProfiles count] > 2){
        [avatarView1 setBufferProfile:[self.bufferProfiles objectAtIndex:(NSInteger)[[self.selectedProfilesIndexes objectAtIndex:0] intValue]]];
        [avatarView2 setBufferProfile:[self.bufferProfiles objectAtIndex:(NSInteger)[[self.selectedProfilesIndexes objectAtIndex:1] intValue]]];
        [avatarView3 setBufferProfile:[self.bufferProfiles objectAtIndex:(NSInteger)[[self.selectedProfilesIndexes objectAtIndex:2] intValue]]];
        
        [UIView animateWithDuration:0.6 animations:^{
            avatarView2.alpha = 1;
            avatarView3.alpha = 1;
        }];
        
        [self rotateImage:avatar2Container duration:0.6 curve:0 degrees:15];
        [self rotateImage:avatar3Container duration:0.6 curve:0 degrees:-10];
    }
}


// This is defined in Math.h
#define M_PI   3.14159265358979323846264338327950288   /* pi */

// Our conversion definition
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

- (void)rotateImage:(UIView *)view duration:(NSTimeInterval)duration curve:(int)curve degrees:(CGFloat)degrees {
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    view.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}


#pragma mark - Character Counts
-(void)detectCharacterLimit {
    // Loop through the character counts from smallest to biggest checking whether a profile of that type is selected.
    for (NSString *service in self.bufferCharacterCountOrder) {
                
        if([self isServiceAccountActive:service]){
                        
            if([service isEqualToString:@"twitter"]){
                bufferCharLabel.text = [NSString stringWithFormat:@"%d", [TwitterText remainingCharacterCount:bufferTextView.text]];
            } else {
                bufferCharLabel.text = [NSString stringWithFormat:@"%d", [self remainingCharacterCountForService:service]];
            }
            
            // Set the smallest active account type as active character count
            self.bufferActiveCharacterCount = service;
            [bufferCharLabel setHidden:NO];
            return;
        }
    }
    
    [bufferCharLabel setHidden:YES];
}

-(BOOL)isServiceAccountActive:(NSString *)service {
    for (NSString * profile_id in self.selectedProfiles) {
        for (NSMutableArray* profile in self.bufferProfiles) {
            if([[profile valueForKey:@"id"] isEqualToString:profile_id]){
                if([[profile valueForKey:@"service"] isEqualToString:service]){
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}

-(int)remainingCharacterCountForService:(NSString *)service {
    int service_character_limit = [[[[self.bufferConfiguration valueForKey:@"services"] valueForKey:service] valueForKey:@"character_limit"] intValue];
    
    int count = service_character_limit - bufferTextView.text.length;
    return count;
}

- (void)textViewDidChange:(UITextView *)textView {
    if([self.bufferActiveCharacterCount isEqualToString:@"twitter"]){
        bufferCharLabel.text = [NSString stringWithFormat:@"%d", [TwitterText remainingCharacterCount:bufferTextView.text]];
    } else {
        bufferCharLabel.text = [NSString stringWithFormat:@"%d", [self remainingCharacterCountForService:self.bufferActiveCharacterCount]];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self toggleProfileSelection];
}

- (void)scrollViewDidScroll:(id)scrollView {
    if(scrollView == bufferTextView){
        [bufferTextViewContainer setContentOffset:bufferTextView.contentOffset];
    }
}

// Add to Buffer
-(void)addUpdate {
    
    if([self.selectedProfiles count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"No Profiles Selected"
                                                        message: @"Select a profile to add this update to."
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    } else if([bufferTextView.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"No update content"
                                                        message: @"Please add some content to this update."
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    } else if([self.bufferActiveCharacterCount isEqualToString:@"twitter"] && [TwitterText remainingCharacterCount:bufferTextView.text] < 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Update too long"
                                                        message: @"Please reduce the number of characters."
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    } else if(![self.bufferActiveCharacterCount isEqualToString:@"twitter"] && [self remainingCharacterCountForService:self.bufferActiveCharacterCount] < 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Update too long"
                                                        message: @"Please reduce the number of characters."
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    } else {
        [bufferAddButton setHidden:YES];
        
        PostUpdateService *service = [[PostUpdateService alloc] init];
        [service postUpdate:bufferTextView.text forProfiles:self.selectedProfiles sendNow:FALSE withSender:self];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)updatePosted {
    if([bufferUIActivityDelegate respondsToSelector: @selector(activityDidFinish:)]){
        [bufferUIActivityDelegate activityDidFinish:YES];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)errorAddingUpdate:(NSString *)error {
    bufferSheetErrorLabel.text = error;
    
    [bufferAddButton setHidden:NO];
        
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:bufferSheetContainer
							 cache:YES];
	[bufferSheetBackground addSubview:bufferSheetErrorView];
	[UIView commitAnimations];
}


#pragma mark - Button Actions

-(IBAction)toggleProfileSelection:(id)sender {
    [self toggleProfileSelection];
}

-(void)toggleProfileSelection {    
    if(profileSelectionActive){
        [bufferTextView becomeFirstResponder];
        profileSelectionActive = NO;
    } else {
        [bufferTextView resignFirstResponder];
        profileSelectionActive = YES;
    }
}

-(IBAction)errorDismissed:(id)sender {
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
						   forView:bufferSheetContainer
							 cache:YES];
	[bufferSheetErrorView removeFromSuperview];
	[UIView commitAnimations];
}

-(IBAction)addToBuffer:(id)sender {
    [self addUpdate];
}

-(IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if([bufferUIActivityDelegate respondsToSelector: @selector(activityDidFinish:)]){
        [bufferUIActivityDelegate activityDidFinish:YES];
    }
}

#pragma mark - Orientation Changes

-(void)viewWillLayoutSubviews {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self rotateViewWithOrientation:orientation];
    [bufferProfileSelectionTable reloadData];
}

-(void)rotateViewWithOrientation:(UIInterfaceOrientation)orientation {
    bufferSheetContainer.frame = CGRectMake(0, 0, self.view.frame.size.width, 245);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        if(UIInterfaceOrientationIsPortrait(orientation)){
            bufferSheetBackground.frame = CGRectMake((self.view.frame.size.width/2) - 250, 25,  500, 190);
            bufferProfileSelectionView.frame = CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 250);
        }
        if(UIInterfaceOrientationIsLandscape(orientation)){
            bufferSheetBackground.frame = CGRectMake((self.view.frame.size.width/2) - 250, 10, 500, 190);
            bufferProfileSelectionView.frame = CGRectMake(0, self.view.frame.size.height - 250, self.view.frame.size.width, 250);
        }
    } else {
        if(UIInterfaceOrientationIsPortrait(orientation)){            
            bufferSheetBackground.frame = CGRectMake(8, 25, 320 - 16, 190);
            bufferProfileSelectionView.frame = CGRectMake(0, self.view.frame.size.height - 215, 320, 215);
        }
        
        if(UIInterfaceOrientationIsLandscape(orientation)){
            bufferSheetBackground.frame = CGRectMake((self.view.frame.size.width/2) - 232, 5, 480 - 16, 128);
            bufferProfileSelectionView.frame = CGRectMake(0, self.view.frame.size.height - 162, self.view.frame.size.width, 162);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
