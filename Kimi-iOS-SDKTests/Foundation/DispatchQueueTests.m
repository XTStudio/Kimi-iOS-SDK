//
//  DispatchQueueTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "KimiTestExpectation.h"

@interface DispatchQueueTests : XCTestCase

@end

@implementation DispatchQueueTests

- (void)testDispatchQueueMain {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var asyncCalled = false;"];
    [context evaluateScript:@"DispatchQueue.main.async(function(){ asyncCalled = true; })"];
    XCTestExpectation *asyncTest = [[XCTestExpectation alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertTrue([[context objectForKeyedSubscript:@"asyncCalled"] toBool]);
        [asyncTest fulfill];
    });
    [context evaluateScript:@"var asyncAfterCalled = false;"];
    [context evaluateScript:@"DispatchQueue.main.asyncAfter(0.1, function(){ asyncAfterCalled = true; })"];
    XCTestExpectation *asyncAfterTest = [[XCTestExpectation alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertTrue([[context objectForKeyedSubscript:@"asyncAfterCalled"] toBool]);
        [asyncAfterTest fulfill];
    });
    [self waitForExpectations:@[asyncTest, asyncAfterTest] timeout:0.5];
}

- (void)testDispatchQueueIsolate {
    JSContext *context = [AppDelegate unitTestContext];
    KimiTestExpectation *isolateTest = [[KimiTestExpectation alloc] init];
    [AppDelegate setUnitTestObject:isolateTest forKey:@"isolateTest"];
    [context evaluateScript:@"DispatchQueue.global.isolate(function(isolateTest){ isolateTest.fulfill(); }, isolateTest);"];
    [self waitForExpectations:@[isolateTest] timeout:0.2];
}

- (void)testDispatchQueueIsolateTwice {
    JSContext *context = [AppDelegate unitTestContext];
    KimiTestExpectation *isolateTwiceTest = [[KimiTestExpectation alloc] init];
    [AppDelegate setUnitTestObject:isolateTwiceTest forKey:@"isolateTwiceTest"];
    [context evaluateScript:@"DispatchQueue.global.isolate(function(isolateTwiceTest){ DispatchQueue.main.isolate(function(isolateTwiceTest){ isolateTwiceTest.fulfill(); }, isolateTwiceTest); }, isolateTwiceTest);"];
    [self waitForExpectations:@[isolateTwiceTest] timeout:0.2];
}

@end
