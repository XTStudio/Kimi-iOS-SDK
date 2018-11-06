//
//  CAGradientLayer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "CAGradientLayer+Kimi.h"
#import <xt-engine/EDOExporter.h>
#import <UIKit/UIKit.h>

@implementation CAGradientLayer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"CAGradientLayer", @"CALayer");
    EDO_EXPORT_PROPERTY(@"edo_colors");
    EDO_EXPORT_PROPERTY(@"locations");
    EDO_EXPORT_PROPERTY(@"startPoint");
    EDO_EXPORT_PROPERTY(@"endPoint");
}

- (NSArray<UIColor *> *)edo_colors {
    NSMutableArray *colors = [NSMutableArray array];
    for (id colorRef in self.colors) {
        [colors addObject:[UIColor colorWithCGColor:(__bridge CGColorRef _Nonnull)(colorRef)]];
    }
    return [colors copy];
}

- (void)setEdo_colors:(NSArray<UIColor *> *)edo_colors {
    NSMutableArray *colors = [NSMutableArray array];
    for (UIColor *color in edo_colors) {
        [colors addObject:(__bridge id)[color CGColor]];
    }
    self.colors = colors.copy;
}

@end
