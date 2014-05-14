EZHTTPRequest
=============

Simple http request library using NSURLConnection

**API Request Sample**

```
NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/tater/events"];
EZHTTPRequest *request = [EZHTTPRequest requestWithURL:url];
EZHTTPConnection *connection = [[EZHTTPConnection alloc] initWithRequest:request];
connection.success = ^(EZHTTPConnection *request, EZHTTPResponse *response) {
	// Success handling
};

connection.progress = ^(EZHTTPConnection *request, long long receiveDataLength, long long totalReceiveDataLength) {
	// Progress handling
};

connection.failure = ^(EZHTTPConnection *request, NSError *error) {
	// Error handling
};

[connection start];
```

**File Download Sample**

```
NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"sample_file"];
NSOutputStream *outputStream = [[NSOutputStream alloc] initToFileAtPath:path append:NO];
EZHTTPRequest *request = [EZHTTPRequest requestWithURL:[NSURL URLWithString:@"http://file.simota.jp/dummyfile"]];
EZDownloadConnection *connection = [[EZDownloadConnection alloc] initWithRequest:request outputStream:outputStream];
connection.success = ^(EZHTTPConnection *request, EZHTTPResponse *response) {
	// Success handling
};

connection.progress = ^(EZHTTPConnection *request, long long receiveDataLength, long long totalReceiveDataLength) {
    // Progress handling
};

connection.failure = ^(EZHTTPConnection *request, NSError *error) {
	// Error handling
};

[connection start];
```

**Image Request Sample**

```
NSURL *url = [NSURL URLWithString:@"https://pbs.twimg.com/profile_images/3718888043/5fefe47d9e55607193f1bb27173e86b8.jpeg"];
EZHTTPRequest *request = [EZHTTPRequest requestWithURL:url];
EZImageConnection *connection = [[EZImageConnection alloc] initWithRequest:request];
[connection fetchImage:^(UIImage *image) {
	// Fetched Image handling
}];
```