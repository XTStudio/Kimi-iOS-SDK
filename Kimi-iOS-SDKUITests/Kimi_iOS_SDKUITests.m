//
//  Kimi_iOS_SDKUITests.m
//  Kimi-iOS-SDKUITests
//
//  Created by PonyCui on 2018/7/12.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Kimi_iOS_SDKUITests : XCTestCase

@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation Kimi_iOS_SDKUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    self.app = [[XCUIApplication alloc] init];
    [self.app setLaunchEnvironment:@{
                                     @"animationsEnable": @"NO",
                                     }];
    [self.app launch];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testUIView {
    [self.app.tables.cells[@"UIView"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.otherElements[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.otherElements[@"Tap Require"].exists) {
            [self.app.otherElements[@"Tap Require"] tap];
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists, @"UIView Tests Failed");
    }
    [self.app.navigationBars.buttons[@"Kimi-iOS-SDK"] tap];
}

@end
