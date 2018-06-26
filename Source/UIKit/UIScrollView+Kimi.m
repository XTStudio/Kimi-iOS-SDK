//
//  UIScrollView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIScrollView+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation UIScrollView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIScrollView", @"UIView");
    EDO_EXPORT_PROPERTY(@"contentOffset");
    EDO_EXPORT_PROPERTY(@"contentSize");
    EDO_EXPORT_PROPERTY(@"contentInset");
    EDO_EXPORT_PROPERTY(@"directionalLockEnabled");
    EDO_EXPORT_PROPERTY(@"bounces");
    EDO_EXPORT_PROPERTY(@"alwaysBounceVertical");
    EDO_EXPORT_PROPERTY(@"alwaysBounceHorizontal");
    EDO_EXPORT_PROPERTY(@"pagingEnabled");
    EDO_EXPORT_PROPERTY(@"scrollEnabled");
    EDO_EXPORT_PROPERTY(@"showsHorizontalScrollIndicator");
    EDO_EXPORT_PROPERTY(@"showsVerticalScrollIndicator");
    EDO_EXPORT_PROPERTY(@"decelerationRate");
    EDO_EXPORT_METHOD_ALIAS(setContentOffset:animated:, @"setContentOffset");
    EDO_EXPORT_METHOD_ALIAS(scrollRectToVisible:animated:, @"scrollRectToVisible");
    EDO_EXPORT_PROPERTY(@"tracking");
    EDO_EXPORT_PROPERTY(@"dragging");
    EDO_EXPORT_PROPERTY(@"decelerating");
    EDO_EXPORT_PROPERTY(@"scrollsToTop");
    // Classes
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        UIScrollView *instance = [[UIScrollView alloc] init];
        instance.delegate = instance;
        return instance;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"didScroll" arguments:@[scrollView]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"willBeginDragging" arguments:@[scrollView]];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSValue *value = [self edo_valueWithEventName:@"willEndDragging" arguments:@[scrollView, [NSValue valueWithCGPoint:velocity]]];
    if ([value isKindOfClass:[NSValue class]]) {
        targetContentOffset -> x = value.CGPointValue.x;
        targetContentOffset -> y = value.CGPointValue.y;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self edo_emitWithEventName:@"didEndDragging" arguments:@[scrollView, @(decelerate)]];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"willBeginDecelerating" arguments:@[scrollView]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"didEndScrollingAnimation" arguments:@[scrollView]];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"didScrollToTop" arguments:@[scrollView]];
}

@end
