//
//  UIImageView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIImageView+Kimi.h"
#import "UIView+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation UIImageView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIImageView", @"UIView");
    EDO_EXPORT_PROPERTY(@"image");
    [self aspect_hookSelector:@selector(setImage:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, UIImage *image) {
        if ([(UIImageView *)aspectInfo.instance image] != nil) {
            EDO_RELEASE([(UIImageView *)aspectInfo.instance image]);
        }
        if (image != nil) {
            EDO_RETAIN(image);
        }
    } error:NULL];
}

- (void)kimi_dealloc {
    [super kimi_dealloc];
    if (self.image != nil) {
        EDO_RELEASE(self.image);
    }
}

@end
