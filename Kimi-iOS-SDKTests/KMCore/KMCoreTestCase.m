//
//  KMCoreGTestCase.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/8/23.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "KimiTestExpectation.h"

@interface KMCoreTestCase : XCTestCase

@end

@implementation KMCoreTestCase

- (void)setUp {
    [super setUp];
}

- (void)testVersion {
    JSContext *context = [AppDelegate unitTestContext];
    XCTAssertTrue([[context evaluateScript:@"KMCore.version"].toString isEqualToString:@"0.1.0"]);
}

- (void)testHostVersion {
    JSContext *context = [AppDelegate unitTestContext];
    XCTAssertTrue([[context evaluateScript:@"KMCore.hostVersion"].toString isEqualToString:@"1.0"]);
}

@end
