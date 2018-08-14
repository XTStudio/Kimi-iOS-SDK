//
//  UIScrollView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIScrollView+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>'
#import <objc/runtime.h>
#import "KIMIFetchMoreControl.h"

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
    EDO_EXPORT_READONLY_PROPERTY(@"tracking");
    EDO_EXPORT_READONLY_PROPERTY(@"dragging");
    EDO_EXPORT_READONLY_PROPERTY(@"decelerating");
    EDO_EXPORT_PROPERTY(@"scrollsToTop");
    EDO_EXPORT_METHOD(edo_addSubview:);
    // Classes
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        UIScrollView *instance = [[UIScrollView alloc] init];
        instance.delegate = instance;
        return instance;
    }];
}

- (void)edo_addSubview:(UIView *)view {
    if ([view isKindOfClass:[UIRefreshControl class]]) {
        if (@available(iOS 10.0, *)) {
            self.refreshControl = (UIRefreshControl *)view;
        } else {
            [self addSubview:view];
        }
        return;
    }
    if ([view isKindOfClass:[KIMIFetchMoreControl class]]) {
        self.kimi_fetchMoreControl = (KIMIFetchMoreControl *)view;
        [(KIMIFetchMoreControl *)view setScrollView:self];
        return;
    }
    [self addSubview:view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"didScroll" arguments:@[scrollView]];
    if (self.kimi_fetchMoreControl != nil) {
        [self.kimi_fetchMoreControl scrollViewDidScroll];
    }
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"didEndDecelerating" arguments:@[scrollView]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"didEndScrollingAnimation" arguments:@[scrollView]];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self edo_emitWithEventName:@"didScrollToTop" arguments:@[scrollView]];
}

#pragma mark - Private

static int kFetchMoreControlKey = 0;

- (KIMIFetchMoreControl *)kimi_fetchMoreControl {
    return objc_getAssociatedObject(self, &kFetchMoreControlKey);
}

- (void)setKimi_fetchMoreControl:(KIMIFetchMoreControl *)kimi_fetchMoreControl {
    objc_setAssociatedObject(self, &kFetchMoreControlKey, kimi_fetchMoreControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
