//
//  EZDownloadConnection.h
//  EZHTTPRequest
//
//  Created by simota on 12/4/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import "EZHTTPConnection.h"

@interface EZDownloadConnection : EZHTTPConnection

- (id)initWithRequest:(EZHTTPRequest *)request
    outputStream:(NSOutputStream *)outputStream;

- (id)initWithRequest:(EZHTTPRequest *)request
             filePath:(NSString *)filePath
           skipBackup:(BOOL)skipBackup;

@end
