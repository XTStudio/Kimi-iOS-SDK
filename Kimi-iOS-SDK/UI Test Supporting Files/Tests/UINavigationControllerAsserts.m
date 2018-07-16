//
//  UINavigationControllerAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/16.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UINavigationControllerAsserts.h"

@implementation UINavigationControllerAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UINavigationController *)mainObject {
    if ([caseName isEqualToString:@"rootViewController"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"rootViewController|"];
    }
    if ([caseName isEqualToString:@"pushViewController - Wait"]) {
        return mainObject.childViewControllers.count == 2;
    }
    if ([caseName isEqualToString:@"popViewController - Wait"]) {
        return mainObject.childViewControllers.count == 1;
    }
    if ([caseName isEqualToString:@"popToViewController - Wait"]) {
        return [mainObject.childViewControllers.lastObject.view.backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"popToRootViewController - Wait"]) {
        return mainObject.childViewControllers.count == 1;
    }
    if ([caseName isEqualToString:@"setViewControllers - Wait"]) {
        return mainObject.childViewControllers.count == 3
        && [mainObject.childViewControllers.lastObject.view.backgroundColor isEqual:[UIColor yellowColor]];
    }
    if ([caseName isEqualToString:@"UIViewController.navigationController"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"navigationController|"];
    }
    if ([caseName isEqualToString:@"UIViewController.navigationItem - Tap"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"leftButtonItem|"]
        && [mainObject.view.accessibilityIdentifier containsString:@"rightButtonItem|"];
    }
    if ([caseName isEqualToString:@"navigationBar"]) {
        return mainObject.navigationBar.alpha = 0.5;
    }
    if ([caseName isEqualToString:@"navigationBar.hidden"]) {
        return mainObject.isNavigationBarHidden;
    }
    return YES;
}

@end
