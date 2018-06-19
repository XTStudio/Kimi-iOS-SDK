//
//  UIView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIView+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIView", nil)
    // Boxing
    EDO_EXPORT_PROPERTY(@"frame")
    EDO_EXPORT_PROPERTY(@"bounds")
    EDO_EXPORT_PROPERTY(@"center")
    EDO_EXPORT_PROPERTY(@"transform")
    // Actions
    EDO_EXPORT_PROPERTY(@"superview")
    EDO_EXPORT_PROPERTY(@"subviews")
    EDO_EXPORT_METHOD(removeFromSuperview)
    EDO_EXPORT_METHOD(insertSubview:atIndex:)
    EDO_EXPORT_METHOD_ALIAS(exchangeSubviewAtIndex:withSubviewAtIndex:, @"exchangeSubview")
    EDO_EXPORT_METHOD(addSubview:)
    EDO_EXPORT_METHOD(insertSubview:belowSubview:)
    EDO_EXPORT_METHOD(insertSubview:aboveSubview:)
    EDO_EXPORT_METHOD(bringSubviewToFront:)
    EDO_EXPORT_METHOD(sendSubviewToBack:)
    EDO_EXPORT_METHOD(isDescendantOfView:)
    EDO_EXPORT_METHOD(viewWithTag:)
    // Delegates
    EDO_BIND_METHOD(didAddSubview:)
    EDO_BIND_METHOD(willRemoveSubview:)
    EDO_BIND_METHOD(willMoveToSuperview:)
    EDO_BIND_METHOD(didMoveToSuperview)
    EDO_EXPORT_METHOD(setNeedsLayout)
    EDO_EXPORT_METHOD(layoutIfNeeded)
    EDO_BIND_METHOD(layoutSubviews)
    // Rendering
    EDO_EXPORT_METHOD(setNeedsDisplay)
    EDO_EXPORT_PROPERTY(@"clipsToBounds")
    EDO_EXPORT_PROPERTY(@"backgroundColor")
    EDO_EXPORT_PROPERTY(@"alpha")
    EDO_EXPORT_PROPERTY(@"hidden")
    EDO_EXPORT_PROPERTY(@"contentMode")
    EDO_EXPORT_PROPERTY(@"tintColor")
    EDO_BIND_METHOD(tintColorDidChange)
}

@end
