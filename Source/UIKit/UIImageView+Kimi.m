//
//  UIImageView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIImageView+Kimi.h"
#import "UIView+Kimi.h"
#import <xt_engine/EDOExporter.h>
#import <Aspects/Aspects.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIImageView", @"UIView");
    EDO_EXPORT_PROPERTY(@"image");
    EDO_EXPORT_METHOD_ALIAS(edo_loadImageWithURLString:placeholder:, @"loadImageWithURLString");
}

- (void)edo_loadImageWithURLString:(NSString *)URLString placeholder:(UIImage *)placeholder {
    [self sd_setImageWithURL:[NSURL URLWithString:URLString] placeholderImage:placeholder options:kNilOptions];
}

@end
