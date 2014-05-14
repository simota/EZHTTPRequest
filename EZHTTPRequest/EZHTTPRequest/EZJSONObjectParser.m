//
//  EZJSONObjectParser.m
//  EZHTTPRequest
//
//  Created by simota on 2014/04/17.
//  Copyright (c) 2014年 simota. All rights reserved.
//

#import "EZJSONObjectParser.h"

@implementation EZJSONObjectParser

- (id)parseData:(NSData *)data
{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

@end
