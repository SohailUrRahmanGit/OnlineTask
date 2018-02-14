//
//  OnlineTaskTests.m
//  OnlineTaskTests
//
//  Created by SOHAIL UR RAHMAN on 12/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import <XCTest/XCTest.h>
#import"MainViewController.h"

@interface OnlineTaskTests : XCTestCase
@property MainViewController *mainVCUnitTestobj;
@end

@implementation OnlineTaskTests

- (void)setUp {
    [super setUp];
   _mainVCUnitTestobj = [[MainViewController alloc]init];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



//- (void)testTitlePresent {
//    NSString *naviTitle =  _mainVCUnitTestobj.navigationItem.title ;
//    NSString *expectedNavTitle = @"About Canada";
//    XCTAssertEqual(naviTitle, expectedNavTitle);
//
//}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
