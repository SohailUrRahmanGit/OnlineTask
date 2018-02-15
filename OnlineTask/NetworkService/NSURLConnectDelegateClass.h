//
//  NSURLConnectDelegateClass.h
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 13/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 NSURLConnectDelegateClassSuccess & NSURLConnectDelegateClassFailure are block variables used to pass data when the connection delegate is successful or failure
 */
typedef void (^NSURLConnectDelegateClassSuccess) (NSData *theData);
typedef void (^NSURLConnectDelegateClassFailure) (NSError *theError);

@interface NSURLConnectDelegateClass : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

/*
timeout variables holds value of timeout time in seconds
 */
@property (nonatomic,readwrite) NSTimeInterval timeout;

/*
 Cache responses are stored in this constant
 */
@property (nonatomic,readwrite) NSURLRequestCachePolicy cachePolicy;

- (void)fetchURL:(NSURL *)url withCompletion:(NSURLConnectDelegateClassSuccess)completion failure:(NSURLConnectDelegateClassFailure)failure;

- (void)cancelAllCalls;

@end
