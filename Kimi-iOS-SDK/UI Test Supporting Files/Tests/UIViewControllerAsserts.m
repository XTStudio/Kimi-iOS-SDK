//
//  UIViewControllerAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/16.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIViewControllerAsserts.h"

@implementation UIViewControllerAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIViewController *)mainObject {
    if ([caseName isEqualToString:@"viewDidLoad & viewWillAppear & viewDidAppear"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"viewDidLoad|"]
        && [mainObject.view.accessibilityIdentifier containsString:@"viewWillAppear|"]
        && [mainObject.view.accessibilityIdentifier containsString:@"viewDidAppear|"];
    }
    if ([caseName isEqualToString:@"viewWillLayoutSubviews"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"viewWillLayoutSubviews|"]
        && [mainObject.view.accessibilityIdentifier containsString:@"onViewWillLayoutSubviews|"];
    }
    if ([caseName isEqualToString:@"viewDidLayoutSubviews"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"viewDidLayoutSubviews|"];
    }
    if ([caseName isEqualToString:@"safeAreaInsets"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"safeAreaInsets|"];
    }
    if ([caseName isEqualToString:@"addChildViewController & removeFromParentViewController"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"addChildViewController|"]
        && [mainObject.view.accessibilityIdentifier containsString:@"removeFromParentViewController|"]
        && [mainObject.view.accessibilityIdentifier containsString:@"willMoveToParentViewController|"]
        && [mainObject.view.accessibilityIdentifier containsString:@"didMoveToParentViewController|"];
    }
    if ([caseName isEqualToString:@"presentViewController - Wait"]) {
        return [mainObject.view.accessibilityIdentifier containsString:@"presentViewController|"];
    }
    return YES;
}

@end
