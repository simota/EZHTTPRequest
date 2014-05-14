//
//  EZImageConnection.h
//  EZHTTPRequest
//
//  Created by simota on 2014/03/07.
//  Copyright (c) 2014年 simota. All rights reserved.
//

#import "EZHTTPConnection.h"

@interface EZImageConnection : EZHTTPConnection

+ (instancetype)connectionWithURL:(NSURL *)url finished:(void (^)(UIImage *))finished;
- (void)fetchImage:(void (^)(UIImage *))finished;

@end