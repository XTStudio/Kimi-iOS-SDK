//
//  DataTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface DataTests : XCTestCase

@end

@implementation DataTests

- (void)testCreatedByArrayBuffer {
    [[AppDelegate unitTestContext] evaluateScript:@"var testDataCreatedByUTF8String = new Data(new Uint8Array([72,101,108,108,111,44,32,87,111,114,108,100,33]).buffer)"];
    NSData *result = [AppDelegate fetchUnitTestObjectForKey:@"testDataCreatedByUTF8String"];
    XCTAssertTrue([result isKindOfClass:[NSData class]]);
    XCTAssertTrue([result isEqualToData:[@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding]]);
}

- (void)testCreatedByUTF8String {
    [[AppDelegate unitTestContext] evaluateScript:@"var testDataCreatedByUTF8String = new Data({utf8String: 'Hello, World!'})"];
    NSData *result = [AppDelegate fetchUnitTestObjectForKey:@"testDataCreatedByUTF8String"];
    XCTAssertTrue([result isKindOfClass:[NSData class]]);
    XCTAssertTrue([result isEqualToData:[@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding]]);
}

- (void)testCreatedByBase64EncodedData {
    [[AppDelegate unitTestContext] evaluateScript:@"var testDataCreatedByBase64EncodedData = new Data({base64EncodedData: new Data({utf8String: 'SGVsbG8sIFdvcmxkIQ=='})})"];
    NSData *result = [AppDelegate fetchUnitTestObjectForKey:@"testDataCreatedByBase64EncodedData"];
    XCTAssertTrue([result isKindOfClass:[NSData class]]);
    XCTAssertTrue([result isEqualToData:[@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding]]);
}

- (void)testCreatedByBase64EncodedString {
    [[AppDelegate unitTestContext] evaluateScript:@"var testDataCreatedByBase64EncodedData = new Data({base64EncodedString: SGVsbG8sIFdvcmxkIQ==})"];
    NSData *result = [AppDelegate fetchUnitTestObjectForKey:@"testDataCreatedByBase64EncodedData"];
    XCTAssertTrue([result isKindOfClass:[NSData class]]);
    XCTAssertTrue([result isEqualToData:[@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding]]);
}

- (void)testArrayBufferReturns {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var testDataCreatedByUTF8String = new Data({utf8String: 'Hello, World!'})"];
    [context evaluateScript:@"var abResult = testDataCreatedByUTF8String.arrayBuffer()"];
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[0] == 72"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[1] == 101"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[2] == 108"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[3] == 108"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[4] == 111"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[5] == 44"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[6] == 32"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[7] == 87"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[8] == 111"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[9] == 114"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[10] == 108"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[11] == 100"] toBool]);
    XCTAssertTrue([[context evaluateScript:@"new Uint8Array(abResult)[12] == 33"] toBool]);
}

- (void)testStringReturns {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var testDataCreatedByUTF8String = new Data({utf8String: 'Hello, World!'})"];
    XCTAssertTrue([[context evaluateScript:@"testDataCreatedByUTF8String.utf8String() === 'Hello, World!'"] toBool]);
}

- (void)testBase64EncodedDataReturns {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var testDataCreatedByUTF8String = new Data({utf8String: 'Hello, World!'})"];
    [context evaluateScript:@"var base64EncodedData = testDataCreatedByUTF8String.base64EncodedData()"];
    XCTAssertTrue([[AppDelegate fetchUnitTestObjectForKey:@"base64EncodedData"] isEqualToData:[@"SGVsbG8sIFdvcmxkIQ==" dataUsingEncoding:NSUTF8StringEncoding]]);
}

- (void)testBase64EncodedStringReturns {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var testDataCreatedByUTF8String = new Data({utf8String: 'Hello, World!'})"];
    XCTAssertTrue([[context evaluateScript:@"testDataCreatedByUTF8String.base64EncodedString() === 'SGVsbG8sIFdvcmxkIQ=='"] toBool]);
}

- (void)testMutableData {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var testMutableData = new Data({utf8String: 'Hello, World!'}).mutable()"];
    XCTAssertTrue([[context evaluateScript:@"testMutableData instanceof MutableData"] toBool]);
    [context evaluateScript:@"testMutableData.appendData(new Data({utf8String: '!!!'}))"];
    XCTAssertTrue([[context evaluateScript:@"testMutableData.utf8String() === 'Hello, World!!!!'"] toBool]);
    [context evaluateScript:@"testMutableData.appendArrayBuffer(new Uint8Array([33, 33, 33]).buffer)"];
    XCTAssertTrue([[context evaluateScript:@"testMutableData.utf8String() === 'Hello, World!!!!!!!'"] toBool]);
    [context evaluateScript:@"testMutableData.setData(new Data({utf8String: '!!!'}))"];
    XCTAssertTrue([[context evaluateScript:@"testMutableData.utf8String() === '!!!'"] toBool]);
}

@end
