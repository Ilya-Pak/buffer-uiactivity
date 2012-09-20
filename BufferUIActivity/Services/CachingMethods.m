//
//  CachingMethods.m
//  Buffer
//
//  Created by Andrew Yates on 18/07/2012.
//
//

#import "CachingMethods.h"

@implementation CachingMethods


- (NSString *)offlineCachePath {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cache = [paths objectAtIndex:0];
	NSString *BufferPath = [cache stringByAppendingPathComponent:@"Buffer"];
	
	// Check if the path exists, otherwise create it
	if (![fileManager fileExistsAtPath:BufferPath]) {
		[fileManager createDirectoryAtPath:BufferPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
	
	return BufferPath;
}


// Avatars
- (BOOL)addAvatartoCacheforProfile:(NSString *)profileID fromURL:(NSString *)url {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
    [UIImagePNGRepresentation(image) writeToFile:[[self offlineCachePath] stringByAppendingPathComponent:profileID] atomically:YES];
    
	return YES;
}


// Profiles
- (NSString *)cachedProfileListPath {
	NSString *cachedProfileListPath = [[self offlineCachePath] stringByAppendingPathComponent:@"BufferCachedProfileList.plist"];
    return cachedProfileListPath;
}

- (NSMutableArray *)getCachedProfiles {
	return [[NSArray arrayWithContentsOfFile:[self cachedProfileListPath]] mutableCopy];
}

- (void)cacheProfileList:(NSMutableArray *)profileList {
	[profileList writeToFile:[self cachedProfileListPath] atomically:YES];
}

-(void)removeCachedProfiles {
    [@[] writeToFile:[self cachedProfileListPath] atomically:YES];
}




@end
