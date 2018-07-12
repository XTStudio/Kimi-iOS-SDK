//
//  CAShapeLayer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "CAShapeLayer+Kimi.h"
#import <Endo/EDOExporter.h>
#import <UIKit/UIKit.h>

@implementation CAShapeLayer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"CAShapeLayer", @"CALayer");
    EDO_EXPORT_PROPERTY(@"edo_path");
    EDO_EXPORT_PROPERTY(@"edo_fillColor");
    EDO_EXPORT_PROPERTY(@"fillRule");
    EDO_EXPORT_PROPERTY(@"lineCap");
    EDO_EXPORT_PROPERTY(@"lineDashPattern");
    EDO_EXPORT_PROPERTY(@"lineDashPhase");
    EDO_EXPORT_PROPERTY(@"lineJoin");
    EDO_EXPORT_PROPERTY(@"lineWidth");
    EDO_EXPORT_PROPERTY(@"miterLimit");
    EDO_EXPORT_PROPERTY(@"edo_strokeColor");
    EDO_EXPORT_PROPERTY(@"strokeStart");
    EDO_EXPORT_PROPERTY(@"strokeEnd");
    [[EDOExporter sharedExporter] exportEnum:@"CAShapeFillRule"
                                      values:@{
                                               @"nonZero": kCAFillRuleNonZero,
                                               @"evenOdd": kCAFillRuleEvenOdd,
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"CAShapeLineCap"
                                      values:@{
                                               @"butt": kCALineCapButt,
                                               @"round": kCALineCapRound,
                                               @"square": kCALineCapSquare,
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"CAShapeLineJoin"
                                      values:@{
                                               @"miter": kCALineJoinMiter,
                                               @"round": kCALineJoinRound,
                                               @"bevel": kCALineJoinBevel,
                                               }];
}

- (UIBezierPath *)edo_path {
    if (self.path == NULL) {
        return nil;
    }
    return [UIBezierPath bezierPathWithCGPath:self.path];
}

- (void)setEdo_path:(UIBezierPath *)edo_path {
    self.path = edo_path.CGPath;
}

- (UIColor *)edo_fillColor {
    return [UIColor colorWithCGColor:self.fillColor];
}

- (void)setEdo_fillColor:(UIColor *)edo_fillColor {
    self.fillColor = [edo_fillColor CGColor];
}

- (UIColor *)edo_strokeColor {
    return [UIColor colorWithCGColor:self.strokeColor];
}

- (void)setEdo_strokeColor:(UIColor *)edo_strokeColor {
    self.strokeColor = [edo_strokeColor CGColor];
}

@end
