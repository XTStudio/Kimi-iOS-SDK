//
//  UIButton+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIButton+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIButton (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIButton", @"UIView");
    EDO_EXPORT_INITIALIZER({
        UIButton *button = [UIButton buttonWithType:[arguments count] >= 1 && [arguments[0] boolValue] == YES ? UIButtonTypeCustom : UIButtonTypeSystem];
        [button addTarget:button action:@selector(edo_handleTouchDown) forControlEvents:UIControlEventTouchDown];
        [button addTarget:button action:@selector(edo_handleTouchDownRepeat) forControlEvents:UIControlEventTouchDownRepeat];
        [button addTarget:button action:@selector(edo_handleTouchDragInside) forControlEvents:UIControlEventTouchDragInside];
        [button addTarget:button action:@selector(edo_handleTouchDragOutside) forControlEvents:UIControlEventTouchDragOutside];
        [button addTarget:button action:@selector(edo_handleTouchDragEnter) forControlEvents:UIControlEventTouchDragEnter];
        [button addTarget:button action:@selector(edo_handleTouchDragExit) forControlEvents:UIControlEventTouchDragExit];
        [button addTarget:button action:@selector(edo_handleTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:button action:@selector(edo_handleTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:button action:@selector(edo_handleTouchCancel) forControlEvents:UIControlEventTouchCancel];
        return button;
    });
    EDO_EXPORT_PROPERTY(@"enabled");
    EDO_EXPORT_PROPERTY(@"selected");
    EDO_EXPORT_READONLY_PROPERTY(@"highlighted");
    EDO_EXPORT_READONLY_PROPERTY(@"tracking");
    EDO_EXPORT_READONLY_PROPERTY(@"touchInside");
    EDO_EXPORT_PROPERTY(@"contentVerticalAlignment");
    EDO_EXPORT_PROPERTY(@"contentHorizontalAlignment");
    EDO_EXPORT_METHOD_ALIAS(setTitle:forState:, @"setTitle");
    EDO_EXPORT_METHOD_ALIAS(setTitleColor:forState:, @"setTitleColor");
    EDO_EXPORT_METHOD_ALIAS(edo_setTitleFont:, @"setTitleFont");
    EDO_EXPORT_METHOD_ALIAS(setImage:forState:, @"setImage");
    EDO_EXPORT_METHOD_ALIAS(setAttributedTitle:forState:, @"setAttributedTitle");
    EDO_EXPORT_PROPERTY(@"contentEdgeInsets");
    EDO_EXPORT_PROPERTY(@"titleEdgeInsets");
    EDO_EXPORT_PROPERTY(@"imageEdgeInsets");
    EDO_BIND_METHOD(layoutSubviews);
    [[EDOExporter sharedExporter] exportEnum:@"UIControlState"
                                      values:@{
                                               @"normal": @(UIControlStateNormal),
                                               @"highlighted": @(UIControlStateHighlighted),
                                               @"disabled": @(UIControlStateDisabled),
                                               @"selected": @(UIControlStateSelected),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UIControlContentVerticalAlignment"
                                      values:@{
                                               @"top": @(UIControlContentVerticalAlignmentTop),
                                               @"center": @(UIControlContentVerticalAlignmentCenter),
                                               @"bottom": @(UIControlContentVerticalAlignmentBottom),
                                               @"fill": @(UIControlContentVerticalAlignmentFill),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UIControlContentHorizontalAlignment"
                                      values:@{
                                               @"left": @(UIControlContentHorizontalAlignmentLeft),
                                               @"center": @(UIControlContentHorizontalAlignmentCenter),
                                               @"right": @(UIControlContentHorizontalAlignmentRight),
                                               @"fill": @(UIControlContentHorizontalAlignmentFill),
                                               }];
}

- (void)edo_handleTouchDown {
    [self edo_emitWithEventName:@"touchDown" arguments:@[self]];
}

- (void)edo_handleTouchDownRepeat {
    [self edo_emitWithEventName:@"touchDownRepeat" arguments:@[self]];
}

- (void)edo_handleTouchDragInside {
    [self edo_emitWithEventName:@"touchDragInside" arguments:@[self]];
}

- (void)edo_handleTouchDragOutside {
    [self edo_emitWithEventName:@"touchDragOutside" arguments:@[self]];
}

- (void)edo_handleTouchDragEnter {
    [self edo_emitWithEventName:@"touchDragEnter" arguments:@[self]];
}

- (void)edo_handleTouchDragExit {
    [self edo_emitWithEventName:@"touchDragExit" arguments:@[self]];
}

- (void)edo_handleTouchUpInside {
    [self edo_emitWithEventName:@"touchUpInside" arguments:@[self]];
}

- (void)edo_handleTouchUpOutside {
    [self edo_emitWithEventName:@"touchUpOutside" arguments:@[self]];
}

- (void)edo_handleTouchCancel {
    [self edo_emitWithEventName:@"touchCancel" arguments:@[self]];
}

- (void)edo_setTitleFont:(UIFont *)font {
    self.titleLabel.font = font;
}

@end
