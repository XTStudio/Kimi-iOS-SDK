//
//  UIActivityIndicatorView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIActivityIndicatorView+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIActivityIndicatorView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIActivityIndicatorView", @"UIView");
    EDO_EXPORT_PROPERTY(@"color");
    EDO_EXPORT_READONLY_PROPERTY(@"animating");
    EDO_EXPORT_PROPERTY(@"edo_largeStyle");
    EDO_EXPORT_METHOD(startAnimating);
    EDO_EXPORT_METHOD(stopAnimating);
    EDO_EXPORT_INITIALIZER({
        UIActivityIndicatorView *instance = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        instance.hidesWhenStopped = YES;
        return instance;
    });
}

- (BOOL)edo_largeStyle {
    return self.activityIndicatorViewStyle == UIActivityIndicatorViewStyleWhiteLarge;
}

- (void)setEdo_largeStyle:(BOOL)edo_largeStyle {
    UIColor *color = self.color;
    self.activityIndicatorViewStyle = edo_largeStyle ? UIActivityIndicatorViewStyleWhiteLarge : UIActivityIndicatorViewStyleWhite;
    self.color = color;
}

@end
