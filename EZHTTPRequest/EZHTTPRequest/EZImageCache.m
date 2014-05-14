//
//  EZImageCache.m
//  EZHTTPRequest
//
//  Created by simota on 2014/03/10.
//  Copyright (c) 2014年 simota. All rights reserved.
//

#import "EZHTTPRequestUtils.h"
#import "EZImageCache.h"

static NSString *EZImageCachePrefix = @"__EZHTTPRequest__";

@interface EZImageCache ()

@property (nonatomic, strong) NSMutableDictionary *memoryStorage;
@property (nonatomic, copy) NSString *cacheDirectory;

- (NSString *)cachePathWithKey:(NSString *)key;
- (NSData *)objectToData:(id)anObject;
- (void)saveToFile:(NSData *)data forKey:(NSString *)key;
- (void)removeCacheFiles;

@end

@implementation EZImageCache

static EZImageCache *_sharedInstance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                      _sharedInstance = [[self alloc] init];
                  });

    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.memoryStorage  = [[NSMutableDictionary alloc] init];
        self.cacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    }

    return self;
}

- (void)setObject:(id)anObject forKey:(NSString *)aKey
{
    NSString *keyString = [aKey MD5Hash];
    (self.memoryStorage)[keyString] = anObject;
    [self saveToFile:[self objectToData:anObject] forKey:keyString];
}

- (id)objectForKey:(NSString *)key
{
    NSString *keyString = [key MD5Hash];
    UIImage *image      = (self.memoryStorage)[keyString];
    if (!image) {
        image = [[UIImage alloc] initWithContentsOfFile:[self cachePathWithKey:keyString]];
        if (image) {
            (self.memoryStorage)[keyString] = image;
        }
    }

    return (self.memoryStorage)[keyString];
}

- (void)clearCache
{
    [self.memoryStorage removeAllObjects];
    [self removeCacheFiles];
}

- (void)removeCacheFiles
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files             = [fileManager contentsOfDirectoryAtPath:self.cacheDirectory error:nil];
    for (NSString *file in files) {
        if ([file hasPrefix:EZImageCachePrefix]) {
            NSString *filePath = [self.cacheDirectory stringByAppendingPathComponent:file];
            [fileManager removeItemAtPath:filePath error:nil];
        }
    }
}

#pragma mark -
- (NSString *)cachePathWithKey:(NSString *)key
{
    NSString *fileName = [NSString stringWithFormat:@"%@%@", EZImageCachePrefix, key];

    return [self.cacheDirectory stringByAppendingPathComponent:fileName];
}

- (NSData *)objectToData:(id)anObject
{
    if ([anObject isKindOfClass:[UIImage class]]) {
        return UIImagePNGRepresentation(anObject);
    }

    return [[anObject description] dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)saveToFile:(NSData *)data forKey:(NSString *)key
{
    NSString *filePath         = [self cachePathWithKey:key];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:data attributes:nil];
    }
}

@end
