//
//  EZDownloadConnection.h
//  EZHTTPRequest
//
//  Created by simota on 12/4/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import "EZDownloadConnection.h"
#import "EZHTTPResponse.h"
#import "EZHTTPRequestUtils.h"

@interface EZDownloadConnection ()

@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSOutputStream *outputStream;
@property (nonatomic) long long totalBytesRead;
@property (nonatomic, assign) BOOL skipBackup;
@property (nonatomic, copy) NSString *filePath;

@end

@implementation EZDownloadConnection

- (id)initWithRequest:(EZHTTPRequest *)request
    outputStream:(NSOutputStream *)outputStream
{
    self = [super initWithRequest:request];
    if (self) {
        self.outputStream = outputStream;
    }

    return self;
}

- (id)initWithRequest:(EZHTTPRequest *)request
             filePath:(NSString *)filePath
           skipBackup:(BOOL)skipBackup
{
    self = [super initWithRequest:request];
    if (self) {
        self.filePath = filePath;
        self.skipBackup = skipBackup;
        self.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    }
    
    return self;
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection
    didReceiveResponse:(NSURLResponse *)response
{
    self.response = (NSHTTPURLResponse *) response;
    self.totalBytesRead = 0;
    [self.outputStream open];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSUInteger length = [data length];
    if ([self.outputStream hasSpaceAvailable]) {
        const uint8_t *dataBuffer = (uint8_t *) [data bytes];
        [self.outputStream write:&dataBuffer[0] maxLength:length];
    }

    self.totalBytesRead += [data length];
    if (self.progress) {
        self.progress(self, length, self.totalBytesRead);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.outputStream close];
    
    if (self.skipBackup) {
        NSURL *path = [NSURL fileURLWithPath:self.filePath];
        [EZHTTPRequestUtils addSkipBackupAttributeToItemAtURL:path];
    }
    
    if (self.success) {
        EZHTTPResponse *response = [[EZHTTPResponse alloc] initWithResponse:self.response data:nil];
        self.success(self, response);
    }
}

@end
