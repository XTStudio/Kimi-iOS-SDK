//
//  UIView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIView+Kimi.h"
#import <xt_engine/EDOExporter.h>
#import <objc/runtime.h>

@implementation UIView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIView", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"layer");
    EDO_EXPORT_METHOD(endEditing:);
    // Geometry
    EDO_EXPORT_PROPERTY(@"frame");
    EDO_EXPORT_PROPERTY(@"bounds");
    EDO_EXPORT_PROPERTY(@"center");
    EDO_EXPORT_PROPERTY(@"transform");
    EDO_EXPORT_PROPERTY(@"edo_touchAreaInsets");
    EDO_EXPORT_PROPERTY(@"edo_opaque");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [UIView class];
        SEL originalSelector = @selector(pointInside:withEvent:);
        SEL swizzledSelector = @selector(edo_pointInside:withEvent:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    // Hierarchy
    EDO_EXPORT_PROPERTY(@"tag");
    EDO_EXPORT_READONLY_PROPERTY(@"superview");
    EDO_EXPORT_READONLY_PROPERTY(@"subviews");
    EDO_EXPORT_READONLY_PROPERTY(@"window");
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
    // Accessibility
    EDO_EXPORT_PROPERTY(@"isAccessibilityElement");
    EDO_EXPORT_PROPERTY(@"accessibilityLabel");
    EDO_EXPORT_PROPERTY(@"accessibilityHint");
    EDO_EXPORT_PROPERTY(@"accessibilityValue");
    EDO_EXPORT_PROPERTY(@"accessibilityIdentifier");
    [[EDOExporter sharedExporter] exportEnum:@"UIViewContentMode"
                                      values:@{
                                               @"scaleToFill": @(UIViewContentModeScaleToFill),
                                               @"scaleAspectFit": @(UIViewContentModeScaleAspectFit),
                                               @"scaleAspectFill": @(UIViewContentModeScaleAspectFill),
                                               }];
}

- (BOOL)edo_opaque {
    return self.isOpaque;
}

- (void)setEdo_opaque:(BOOL)opaque {
    [self setOpaque:opaque];
}

static int kTouchAreaInsetsKey;

- (UIEdgeInsets)edo_touchAreaInsets {
    return [objc_getAssociatedObject(self, &kTouchAreaInsetsKey) UIEdgeInsetsValue];
}

- (void)setEdo_touchAreaInsets:(UIEdgeInsets)edo_touchAreaInsets {
    objc_setAssociatedObject(self, &kTouchAreaInsetsKey, [NSValue valueWithUIEdgeInsets:edo_touchAreaInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)edo_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (objc_getAssociatedObject(self, &kTouchAreaInsetsKey) != nil) {
        UIEdgeInsets touchAreaInsets = self.edo_touchAreaInsets;
        return CGRectContainsPoint(CGRectMake(0.0 - touchAreaInsets.left,
                                              0.0 - touchAreaInsets.top,
                                              self.bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                                              self.bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom),
                                   point);
    }
    return [self edo_pointInside:point withEvent:event];
}

@end
