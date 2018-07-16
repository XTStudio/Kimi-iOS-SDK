//
//  UIStackView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/5.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIStackView+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIStackView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIStackView", @"UIView");
    EDO_EXPORT_INITIALIZER({
        UIStackView *instance = [[UIStackView alloc] initWithArrangedSubviews:0 < arguments.count && [arguments[0] isKindOfClass:[NSArray class]] ? arguments[0] : @[]];
        return instance;
    });
    EDO_EXPORT_READONLY_PROPERTY(@"arrangedSubviews");
    EDO_EXPORT_METHOD(addArrangedSubview:);
    EDO_EXPORT_METHOD(removeArrangedSubview:);
    EDO_EXPORT_METHOD_ALIAS(insertArrangedSubview:atIndex:, @"insertArrangedSubview");
    EDO_EXPORT_METHOD_ALIAS(edo_layoutArrangedSubview:size:, @"layoutArrangedSubview");
    EDO_EXPORT_PROPERTY(@"axis");
    EDO_EXPORT_PROPERTY(@"distribution");
    EDO_EXPORT_PROPERTY(@"alignment");
    EDO_EXPORT_PROPERTY(@"spacing");
    [[EDOExporter sharedExporter] exportEnum:@"UILayoutConstraintAxis"
                                      values:@{
                                               @"horizontal": @(UILayoutConstraintAxisHorizontal),
                                               @"vertical": @(UILayoutConstraintAxisVertical),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UIStackViewDistribution"
                                      values:@{
                                               @"fill": @(UIStackViewDistributionFill),
                                               @"fillEqually": @(UIStackViewDistributionFillEqually),
                                               @"fillProportionally": @(UIStackViewDistributionFillProportionally),
                                               @"equalSpacing": @(UIStackViewDistributionEqualSpacing),
                                               @"equalCentering": @(UIStackViewDistributionEqualCentering),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UIStackViewAlignment"
                                      values:@{
                                               @"fill": @(UIStackViewAlignmentFill),
                                               @"leading": @(UIStackViewAlignmentLeading),
                                               @"center": @(UIStackViewAlignmentCenter),
                                               @"trailing": @(UIStackViewAlignmentTrailing),
                                               }];
}

- (void)edo_layoutArrangedSubview:(UIView *)subview size:(NSDictionary *)size {
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [subview removeConstraints:subview.constraints];
    if ([size[@"width"] isKindOfClass:[NSNumber class]]) {
        [[subview.widthAnchor constraintEqualToConstant:[size[@"width"] floatValue]] setActive:YES];
    }
    if ([size[@"height"] isKindOfClass:[NSNumber class]]) {
        [[subview.heightAnchor constraintEqualToConstant:[size[@"height"] floatValue]] setActive:YES];
    }
}

@end
