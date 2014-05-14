//
//  EZHTTPRequestUtils.h
//  EZHTTPRequest
//
//  Created by simota on 2014/03/10.
//  Copyright (c) 2014年 simota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString  (EZHTTPRequestUtils)

- (NSString *)MD5Hash;

@end

@interface EZHTTPRequestUtils : NSObject

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end
