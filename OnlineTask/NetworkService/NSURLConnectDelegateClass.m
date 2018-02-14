//
//  NSURLConnectDelegateClass.m
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 13/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "NSURLConnectDelegateClass.h"

@interface SampleURLConnection : NSURLConnection

@property (nonatomic,readwrite,strong) NSURLConnectDelegateClassSuccess completion;
@property (nonatomic,readwrite,strong) NSURLConnectDelegateClassFailure failure;
@property (nonatomic,readwrite,strong) NSMutableData *data;
@property (nonatomic,readwrite,strong) NSURLResponse *response;

@end

@implementation SampleURLConnection

@end

@interface NSURLConnectDelegateClass()

@property (nonatomic,readwrite,strong) NSMutableArray *connections;
@property (nonatomic,readwrite,strong) NSOperationQueue *networkQueue;

@end

@implementation NSURLConnectDelegateClass

-(id)init {
    self = [super init];
    if (self) {
        _networkQueue = [[NSOperationQueue alloc] init];
        _networkQueue.maxConcurrentOperationCount = 1;
        _connections = [NSMutableArray arrayWithCapacity:10];
        _timeout = 5.0;
        _cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return self;
}

//NSURL conpletion handler
-(void)fetchURL:(NSURL *)url withCompletion:(NSURLConnectDelegateClassSuccess)completion failure:(NSURLConnectDelegateClassFailure)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:self.cachePolicy timeoutInterval:self.timeout];
    SampleURLConnection *connection = [[SampleURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    if (!connection) {
        failure([NSError errorWithDomain:@"SampleDelegate" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Could not initialize NSURLConnection"}]);
        return;
    }
    [connection setDelegateQueue:self.networkQueue];
    connection.data = [NSMutableData dataWithCapacity:1024];
    connection.completion = completion;
    connection.failure = failure;
    
    [connection start];
    
    [self.connections addObject:connection];
}

//Cancel service calls method
- (void)cancelAllCalls {
    [self.networkQueue setSuspended:YES];
    [self.networkQueue cancelAllOperations];
    [self.networkQueue addOperationWithBlock:^{
        for (SampleURLConnection *connection in self.connections) {
            [connection cancel];
            connection.failure([NSError errorWithDomain:@"SampleDelegate" code:-2 userInfo:@{NSLocalizedDescriptionKey: @"Call canceled by user"}]);
        }
        [self.connections removeAllObjects];
    }];
    [self.networkQueue setSuspended:NO];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    SampleURLConnection *exConnection = (SampleURLConnection *)connection;
    exConnection.failure(error);
    [self.connections removeObject:exConnection];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    SampleURLConnection *exConnection = (SampleURLConnection *)connection;
    
    exConnection.response = response;
    exConnection.data.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    SampleURLConnection *exConnection = (SampleURLConnection *)connection;
    [exConnection.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.connections removeObject:connection];
    SampleURLConnection *exConnection = (SampleURLConnection *)connection;
    
    if ([exConnection.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)exConnection.response;
        if (httpResponse.statusCode >= 400) { // Client/Server Error
            exConnection.failure([NSError errorWithDomain:@"SampleDelegate" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey: [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]}]);
            return;
        }
    }
    
    exConnection.completion(exConnection.data);
}

@end

