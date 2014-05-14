//
//  EZObjectParserProtocol.h
//  EZHTTPRequest
//
//  Created by simota on 2014/04/17.
//  Copyright (c) 2014年 simota. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EZObjectParserProtocol <NSObject>

- (id)parseData:(NSData *)data;

@end
