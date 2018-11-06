//
//  CALayer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "CALayer+Kimi.h"
#import "EDOExporter.h"

@implementation CALayer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"CALayer", nil);
    // Geometry
    EDO_EXPORT_PROPERTY(@"frame");
    // Hierarchy
    EDO_EXPORT_READONLY_PROPERTY(@"superlayer");
    EDO_EXPORT_METHOD(removeFromSuperlayer);
    EDO_EXPORT_READONLY_PROPERTY(@"sublayers");
    EDO_EXPORT_METHOD(addSublayer:);
    EDO_EXPORT_METHOD(insertSublayer:atIndex:);
    EDO_EXPORT_METHOD(insertSublayer:below:);
    EDO_EXPORT_METHOD(insertSublayer:above:);
    EDO_EXPORT_METHOD_ALIAS(replaceSublayer:with:, @"replaceSublayer");
    // Rendering
    EDO_EXPORT_PROPERTY(@"hidden");
    EDO_EXPORT_PROPERTY(@"mask");
    EDO_EXPORT_PROPERTY(@"masksToBounds");
    EDO_EXPORT_PROPERTY(@"edo_backgroundColor");
    EDO_EXPORT_PROPERTY(@"cornerRadius");
    EDO_EXPORT_PROPERTY(@"borderWidth");
    EDO_EXPORT_PROPERTY(@"edo_borderColor");
    EDO_EXPORT_PROPERTY(@"opacity");
    EDO_EXPORT_PROPERTY(@"edo_shadowColor");
    EDO_EXPORT_PROPERTY(@"shadowOpacity");
    EDO_EXPORT_PROPERTY(@"shadowOffset");
    EDO_EXPORT_PROPERTY(@"shadowRadius");
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
