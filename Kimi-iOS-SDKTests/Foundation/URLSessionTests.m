//
//  URLSessionTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "KimiTestExpectation.h"

@interface URLSessionTests : XCTestCase

@end

@implementation URLSessionTests

- (void)testGET {
    JSContext *context = [AppDelegate unitTestContext];
    KimiTestExpectation *sessionGetTest = [[KimiTestExpectation alloc] init];
    [AppDelegate setUnitTestObject:sessionGetTest forKey:@"sessionGetTest"];
    [context evaluateScript:@"URLSession.shared.dataTask('http://httpbin.org/get', function(data, response, error){ if (JSON.parse(data.utf8String()).url === 'http://httpbin.org/get'){ sessionGetTest.fulfill() } }).resume()"];
    [self waitForExpectations:@[sessionGetTest] timeout:10];
}

- (void)testGETRequestWithURLString {
    JSContext *context = [AppDelegate unitTestContext];
    KimiTestExpectation *sessionGetTest = [[KimiTestExpectation alloc] init];
    [AppDelegate setUnitTestObject:sessionGetTest forKey:@"sessionGetTest"];
    [context evaluateScript:@"var req = new MutableURLRequest('http://httpbin.org/get');"];
    [context evaluateScript:@"URLSession.shared.dataTask(req, function(data, response, error){ if (JSON.parse(data.utf8String()).url === 'http://httpbin.org/get'){ sessionGetTest.fulfill() } }).resume()"];
    [self waitForExpectations:@[sessionGetTest] timeout:10];
}

- (void)testPOST {
    JSContext *context = [AppDelegate unitTestContext];
    KimiTestExpectation *sessionPostTest = [[KimiTestExpectation alloc] init];
    [AppDelegate setUnitTestObject:sessionPostTest forKey:@"sessionPostTest"];
    [context evaluateScript:@"var req = new MutableURLRequest(URL.URLWithString('http://httpbin.org/post')); req.HTTPMethod = 'POST'; req.setValueForHTTPHeaderField('application/x-www-form-urlencoded', 'Content-Type'); req.HTTPBody = new Data({utf8String: 'username=PonyCui'})"];
    [context evaluateScript:@"URLSession.shared.dataTask(req, function(data, response, error){ if (JSON.parse(data.utf8String()).form.username === 'PonyCui'){ sessionPostTest.fulfill() } }).resume()"];
    [self waitForExpectations:@[sessionPostTest] timeout:10];
}

- (void)testStatusCode {
    JSContext *context = [AppDelegate unitTestContext];
    KimiTestExpectation *sessionStatusCodeTest = [[KimiTestExpectation alloc] init];
    [AppDelegate setUnitTestObject:sessionStatusCodeTest forKey:@"sessionStatusCodeTest"];
    [context evaluateScript:@"URLSession.shared.dataTask('http://httpbin.org/status/233', function(data, response, error){ if (response.statusCode === 233){ sessionStatusCodeTest.fulfill() } }).resume()"];
    [self waitForExpectations:@[sessionStatusCodeTest] timeout:10];
}

@end
