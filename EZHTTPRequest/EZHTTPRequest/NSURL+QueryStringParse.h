//
//  NSURL+QueryStringParse.h
//  MuMoDownloader
//
//  Created by simota on 12/11/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (QueryStringParse)

- (NSArray *)parameterArray;
- (NSDictionary *)parameterDictionary;

@end
