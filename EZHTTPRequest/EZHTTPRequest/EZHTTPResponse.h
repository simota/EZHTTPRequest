//
//  EZHTTPResponse.h
//  EZHTTPRequest
//
//  Created by simota on 12/4/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EZObjectParserProtocol;

@interface EZHTTPResponse : NSObject

- (id)initWithResponse:(NSHTTPURLResponse *)response data:(NSData *)data;
- (NSDictionary *)allHeaderFields;
- (NSString *)cookie;
- (NSInteger)statusCode;
- (NSString *)stringData;
- (NSData *)rawData;
- (id)object;

@property (nonatomic, strong) id<EZObjectParserProtocol> objectParser;

@end
