//
//  UIBezierPath+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIBezierPath+Kimi.h"
#import <xt-engine/EDOExporter.h>

@implementation UIBezierPath (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIBezierPath", nil);
    EDO_EXPORT_METHOD_ALIAS(moveToPoint:, @"moveTo");
    EDO_EXPORT_METHOD_ALIAS(addLineToPoint:, @"addLineTo");
    EDO_EXPORT_METHOD_ALIAS(addArcWithCenter:radius:startAngle:endAngle:clockwise:, @"addArcTo");
    EDO_EXPORT_METHOD_ALIAS(addCurveToPoint:controlPoint1:controlPoint2:, @"addCurveTo");
    EDO_EXPORT_METHOD_ALIAS(addQuadCurveToPoint:controlPoint:, @"addQuadCurveTo");
    EDO_EXPORT_METHOD(closePath);
    EDO_EXPORT_METHOD(removeAllPoints);
    EDO_EXPORT_METHOD(appendPath:)
}

@end
