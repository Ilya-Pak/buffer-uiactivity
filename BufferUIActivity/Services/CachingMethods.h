//
//  CachingMethods.h
//  Buffer
//
//  Created by Andrew Yates on 18/07/2012.
//
//

#import <UIKit/UIKit.h>

@interface CachingMethods : NSObject

- (NSString *)offlineCachePath;
- (BOOL)addAvatartoCacheforProfile:(NSString *)profileID fromURL:(NSString *)url;

- (NSMutableArray *)getCachedProfiles;
- (void)cacheProfileList:(NSMutableArray *)profileList;
- (void)removeCachedProfiles;

- (NSString *)cachedConfigurationPath;
- (NSMutableArray *)getCachedConfiguration;
- (void)cacheConfiguration:(NSMutableArray *)configuration;
- (void)removeCachedConfiguration;

@end
