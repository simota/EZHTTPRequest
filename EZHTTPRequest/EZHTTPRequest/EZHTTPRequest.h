//
//  EZHTTPRequest.h
//  EZHTTPRequest
//
//  Created by simota on 12/11/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZHTTPRequest : NSObject

+ (EZHTTPRequest *)requestWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url;
- (void)setMethod:(NSString *)method;
- (void)setContentType:(NSString *)contentType;
- (void)setParameters:(NSDictionary *)parameters;
- (void)setHeaders:(NSDictionary *)headers;
- (void)setPostData:(NSDictionary *)parameters;
- (void)setJSONData:(id)object;
- (void)setCookie:(NSString *)cookie;
- (void)setUserAgent:(NSString *)userAgent;
- (void)setRangeHeader:(NSString *)rangeHeader;
- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
- (NSURLRequest *)requestObject;

@end
