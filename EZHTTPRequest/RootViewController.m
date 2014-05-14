//
//  RootViewController.m
//  EZHTTPRequest
//
//  Created by simota on 12/17/13.
//  Copyright (c) 2013 simota. All rights reserved.
//

#import "RootViewController.h"
#import "EZHTTPRequestHeader.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setTitle:@"API Request START" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(apiRequest) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(0.0, 100.0, self.view.frame.size.width, 50.0);
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setTitle:@"Download Request START" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(downloadRequest) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(0.0, 150.0, self.view.frame.size.width, 50.0);
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setTitle:@"Image Request START" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(imageRequest) forControlEvents:UIControlEventTouchUpInside];
    button3.frame = CGRectMake(0.0, 200.0, self.view.frame.size.width, 50.0);
    [self.view addSubview:button3];
}

- (void)apiRequest
{
    EZHTTPRequest *request = [EZHTTPRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/users/tater/events"]];
    EZHTTPConnection *connection = [[EZHTTPConnection alloc] initWithRequest:request];
    connection.success = ^(EZHTTPConnection *request, EZHTTPResponse *response) {
        NSLog(@"===success===");
        NSLog(@"statusCode:%ld", response.statusCode);
        NSLog(@"allHeaderFields:%@", response.allHeaderFields);
        NSLog(@"rawData:%@", response.rawData);
        NSLog(@"stringData:%@", response.stringData);
        NSLog(@"object:%@", response.object);
    };
    
    connection.progress = ^(EZHTTPConnection *request, long long receiveDataLength, long long totalReceiveDataLength) {
        NSLog(@"receiveDataLength:%lld totalReceiveDataLength:%lld", receiveDataLength, totalReceiveDataLength);
    };
    
    connection.failure = ^(EZHTTPConnection *request, NSError *error) {
        NSLog(@"===failure===");
        NSLog(@"error:%@", error.description);
    };
    
    [connection start];
    
    [[EZImageCache sharedInstance] clearCache];
}

- (void)downloadRequest
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"sample_file"];
//    NSOutputStream *outputStream = [[NSOutputStream alloc] initToFileAtPath:path append:NO];
    EZHTTPRequest *request = [EZHTTPRequest requestWithURL:[NSURL URLWithString:@"http://file.simota.jp/dummyfile"]];
    EZDownloadConnection *connection = [[EZDownloadConnection alloc] initWithRequest:request filePath:path skipBackup:YES];
    connection.success = ^(EZHTTPConnection *request, EZHTTPResponse *response) {
        NSLog(@"===success===");
        NSLog(@"statusCode:%ld", response.statusCode);
        NSLog(@"allHeaderFields:%@", response.allHeaderFields);
        NSLog(@"rawData:%@", response.rawData);
        NSLog(@"stringData:%@", response.stringData);
        NSLog(@"object:%@", response.object);
    };
    
    connection.progress = ^(EZHTTPConnection *request, long long receiveDataLength, long long totalReceiveDataLength) {
        NSLog(@"receiveDataLength:%lld totalReceiveDataLength:%lld", receiveDataLength, totalReceiveDataLength);
    };
    
    connection.failure = ^(EZHTTPConnection *request, NSError *error) {
        NSLog(@"===failure===");
        NSLog(@"error:%@", error.description);
    };
    
    [connection start];
}

- (void)imageRequest
{
    NSURL *url = [NSURL URLWithString:@"https://pbs.twimg.com/profile_images/3718888043/5fefe47d9e55607193f1bb27173e86b8.jpeg"];
    EZHTTPRequest *request = [EZHTTPRequest requestWithURL:url];
    EZImageConnection *connection = [[EZImageConnection alloc] initWithRequest:request];
    [connection fetchImage:^(UIImage *image) {
        NSLog(@"imageRequest:%@", image);
    }];
}

@end
