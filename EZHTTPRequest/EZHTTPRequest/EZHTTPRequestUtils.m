//
//  EZHTTPRequestUtils.m
//  EZHTTPRequest
//
//  Created by simota on 2014/03/10.
//  Copyright (c) 2014年 simota. All rights reserved.
//

#import "EZHTTPRequestUtils.h"
#import <sys/xattr.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString  (EZHTTPRequestUtils)

- (NSString *)MD5Hash
{
    const char *data = [self UTF8String];
    if (self.length == 0) {
        return nil;
    }
    CC_LONG len = (unsigned int) self.length;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, len, result);
    NSMutableString *ms = @"".mutableCopy;
    for (int i = 0; i < 16; i++) {
        [ms appendFormat:@"%02X", result[i]];
    }

    return ms;
}

@end

@implementation EZHTTPRequestUtils

// https://developer.apple.com/library/ios/qa/qa1719/_index.html
// Technical Q&A QA1719
// How do I prevent files from being backed up to iCloud and iTunes?
//
// Q:  My app has a number of files that need to be stored on the device permanently for my app to function properly offline.
// However, those files do not contain user data and don't need to be backed up. How can I prevent them from being backed up?

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

@end
