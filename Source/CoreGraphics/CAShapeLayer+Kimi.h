//
//  CAShapeLayer+Kimi.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class UIBezierPath, UIColor;

@interface CAShapeLayer (Kimi)

@property (nonatomic, strong) UIBezierPath *edo_path;
@property (nonatomic, strong) UIColor *edo_fillColor;
@property (nonatomic, strong) UIColor *edo_strokeColor;

@end
