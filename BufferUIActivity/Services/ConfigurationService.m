//
//  ConfigurationService.m
//  Buffer
//
//  Created by Andrew Yates on 04/10/2012.
//
//

#import "ConfigurationService.h"
#import "BufferAPIClient.h"

@implementation ConfigurationService

-(void)getConfigurationWithSender:(id)sender {
    
    NSString *access_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"buffer_accesstoken"];
    NSString *path = [NSString stringWithFormat:@"info/configuration.json?access_token=%@", access_token];
    
    [[BufferAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [sender performSelector:@selector(loadConfiguration:) withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@", error);
    }];
}

@end
