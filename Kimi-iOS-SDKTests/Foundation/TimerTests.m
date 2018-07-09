//
//  TimerTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface TimerTests : XCTestCase

@end

@implementation TimerTests

- (void)testOnce {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var onceCalled = false;"];
    [context evaluateScript:@"new Timer(0.1, function(){ onceCalled = true });"];
    XCTestExpectation *onceTest = [[XCTestExpectation alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertTrue([[context objectForKeyedSubscript:@"onceCalled"] toBool]);
        [onceTest fulfill];
    });
    [self waitForExpectations:@[onceTest] timeout:0.5];
}

- (void)testRepeats {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var repeatsCalled = 0;"];
    [context evaluateScript:@"new Timer(0.1, function(){ repeatsCalled++ }, true);"];
    XCTestExpectation *repeatsTest = [[XCTestExpectation alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertTrue([[[context objectForKeyedSubscript:@"repeatsCalled"] toNumber] integerValue] > 10);
        [repeatsTest fulfill];
    });
    [self waitForExpectations:@[repeatsTest] timeout:2.0];
}

- (void)testInvalid {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var invalidCalled = false;"];
    [context evaluateScript:@"var invalidTimer = new Timer(0.1, function(){ invalidCalled = true });invalidTimer.invalidate()"];
    XCTestExpectation *invalidTest = [[XCTestExpectation alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertFalse([[context objectForKeyedSubscript:@"invalidCalled"] toBool]);
        [invalidTest fulfill];
    });
    [self waitForExpectations:@[invalidTest] timeout:0.5];
}

- (void)testFire {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var fireCalled = false;"];
    [context evaluateScript:@"new Timer(0.1, function(){ fireCalled = true }).fire();"];
    XCTestExpectation *fireTest = [[XCTestExpectation alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertTrue([[context objectForKeyedSubscript:@"fireCalled"] toBool]);
        [fireTest fulfill];
    });
    [self waitForExpectations:@[fireTest] timeout:0.5];
}

@end
