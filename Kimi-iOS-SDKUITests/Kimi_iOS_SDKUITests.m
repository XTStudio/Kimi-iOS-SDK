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
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUIButton {
    [self.app.tables.cells[@"UIButton"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.buttons[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.buttons[@"Tap Require"].exists) {
            [self.app.buttons[@"Tap Require"] tap];
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUIImageView {
    [self.app.tables.cells[@"UIImageView"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.images[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUILabel {
    [self.app.tables.cells[@"UILabel"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.staticTexts[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUITextField {
    [self.app.tables.cells[@"UITextField"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.textFields[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.textFields[@"Input Require"].exists) {
            [self.app.textFields[@"Input Require"] typeText:@"Hello, Pony!"];
            continue;
        }
        if (self.app.textFields[@"Clear Require"].exists) {
            [self.app.textFields[@"Clear Require"].buttons[@"Clear text"] tap];
            continue;
        }
        if (self.app.textFields[@"Return Require"].exists) {
            [self.app.textFields[@"Return Require"] typeText:XCUIKeyboardKeyReturn];
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUITextView {
    [self.app.tables.cells[@"UITextView"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.textViews[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.textViews[@"Input Require"].exists) {
            [self.app.textViews[@"Input Require"] typeText:@"Hello, Pony!"];
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUICollectionView {
    [self.app.tables.cells[@"UICollectionView"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.collectionViews[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.cells[@"Tap Require"].exists) {
            [self.app.cells[@"Tap Require"] tap];
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUIDialogs {
    [self.app.tables.cells[@"UIDialogs"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.buttons[@"Tap Require"].exists) {
            [self.app.buttons[@"Tap Require"] tap];
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUIActivityIndicatorView {
    [self.app.tables.cells[@"UIActivityIndicatorView"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUISwitch {
    [self.app.tables.cells[@"UISwitch"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.switches[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.switches[@"Tap Require"].exists) {
            [self.app.switches[@"Tap Require"] tap];
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUISlider {
    [self.app.tables.cells[@"UISlider"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.sliders[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.sliders[@"Slide Require"].exists) {
            [self.app.sliders[@"Slide Require"] adjustToNormalizedSliderPosition:1.0];
            continue;
        }        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUIWebView {
    [self.app.tables.cells[@"UIWebView"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.otherElements[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        if (self.app.otherElements[@"Wait Require"].exists) {
            XCTAssertTrue([self.app.otherElements[@"sample view"] waitForExistenceWithTimeout:10.0]);
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUIStackView {
    [self.app.tables.cells[@"UIStackView"] tap];
    XCTAssertTrue(self.app.otherElements[@"main view"].exists);
    XCTAssertTrue(self.app.otherElements[@"sample view"].exists);
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
    [[self.app.navigationBars.buttons elementBoundByIndex:0] tap];
}

- (void)testUIViewController {
    [self.app.tables.cells[@"UIViewController"] tap];
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
}

- (void)testUINavigationController {
    [self.app.tables.cells[@"UINavigationController"] tap];
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        while (self.app.buttons[@"Tap Require"].exists) {
            [self.app.buttons[@"Tap Require"] tap];
            continue;
        }
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
}

- (void)testUITabBarController {
    [self.app.tables.cells[@"UITabBarController"] tap];
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
}

- (void)testUIPageViewController {
    [self.app.tables.cells[@"UIPageViewController"] tap];
    while (self.app.buttons[@"Next"].exists) {
        [self.app.buttons[@"Next"] tap];
        XCTAssertFalse(self.app.staticTexts[@"Fail"].exists);
    }
}

@end
