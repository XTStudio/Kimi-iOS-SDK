//
//  BundleTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface BundleTests : XCTestCase

@end

@implementation BundleTests

- (void)testNativeBundle {
    JSContext *context = [AppDelegate unitTestContext];
    NSString *aPath = [context evaluateScript:@"Bundle.native.resourcePath('test', 'txt')"].toString;
    XCTAssertTrue([[NSString stringWithContentsOfFile:aPath encoding:NSUTF8StringEncoding error:NULL] isEqualToString:@"foo value"]);
    [context evaluateScript:@"var testURL = Bundle.native.resourceURL('test', 'txt')"];
    NSURL *aURL = [AppDelegate fetchUnitTestObjectForKey:@"testURL"];
    XCTAssertTrue([[NSString stringWithContentsOfURL:aURL encoding:NSUTF8StringEncoding error:NULL] isEqualToString:@"foo value"]);
}

@end
