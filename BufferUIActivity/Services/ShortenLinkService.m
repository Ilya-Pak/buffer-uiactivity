//
//  ShortenLinkService.m
//  Buffer
//
//  Created by Andrew Yates on 23/12/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import "ShortenLinkService.h"
#import "BufferAPIClient.h"

@implementation ShortenLinkService

-(void)shortenLink:(NSString *)link withSender:(id)sender {
    
    NSString *access_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"buffer_accesstoken"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@", link];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"Http://" withString:@""];
    
    NSString *path = [NSString stringWithFormat:@"links/shorten.json?access_token=%@&url=%@", access_token, urlString];
    
    [[BufferAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *shortened_url = [[NSMutableDictionary alloc] init];
        [shortened_url setValue: link forKey:@"original"];
        [shortened_url setValue: [responseObject valueForKey:@"url"] forKey:@"shortened"];
        
        // Return the Shortened URL
        [sender performSelector:@selector(replaceShortenedURL:) withObject:shortened_url];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [sender performSelector:@selector(shortenLinksFailed)];
    }];
}

@end
