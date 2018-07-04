//
//  UITabBarController+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITabBarController+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UITabBarController (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITabBarController", @"UIViewController");
    EDO_EXPORT_PROPERTY(@"selectedIndex");
    EDO_EXPORT_PROPERTY(@"selectedViewController");
    EDO_EXPORT_METHOD_ALIAS(setViewControllers:animated:, @"setViewControllers");
    EDO_EXPORT_READONLY_PROPERTY(@"tabBar");
}

@end
