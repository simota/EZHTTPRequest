//
//  NSURL+QueryStringParse.m
//  MuMoDownloader
//
//  Created by simota on 12/11/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import "NSURL+QueryStringParse.h"

@implementation NSURL (QueryStringParse)

- (NSArray *)parameterArray
{
    if (![self query]) {
        return nil;
    }

    NSScanner *scanner = [NSScanner scannerWithString:[self query]];
    if (!scanner) {
        return nil;
    }

    NSMutableArray *array = [NSMutableArray array];

    NSString *key, *val;

    while (![scanner isAtEnd]) {
        if (![scanner scanUpToString:@"=" intoString:&key]) {
            key = nil;
        }

        [scanner scanString:@"=" intoString:nil];

        if (![scanner scanUpToString:@"&" intoString:&val]) {
            val = nil;
        }

        [scanner scanString:@"&" intoString:nil];

        key = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        val = [val stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        if (!val) {
            val = @"";
        }

        NSLog(@"[%@]:%@", key, val);

        if (key) {
            [array addObject:@{ @"key": key, @"value": val }];
        }
    }

    return array;
}

- (NSDictionary *)parameterDictionary
{
    if (![self query]) {
        return nil;
    }

    NSArray *parameterArray = [self parameterArray];

    NSArray *keys            = [parameterArray valueForKey:@"key"];
    NSArray *values          = [parameterArray valueForKey:@"value"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];

    return dictionary;
}

@end
