//
//  UIScrollViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/16.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIScrollViewAsserts.h"

@implementation UIScrollViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Plain Properties"]) {
        UIScrollView *scrollView = mainObject.subviews[0];
        return CGPointEqualToPoint(scrollView.contentOffset, CGPointMake(0, 300))
        && CGSizeEqualToSize(scrollView.contentSize, CGSizeMake(1, 2000))
        && UIEdgeInsetsEqualToEdgeInsets(scrollView.contentInset, UIEdgeInsetsMake(44, 0, 0, 0))
        && scrollView.directionalLockEnabled
        && scrollView.bounces
        && scrollView.alwaysBounceVertical
        && scrollView.alwaysBounceHorizontal
        && scrollView.pagingEnabled
        && !scrollView.scrollEnabled
        && !scrollView.showsHorizontalScrollIndicator
        && !scrollView.showsVerticalScrollIndicator
        && scrollView.scrollsToTop;
    }
    if ([caseName isEqualToString:@"setContentOffset - Wait"]) {
        UIScrollView *scrollView = mainObject.subviews[0];
        return scrollView.contentOffset.y == 600;
    }
    if ([caseName isEqualToString:@"scrollRectToVisible - Wait"]) {
        UIScrollView *scrollView = mainObject.subviews[0];
        return scrollView.contentOffset.y == -44;
    }
    if ([caseName isEqualToString:@"Delegates - Pan"]) {
        return [mainObject.accessibilityIdentifier containsString:@"didScroll|"]
        && [mainObject.accessibilityIdentifier containsString:@"willBeginDragging|"]
        && [mainObject.accessibilityIdentifier containsString:@"willEndDragging|"]
        && [mainObject.accessibilityIdentifier containsString:@"didEndDragging|"]
        && [mainObject.accessibilityIdentifier containsString:@"willBeginDecelerating|"]
        && [mainObject.accessibilityIdentifier containsString:@"didEndDecelerating|"];
    }
    return YES;
}

@end
