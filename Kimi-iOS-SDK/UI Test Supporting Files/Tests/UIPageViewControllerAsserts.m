//
//  UIPageViewControllerAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/16.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIPageViewControllerAsserts.h"

@implementation UIPageViewControllerAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIPageViewController *)mainObject {
    if ([caseName isEqualToString:@"setPageItems & loops"]) {
        return [mainObject.viewControllers.firstObject.view.backgroundColor isEqual:[UIColor yellowColor]];
    }
    if ([caseName isEqualToString:@"scrollToNextPage - Wait"]) {
        return [mainObject.viewControllers.firstObject.view.backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"scrollToPreviousPage - Wait"]) {
        return [mainObject.viewControllers.firstObject.view.backgroundColor isEqual:[UIColor yellowColor]];
    }
    if ([caseName isEqualToString:@"Loops - Wait"]) {
        return [mainObject.viewControllers.firstObject.view.backgroundColor isEqual:[UIColor yellowColor]];
    }
    if ([caseName isEqualToString:@"dataSource - Wait"]) {
        return [mainObject.viewControllers.firstObject.view.backgroundColor isEqual:[UIColor yellowColor]];
    }
    if ([caseName isEqualToString:@"dataSource2 - Wait"]) {
        return [mainObject.viewControllers.firstObject.view.backgroundColor isEqual:[UIColor blueColor]];
    }
    return YES;
}

@end
