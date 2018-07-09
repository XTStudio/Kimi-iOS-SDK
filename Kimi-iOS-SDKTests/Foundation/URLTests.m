//
//  URLTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface URLTests : XCTestCase

@end

@implementation URLTests

- (void)testRegularURL {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var regularURL = URL.URLWithString('https://www.github.com/index.html')"];
    XCTAssertTrue([[context evaluateScript:@"regularURL.absoluteString"].toString isEqualToString:@"https://www.github.com/index.html"]);
}

- (void)testRelativeURL {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"var relativeURL = URL.URLWithString('/test.html', URL.URLWithString('https://www.github.com/index.html'))"];
    XCTAssertTrue([[context evaluateScript:@"relativeURL.absoluteString"].toString isEqualToString:@"https://www.github.com/test.html"]);
}

- (void)testFileURL {
    NSString *filePath = [[NSBundle mainBundle] bundlePath];
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:[NSString stringWithFormat:@"var fileURL = URL.fileURLWithPath('%@')", filePath]];
    XCTAssertTrue([[context evaluateScript:@"fileURL.absoluteString"].toString isEqualToString:[NSURL fileURLWithPath:filePath].absoluteString]);
}

@end
