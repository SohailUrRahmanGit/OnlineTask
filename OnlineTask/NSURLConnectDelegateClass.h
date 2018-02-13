//
//  NSURLConnectDelegateClass.h
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 13/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NSURLConnectDelegateClassSuccess) (NSData *theData);
typedef void (^NSURLConnectDelegateClassFailure) (NSError *theError);

@interface NSURLConnectDelegateClass : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>


@property (nonatomic,readwrite) NSTimeInterval timeout;
@property (nonatomic,readwrite) NSURLRequestCachePolicy cachePolicy;

- (void)fetchURL:(NSURL *)url withCompletion:(NSURLConnectDelegateClassSuccess)completion failure:(NSURLConnectDelegateClassFailure)failure;

- (void)cancelAllCalls;

@end
