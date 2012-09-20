//
//  ProfileCellView.m
//  Buffer
//
//  Created by Andrew Yates on 07/11/2011.
//  Copyright (c) 2011 Buffer, Inc. All rights reserved.
//

#import "ProfileCellView.h"

@implementation ProfileCellView

@synthesize highlighted;
@synthesize editing;
@synthesize moving;
@synthesize bufferProfile;
@synthesize profileState;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.opaque = YES;
		self.backgroundColor = [UIColor whiteColor];
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
	}
	return self;
}

- (void)setBufferProfile:(NSMutableArray *)newBufferProfile {
	if (bufferProfile != newBufferProfile) {
		bufferProfile = newBufferProfile;
    }
	[self setNeedsDisplay];
}


- (void)setHighlighted:(BOOL)lit {
	// If highlighted state changes, need to redisplay.
	if (highlighted != lit) {
		highlighted = lit;	
		[self setNeedsDisplay];
	}
}


- (void)drawRect:(CGRect)rect {
    
    if(!moving){
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        if (self.highlighted || [profileState isEqualToString:@"Loaded"]){
            [[UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0] setFill];
            CGContextFillRect(context, rect);
        } else {
            [[UIColor colorWithRed:65.0/255.0 green:65.0/255.0 blue:65.0/255.0 alpha:1.0] setFill];
            CGContextFillRect(context, rect);
            
            [[UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1.0] setFill];
            CGContextFillRect(context, CGRectMake(0, rect.size.height - 2, rect.size.width, 1));
            
            [[UIColor colorWithRed:86.0/255.0 green:86.0/255.0 blue:86.0/255.0 alpha:1.0] setFill];
            CGContextFillRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
        }
        
        CGSize size;
        
        UIFont *mainFont = [UIFont systemFontOfSize:13];
        
        UIColor *mainTextColor = [UIColor whiteColor];
        
        if([self.profileState isEqualToString:@"selected"]){
            //mainTextColor = [UIColor darkGrayColor];
        
            UIImage *state = nil;
            state = [UIImage imageNamed:@"profileCheckmark.png"];
            [state drawInRect:CGRectMake(rect.size.width - 40, (rect.size.height / 2) - 12, 30, 24)];
            
        }
        
        [mainTextColor set];
    
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, CGSizeMake(-1,-1),0,[UIColor colorWithRed:33.0/255.0f green:33.0/255.0f blue:33.0/255.0f alpha:1.0].CGColor);
        
        NSString *profileString = [bufferProfile valueForKey:@"formatted_username"];
        size = [profileString sizeWithFont:mainFont constrainedToSize:CGSizeMake(300, 999999)];
        [profileString drawInRect:CGRectMake(65.0, 13.0, 300, size.height) withFont:mainFont];
        
        UIColor *typeTextColor = [UIColor lightGrayColor];
        
        [typeTextColor set];
        
        NSString *service = [bufferProfile valueForKey:@"service"];
        if([service isEqualToString:@"linkedin"]){
            service = @"LinkedIn";
        } else if([service isEqualToString:@"appdotnet"]){
            service = @"App.net";
        } else {
            service = [service capitalizedString];
        }
        
        if([bufferProfile valueForKey:@"service_type"]){
            NSString *typeString = [NSString stringWithFormat:@"%@ %@", service, [[bufferProfile valueForKey:@"service_type"] capitalizedString]];
            size = [typeString sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(300, 999999)];
            [typeString drawInRect:CGRectMake(65.0, 33.0, 300, size.height) withFont:[UIFont systemFontOfSize:12]];
        } else {
            NSString *typeString = [NSString stringWithFormat:@"%@", service];
            size = [typeString sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(300, 999999)];
            [typeString drawInRect:CGRectMake(65.0, 33.0, 300, size.height) withFont:[UIFont systemFontOfSize:12]];
        }
        
        
        
        UIColor *pendingTextColor = [UIColor whiteColor];
        [pendingTextColor set];
        
        NSString *pendingString = [NSString stringWithFormat:@"%d", [[[bufferProfile valueForKey:@"counts"] valueForKey:@"pending"] intValue]];
        size = [pendingString sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(300, 999999)];
        [pendingString drawInRect:CGRectMake(240.0, 25.0, 30, size.height) withFont:[UIFont systemFontOfSize:12]];
        
        CGContextRestoreGState(context);
    }
}


@end