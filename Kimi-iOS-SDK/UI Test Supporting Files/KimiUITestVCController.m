//
//  KimiUITestVCController.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/16.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KimiUITestVCController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <xt-engine/EDOExporter.h>
#import "KIMIUITestAsserts.h"

typedef void(^GestureWaitingBlock2)(void);

@interface KimiUITestVCController()

@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) UIViewController *main;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, assign) NSInteger testIdx;
@property (nonatomic, strong) KIMIUITestAsserts *asserts;
@property (nonatomic, copy) GestureWaitingBlock2 gestureWaitingBlock;

@end

@implementation KimiUITestVCController

static UIWindow *optWindow;
static UIWindow *tipsWindow;

- (instancetype)initWithTestName:(NSString *)testName
{
    self = [super init];
    if (self) {
        NSString *scriptPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@Tests", testName] ofType:@"js"];
        NSString *script = [NSString stringWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:NULL];
        self.asserts = [NSClassFromString([NSString stringWithFormat:@"%@Asserts", testName]) new];
        self.context = [[JSContext alloc] init];
        [[EDOExporter sharedExporter] exportWithContext:self.context];
        [self.context evaluateScript:script];
        self.main = [[EDOExporter sharedExporter] nsValueWithJSValue:[self.context objectForKeyedSubscript:@"main"]];
        [self setupTestCase];
    }
    return self;
}

- (void)present:(UIViewController *)fromViewController {
    [fromViewController presentViewController:self.main animated:NO completion:nil];
}

- (void)setupTestCase {
    self.testIdx = 0;
    if (self.nextButton == nil) {
        self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.nextButton.backgroundColor = [UIColor redColor];
        self.nextButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 44, [UIScreen mainScreen].bounds.size.width - 120, 44, 44);
        self.nextButton.accessibilityIdentifier = @"Next";
        [[UIApplication sharedApplication].keyWindow addSubview:self.nextButton];
        [self.nextButton addTarget:self action:@selector(handleNext) forControlEvents:UIControlEventTouchUpInside];
    }
    if (tipsWindow == nil) {
        tipsWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 20)];
        tipsWindow.hidden = NO;
        tipsWindow.userInteractionEnabled = NO;
        tipsWindow.windowLevel = UIWindowLevelStatusBar + 2;
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
        [self.nextButton removeFromSuperview];
        self.fulfilled = YES;
    }
}

@end
