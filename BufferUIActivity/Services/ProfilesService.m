//
//  AccountsService.m
//  Buffer
//
//  Created by Andrew Yates on 02/10/2011.
//  Copyright 2011 Buffer, Inc. All rights reserved.
//

#import "ProfilesService.h"
#import "BufferAPIClient.h"

@implementation ProfilesService

-(void)getBufferProfiles:(id)sender {
    NSString *access_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"buffer_accesstoken"];
    NSString *path = [NSString stringWithFormat:@"profiles.json?access_token=%@", access_token];
    
    [[BufferAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [sender performSelector:@selector(loadBufferProfiles:) withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
    }]; 
}

@end