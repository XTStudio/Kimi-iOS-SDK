//
//  CALayer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "CALayer+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation CALayer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"CALayer", nil);
    // Geometry
    EDO_EXPORT_PROPERTY(@"frame");
    // Hierarchy
    EDO_EXPORT_PROPERTY(@"superlayer");
    EDO_EXPORT_METHOD(removeFromSuperlayer);
    EDO_EXPORT_PROPERTY(@"sublayers");
    EDO_EXPORT_METHOD(addSublayer:);
    EDO_EXPORT_METHOD(insertSublayer:atIndex:);
    EDO_EXPORT_METHOD(insertSublayer:below:);
    EDO_EXPORT_METHOD(insertSublayer:above:);
    EDO_EXPORT_METHOD_ALIAS(replaceSublayer:with:, @"replaceSublayer");
    // Rendering
    EDO_EXPORT_PROPERTY(@"hidden");
    EDO_EXPORT_PROPERTY(@"mask");
    EDO_EXPORT_PROPERTY(@"edo_backgroundColor");
    EDO_EXPORT_PROPERTY(@"cornerRadius");
    EDO_EXPORT_PROPERTY(@"borderWidth");
    EDO_EXPORT_PROPERTY(@"edo_borderColor");
    EDO_EXPORT_PROPERTY(@"opacity");
    EDO_EXPORT_PROPERTY(@"edo_shadowColor");
    EDO_EXPORT_PROPERTY(@"shadowOpacity");
    EDO_EXPORT_PROPERTY(@"shadowOffset");
    EDO_EXPORT_PROPERTY(@"shadowRadius");
    [self aspect_hookSelector:@selector(addSublayer:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, CALayer *sublayer) {
        EDO_RETAIN(sublayer);
    } error:NULL];
    [self aspect_hookSelector:@selector(removeFromSuperlayer) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        EDO_RELEASE(aspectInfo.instance);
    } error:NULL];
    [self aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        for (CALayer *sublayer in [aspectInfo.instance sublayers]) {
            EDO_RELEASE(sublayer);
        }
    } error:NULL];
}

- (UIColor *)edo_backgroundColor {
    return [UIColor colorWithCGColor:self.backgroundColor];
}

- (void)setEdo_backgroundColor:(UIColor *)edo_backgroundColor {
    self.backgroundColor  = [edo_backgroundColor CGColor];
}

- (UIColor *)edo_borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setEdo_borderColor:(UIColor *)edo_borderColor {
    self.borderColor = [edo_borderColor CGColor];
}

- (UIColor *)edo_shadowColor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

- (void)setEdo_shadowColor:(UIColor *)edo_shadowColor {
    self.shadowColor = [edo_shadowColor CGColor];
}

@end
