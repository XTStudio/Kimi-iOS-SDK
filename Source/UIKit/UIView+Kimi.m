//
//  UIView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIView+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation UIView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIView", nil);
    EDO_EXPORT_PROPERTY(@"layer");
    // Geometry
    EDO_EXPORT_PROPERTY(@"frame");
    EDO_EXPORT_PROPERTY(@"bounds");
    EDO_EXPORT_PROPERTY(@"center");
    EDO_EXPORT_PROPERTY(@"transform");
    // Hierarchy
    EDO_EXPORT_PROPERTY(@"tag");
    EDO_EXPORT_PROPERTY(@"superview");
    EDO_EXPORT_PROPERTY(@"subviews");
    EDO_EXPORT_METHOD(removeFromSuperview);
    EDO_EXPORT_METHOD(insertSubview:atIndex:);
    EDO_EXPORT_METHOD_ALIAS(exchangeSubviewAtIndex:withSubviewAtIndex:, @"exchangeSubview");
    EDO_EXPORT_METHOD(addSubview:);
    EDO_EXPORT_METHOD(insertSubview:belowSubview:);
    EDO_EXPORT_METHOD(insertSubview:aboveSubview:);
    EDO_EXPORT_METHOD(bringSubviewToFront:);
    EDO_EXPORT_METHOD(sendSubviewToBack:);
    EDO_EXPORT_METHOD(isDescendantOfView:);
    EDO_EXPORT_METHOD(viewWithTag:);
    // Delegates
    EDO_BIND_METHOD(didAddSubview:);
    EDO_BIND_METHOD(willRemoveSubview:);
    EDO_BIND_METHOD(willMoveToSuperview:);
    EDO_BIND_METHOD(didMoveToSuperview);
    EDO_EXPORT_METHOD(setNeedsLayout);
    EDO_EXPORT_METHOD(layoutIfNeeded);
    EDO_BIND_METHOD(layoutSubviews);
    // Rendering
    EDO_EXPORT_METHOD(setNeedsDisplay);
    EDO_EXPORT_PROPERTY(@"clipsToBounds");
    EDO_EXPORT_PROPERTY(@"backgroundColor");
    EDO_EXPORT_PROPERTY(@"alpha");
    EDO_EXPORT_PROPERTY(@"hidden");
    EDO_EXPORT_PROPERTY(@"contentMode");
    EDO_EXPORT_PROPERTY(@"tintColor");
    EDO_BIND_METHOD(tintColorDidChange);
    // GestureRecognizers
    EDO_EXPORT_PROPERTY(@"userInteractionEnabled");
    EDO_EXPORT_PROPERTY(@"gestureRecognizers");
    EDO_EXPORT_METHOD(addGestureRecognizer:);
    EDO_EXPORT_METHOD(removeGestureRecognizer:);
    // Retain & Release
    [[UIView class] aspect_hookSelector:@selector(didAddSubview:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, UIView *subview) {
        EDO_RETAIN(subview);
    } error:NULL];
    [[UIView class] aspect_hookSelector:@selector(willRemoveSubview:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, UIView *subview) {
        EDO_RELEASE(subview);
    } error:NULL];
    [[UIView class] aspect_hookSelector:@selector(addGestureRecognizer:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, UIGestureRecognizer *gestureRecognizer) {
        EDO_RETAIN(gestureRecognizer);
    } error:NULL];
    [[EDOExporter sharedExporter] exportEnum:@"UIViewContentMode"
                                      values:@{
                                               @"scaleToFill": @(UIViewContentModeScaleToFill),
                                               @"scaleAspectFit": @(UIViewContentModeScaleAspectFit),
                                               @"scaleAspectFill": @(UIViewContentModeScaleAspectFill),
                                               }];
}

- (void)edo_release {
    [super edo_release];
#ifdef DEV
    NSLog(@"%@ released", [self class]);
#endif
    NSArray<UIGestureRecognizer *> *gestureRecognizers = [self gestureRecognizers];
    if (gestureRecognizers != nil) {
        for (UIGestureRecognizer *gestureRecognizer in gestureRecognizers) {
            EDO_RELEASE(gestureRecognizer);
        }
    }
}

@end
