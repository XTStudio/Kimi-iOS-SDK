//
//  KimiUITestViewsViewController.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/12.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KimiUITestViewsViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Endo/EDOExporter.h>
#import "KIMIUITestAsserts.h"

typedef void(^GestureWaitingBlock)();

@interface KimiUITestViewsViewController ()

@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) UIView *main;
@property (nonatomic, strong) NSString *testName;
@property (nonatomic, assign) NSInteger testIdx;
@property (nonatomic, strong) KIMIUITestAsserts *asserts;
@property (nonatomic, copy) GestureWaitingBlock gestureWaitingBlock;

@end

@implementation KimiUITestViewsViewController

static UIWindow *tipsWindow;

- (instancetype)initWithTestName:(NSString *)testName
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _testName = testName;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.title = self.testName;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *scriptPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@Tests", self.testName] ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:NULL];
    self.asserts = [NSClassFromString([NSString stringWithFormat:@"%@Asserts", self.testName]) new];
    self.context = [[JSContext alloc] init];
    [[EDOExporter sharedExporter] exportWithContext:self.context];
    [self.context evaluateScript:script];
    self.main = [[EDOExporter sharedExporter] nsValueWithJSValue:[self.context objectForKeyedSubscript:@"main"]];
    if ([self.main isKindOfClass:[UIView class]]) {
        [self.view addSubview:self.main];
    }
    [self setupTestCase];
}

- (void)setupTestCase {
    self.testIdx = 0;
    UIBarButtonItem *nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(handleNext)];
    self.navigationItem.rightBarButtonItem = nextButtonItem;
    if (tipsWindow == nil) {
        tipsWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 20)];
        tipsWindow.hidden = NO;
        tipsWindow.userInteractionEnabled = NO;
        tipsWindow.windowLevel = UIWindowLevelStatusBar + 1;
    }
}

- (void)handleNext {
    if (self.gestureWaitingBlock != nil) {
        self.gestureWaitingBlock();
        self.gestureWaitingBlock = nil;
        return;
    }
    NSString *name = [self.context evaluateScript:[NSString stringWithFormat:@"tests[%ld].name", (long)self.testIdx]].toString;
    if (![name isEqualToString:@"undefined"]) {
        [self.context evaluateScript:[NSString stringWithFormat:@"tests[%ld].action()", (long)self.testIdx]];
        __block void (^assertBlock)(void) = ^ void () {
            BOOL testPass = [self.asserts assert:name mainObject:self.main];
            NSLog(@"%@", [NSString stringWithFormat:@"%@ - %@", (testPass ? @"Pass" : @"Fail"), name]);
            UILabel *statusBarView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 20)];
            statusBarView.backgroundColor = [UIColor whiteColor];
            statusBarView.textAlignment = NSTextAlignmentCenter;
            statusBarView.font = [UIFont systemFontOfSize:14];
            statusBarView.textColor = testPass ? [UIColor blackColor] : [UIColor redColor];
            statusBarView.text = [NSString stringWithFormat:@"%@ - %@", (testPass ? @"Pass" : @"Fail"), name];
            statusBarView.accessibilityIdentifier = testPass ? @"Pass" : @"Fail";
            statusBarView.alpha = 0.0;
            [tipsWindow addSubview:statusBarView];
            [UIView animateWithDuration:0.15 animations:^{
                statusBarView.alpha = 1.0;
            } completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.15 animations:^{
                        statusBarView.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        [statusBarView removeFromSuperview];
                    }];
                });
            }];
            self.testIdx++;
        };
        if ([name containsString:@" - "]) {
            self.gestureWaitingBlock = assertBlock;
        }
        else {
            assertBlock();
        }
    }
    else {
        self.navigationItem.rightBarButtonItem = nil;
        self.fulfilled = YES;
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.main.frame = self.view.bounds;
}

@end
