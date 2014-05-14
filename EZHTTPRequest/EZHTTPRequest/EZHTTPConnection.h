//
//  EZHTTPConnection.h
//  EZHTTPRequest
//
//  Created by simota on 12/4/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EZHTTPConnection;
@class EZHTTPRequest;
@class EZHTTPResponse;

typedef void (^EZHTTPConnectionSuccess)(EZHTTPConnection *request, EZHTTPResponse *response);
typedef void (^EZHTTPConnectionFailure)(EZHTTPConnection *request, NSError *error);
typedef void (^EZHTTPConnectionProgress)(EZHTTPConnection *request, long long receiveDataLength, long long totalReceiveDataLength);

@interface EZHTTPConnection : NSOperation

- (id)initWithRequest:(EZHTTPRequest *)request;
- (void)start;
- (void)cancel;

- (void)afterConnectionDidFinishLoading:(EZHTTPResponse *)response;

@property (nonatomic, copy) EZHTTPConnectionSuccess success;
@property (nonatomic, copy) EZHTTPConnectionFailure failure;
@property (nonatomic, copy) EZHTTPConnectionProgress progress;

@end


