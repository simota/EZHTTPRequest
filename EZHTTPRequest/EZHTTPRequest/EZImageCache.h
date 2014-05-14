//
//  EZImageCache.h
//  EZHTTPRequest
//
//  Created by simota on 2014/03/10.
//  Copyright (c) 2014年 simota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZImageCache : NSObject

+ (instancetype)sharedInstance;
- (void)setObject:(id)anObject forKey:(NSString *)aKey;
- (id)objectForKey:(NSString *)key;
- (void)clearCache;

@end
