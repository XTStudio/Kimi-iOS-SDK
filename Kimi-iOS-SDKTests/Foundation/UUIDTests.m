//
//  UUIDTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface UUIDTests : XCTestCase

@end

@implementation UUIDTests

- (void)testRandomUUID {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var randomUUID_0 = new UUID()"];
    [context evaluateScript:@"var randomUUID_1 = new UUID()"];
    NSString *str_0 = [[context evaluateScript:@"randomUUID_0.UUIDString"] toString];
    NSString *str_1 = [[context evaluateScript:@"randomUUID_1.UUIDString"] toString];
    XCTAssertTrue(str_0.length == 36);
    XCTAssertTrue(str_1.length == 36);
    XCTAssertFalse([str_0 isEqualToString:str_1]);
}

- (void)testAssignUUID {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var assignUUID = new UUID('93198B67-C0F2-4509-B5C7-40E5385C05E9')"];
    XCTAssertTrue([[[context evaluateScript:@"assignUUID.UUIDString"] toString] isEqualToString:@"93198B67-C0F2-4509-B5C7-40E5385C05E9"]);
}

@end
