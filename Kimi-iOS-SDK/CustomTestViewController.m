//
//  ViewController.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <Endo/EDOExporter.h>
#import "CustomTestViewController.h"
#import "KIMIDebugger.h"

@interface CustomTestViewController ()

@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) KIMIDebugger *debugger;

@end

@implementation CustomTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Custom";
    [self loadContent];
}

- (void)loadContent {
    self.debugger = [[KIMIDebugger alloc] initWithRemoteAddress:nil];
    [self.debugger connect:^(JSContext *context) {
        self.context = context;
        [self attach];
    } fallback:^{
        self.context = [[JSContext alloc] init];
        [[EDOExporter sharedExporter] exportWithContext:self.context];
        [self.context evaluateScript:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"custom" ofType:@"js"]
                                                               encoding:NSUTF8StringEncoding
                                                                  error:nil]];
        [self attach];
    }];
}

- (void)attach {
    UIViewController *viewController = [[EDOExporter sharedExporter] nsValueWithJSValue:self.context[@"main"]];
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    viewController.view.frame = self.view.bounds;
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
}

@end
