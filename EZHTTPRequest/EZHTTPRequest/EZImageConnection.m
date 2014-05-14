//
//  EZImageConnection.m
//  EZHTTPRequest
//
//  Created by simota on 2014/03/07.
//  Copyright (c) 2014年 simota. All rights reserved.
//

#import "EZHTTPRequest.h"
#import "EZHTTPResponse.h"
#import "EZImageCache.h"
#import "EZImageConnection.h"

@interface EZImageConnection ()

@property (nonatomic, strong) EZHTTPRequest *request;
@property (nonatomic, copy) void (^imageLoadSuccess)(UIImage *image);

- (NSString *)urlString;

@end

@implementation EZImageConnection

+ (instancetype)connectionWithURL:(NSURL *)url
                         finished:(void (^)(UIImage *))finished
{
    EZHTTPRequest *request = [EZHTTPRequest requestWithURL:url];
    EZImageConnection *connection = [[EZImageConnection alloc] initWithRequest:request];
    [connection fetchImage:finished];
    return connection;
}

- (void)fetchImage:(void (^)(UIImage *))finished
{
    self.imageLoadSuccess = finished;

    UIImage *cache = [[EZImageCache sharedInstance] objectForKey:self.urlString];
    if (cache) {
        self.imageLoadSuccess(cache);

        return;
    }

    [self start];
}

- (void)afterConnectionDidFinishLoading:(EZHTTPResponse *)response
{
    UIImage *image = [[UIImage alloc] initWithData:response.rawData];
    [[EZImageCache sharedInstance] setObject:image forKey:self.urlString];
    self.imageLoadSuccess(image);
}

- (NSString *)urlString
{
    return self.request.requestObject.URL.absoluteString;
}

@end
