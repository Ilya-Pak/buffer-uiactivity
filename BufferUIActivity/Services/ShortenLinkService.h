//
//  ShortenLinkService.h
//  Buffer
//
//  Created by Andrew Yates on 23/12/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShortenLinkService : NSObject {
}

-(void)shortenLink:(NSString *)link withSender:(id)sender;

@end
