//
//  UserDefaultsTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface UserDefaultsTests : XCTestCase

@end

@implementation UserDefaultsTests

- (void)testStandardUserDefaults {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"UserDefaults.standard.setValue('fooString', 'fooKey')"];
    XCTAssertTrue([[context evaluateScript:@"UserDefaults.standard.valueForKey('fooKey')"].toString isEqualToString:@"fooString"]);
    [context evaluateScript:@"UserDefaults.standard.setValue(123123, 'fooKey')"];
    XCTAssertTrue([[context evaluateScript:@"UserDefaults.standard.valueForKey('fooKey')"].toNumber isEqualToNumber:@(123123)]);
    [context evaluateScript:@"UserDefaults.standard.setValue(true, 'fooKey')"];
    XCTAssertTrue([context evaluateScript:@"UserDefaults.standard.valueForKey('fooKey')"].toBool);
    [context evaluateScript:@"UserDefaults.standard.setValue({bar: 'barValue'}, 'fooKey')"];
    XCTAssertTrue([[context evaluateScript:@"UserDefaults.standard.valueForKey('fooKey').bar"].toString isEqualToString:@"barValue"]);
    [context evaluateScript:@"UserDefaults.standard.setValue([123, 456], 'fooKey')"];
    XCTAssertTrue([[context evaluateScript:@"UserDefaults.standard.valueForKey('fooKey')[0]"].toString isEqualToString:@"123"]);
    [context evaluateScript:@"UserDefaults.standard.setValue(undefined, 'fooKey')"];
    XCTAssertTrue([context evaluateScript:@"UserDefaults.standard.valueForKey('fooKey')"].isUndefined);
}

- (void)testResetUserDefaults {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"UserDefaults.standard.setValue('fooString', 'fooKey')"];
    [context evaluateScript:@"UserDefaults.standard.reset()"];
    XCTAssertTrue([context evaluateScript:@"UserDefaults.standard.valueForKey('fooKey')"].isUndefined);
}

- (void)testCustomUserDefaults {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var userDefaults = new UserDefaults('com.xt.foo')"];
    [context evaluateScript:@"userDefaults.setValue('fooString', 'fooKey')"];
    XCTAssertTrue([[context evaluateScript:@"userDefaults.valueForKey('fooKey')"].toString isEqualToString:@"fooString"]);
    [context evaluateScript:@"userDefaults.setValue(123123, 'fooKey')"];
    XCTAssertTrue([[context evaluateScript:@"userDefaults.valueForKey('fooKey')"].toNumber isEqualToNumber:@(123123)]);
    [context evaluateScript:@"userDefaults.setValue(true, 'fooKey')"];
    XCTAssertTrue([context evaluateScript:@"userDefaults.valueForKey('fooKey')"].toBool);
    [context evaluateScript:@"userDefaults.setValue({bar: 'barValue'}, 'fooKey')"];
    XCTAssertTrue([[context evaluateScript:@"userDefaults.valueForKey('fooKey').bar"].toString isEqualToString:@"barValue"]);
    [context evaluateScript:@"userDefaults.setValue([123, 456], 'fooKey')"];
    XCTAssertTrue([[context evaluateScript:@"userDefaults.valueForKey('fooKey')[0]"].toString isEqualToString:@"123"]);
    [context evaluateScript:@"userDefaults.setValue(undefined, 'fooKey')"];
    XCTAssertTrue([context evaluateScript:@"userDefaults.valueForKey('fooKey')"].isUndefined);
}

@end
