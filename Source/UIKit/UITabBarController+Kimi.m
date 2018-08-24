//
//  UITabBarController+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITabBarController+Kimi.h"
#import <Endo/EDOExporter.h>

@interface KIMITabBarController: UITabBarController

@property (nonatomic, assign) BOOL kimi_viewDidLoadCalled;

@end

@implementation KIMITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.kimi_viewDidLoadCalled) {
        self.kimi_viewDidLoadCalled = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self viewDidLoad];
        });
    }
}

@end

@implementation UITabBarController (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITabBarController", @"UIViewController");
    EDO_EXPORT_PROPERTY(@"selectedIndex");
    EDO_EXPORT_PROPERTY(@"selectedViewController");
    EDO_EXPORT_METHOD_ALIAS(setViewControllers:animated:, @"setViewControllers");
    EDO_EXPORT_READONLY_PROPERTY(@"tabBar");
    EDO_EXPORT_INITIALIZER({
        return [[KIMITabBarController alloc] init];
    })
}

@end
