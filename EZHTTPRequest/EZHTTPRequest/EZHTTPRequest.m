//
//  EZHTTPRequest.m
//  EZHTTPRequest
//
//  Created by simota on 12/11/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import "EZHTTPRequest.h"

@interface EZHTTPRequest ()

- (NSString *)formEncodeParameters:(NSDictionary *)parameters;

@property (nonatomic, strong) NSMutableURLRequest *urlRequest;

@end

@implementation EZHTTPRequest

+ (EZHTTPRequest *)requestWithURL:(NSURL *)url
{
    return [[self alloc] initWithURL:url];
}

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
        [self.urlRequest setValue:@"" forHTTPHeaderField:@"Accept-Encoding"];
    }

    return self;
}

- (NSString *)formEncodeParameters:(NSDictionary *)parameters
{
    NSMutableArray *queries = [NSMutableArray array];
    for (NSString *key in parameters) {
        NSString *targetString  = [NSString stringWithFormat:@"%@", parameters[key]];
        NSString *escapedString = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(
            kCFAllocatorDefault,
            (CFStringRef) targetString,
            NULL,
            (CFStringRef) @"!*'();:@&=+$,/?%#[]",
            kCFStringEncodingUTF8);
        [queries addObject:[NSString stringWithFormat:@"%@=%@", key, escapedString]];
    }

    return [[queries sortedArrayUsingSelector:@selector(compare:)] componentsJoinedByString:@"&"];
}

- (void)setMethod:(NSString *)method
{
    self.urlRequest.HTTPMethod = method;
}

- (void)setContentType:(NSString *)contentType
{
    [self.urlRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
}

- (void)setParameters:(NSDictionary *)parameters
{
    NSString *str = [NSString stringWithFormat:@"%@?%@", self.urlRequest.URL.absoluteString, [self formEncodeParameters:parameters]];
    self.urlRequest.URL = [NSURL URLWithString:str];
}

- (void)setPostData:(NSDictionary *)parameters
{
    [self setMethod:@"POST"];
    
    NSString *body = [self formEncodeParameters:parameters];
    self.urlRequest.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)setJSONData:(id)object
{
    [self setMethod:@"POST"];
    [self setContentType:@"application/json"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    self.urlRequest.HTTPBody = data;
}

- (void)setHeaders:(NSDictionary *)headers
{
    self.urlRequest.allHTTPHeaderFields = headers;
}

- (void)setCookie:(NSString *)cookie
{
    [self.urlRequest addValue:cookie forHTTPHeaderField:@"Cookie"];
}

- (void)setUserAgent:(NSString *)userAgent
{
    [self.urlRequest addValue:userAgent forHTTPHeaderField:@"User-Agent"];
}

- (void)setRangeHeader:(NSString *)rangeHeader
{
    [self.urlRequest addValue:rangeHeader forHTTPHeaderField:@"Range"];
}

- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    [self.urlRequest addValue:value forHTTPHeaderField:field];
}

- (NSURLRequest *)requestObject
{
    return self.urlRequest;
}

@end
