//
//  EZHTTPConnection.m
//  EZHTTPRequest
//
//  Created by simota on 12/4/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import "EZHTTPConnection.h"
#import "EZHTTPRequest.h"
#import "EZHTTPResponse.h"

@interface EZHTTPConnection () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) EZHTTPRequest *request;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSError *error;

@end

@implementation EZHTTPConnection

- (id)initWithRequest:(EZHTTPRequest *)request
{
    self = [super init];
    if (self) {
        self.request = request;
    }

    return self;
}

- (void)start
{
    self.data = [NSMutableData data];
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request.requestObject delegate:self];
    [self.connection start];
}

- (void)cancel
{
    [self.connection cancel];
}

- (void)afterConnectionDidFinishLoading:(EZHTTPResponse *)response
{

}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection
    didReceiveResponse:(NSURLResponse *)response
{
    self.response = (NSHTTPURLResponse *) response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];

    if (self.progress) {
        self.progress(self, [data length], [self.data length]);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    EZHTTPResponse *response = [[EZHTTPResponse alloc] initWithResponse:self.response data:self.data];

    if (self.success) {
        self.success(self, response);
    }

    [self afterConnectionDidFinishLoading:response];
}

- (void)connection:(NSURLConnection *)connection
    didFailWithError:(NSError *)error
{
    self.error = error;
    if (self.failure) {
        self.failure(self, self.error);
    }
}

@end
