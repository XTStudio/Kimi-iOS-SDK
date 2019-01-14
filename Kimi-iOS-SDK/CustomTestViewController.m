//
//  ViewController.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "EDOFactory.h"
#import "CustomTestViewController.h"

@interface CustomTestViewController ()

@property (nonatomic, strong) JSContext *context;

@end

@implementation CustomTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Custom";
    [self loadContent];
}

- (void)loadContent {
    JSContext *context = [EDOFactory decodeContextFromBundle:@"custom.js"
                                         withDebuggerAddress:nil
                                                onReadyBlock:^(JSContext * _Nonnull context) {
                                                    self.context = context;
                                                    [self attach];
    }];
//    self.context = context;
//    [self attach];
}

- (void)attach {
    UIViewController *viewController = [EDOFactory viewControllerFromContext:self.context withName:nil];
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    viewController.view.frame = self.view.bounds;
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
}

@end
