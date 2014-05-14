//
//  EZHTTPResponse.m
//  EZHTTPRequest
//
//  Created by simota on 12/4/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import "EZHTTPResponse.h"
#import "EZObjectParserProtocol.h"
#import "EZJSONObjectParser.h"

@interface EZHTTPResponse ()

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSHTTPURLResponse *response;

@end

@implementation EZHTTPResponse

- (id)initWithResponse:(NSHTTPURLResponse *)response
    data:(NSData *)data
{
    self = [super init];
    if (self) {
        self.response = response;
        self.data     = data;
        self.objectParser = [[EZJSONObjectParser alloc] init];
    }

    return self;
}

- (NSDictionary *)allHeaderFields
{
    return self.response.allHeaderFields;
}

- (NSString *)cookie
{
    return [self.response.allHeaderFields objectForKey:@"Set-Cookie"];
}

- (NSInteger)statusCode
{
    return self.response.statusCode;
}

- (NSString *)stringData
{
    if (!self.data) { return nil; }

    return [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
}

- (NSData *)rawData
{
    return self.data;
}

- (id)object
{
    if (!self.data) { return nil; }
    
    return [self.objectParser parseData:self.data];
}

@end
