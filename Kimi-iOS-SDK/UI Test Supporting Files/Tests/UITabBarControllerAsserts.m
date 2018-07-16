//
//  UITabBarControllerAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/16.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITabBarControllerAsserts.h"

@implementation UITabBarControllerAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UITabBarController *)mainObject {
    if ([caseName isEqualToString:@"setViewControllers"]) {
        return mainObject.viewControllers.count == 3;
    }
    if ([caseName isEqualToString:@"selectedIndex"]) {
        return [mainObject.selectedViewController.view.backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"selectedViewController"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"selectedViewController|"];
    }
    return YES;
}

@end
