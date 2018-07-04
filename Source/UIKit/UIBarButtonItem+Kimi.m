//
//  UIBarButtonItem+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIBarButtonItem+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIBarButtonItem (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIBarButtonItem", nil);
    EDO_EXPORT_PROPERTY(@"title");
    EDO_EXPORT_PROPERTY(@"titleAttributes");
    EDO_EXPORT_PROPERTY(@"image");
    EDO_EXPORT_PROPERTY(@"tintColor");
    EDO_EXPORT_PROPERTY(@"width");
    EDO_EXPORT_PROPERTY(@"customView");
    EDO_EXPORT_INITIALIZER({
        UIBarButtonItem *instance = [[UIBarButtonItem alloc] init];
        [instance setTarget:instance];
        [instance setAction:@selector(kimi_handleTouchUpInside)];
        return instance;
    });
}

- (void)kimi_handleTouchUpInside {
    [self edo_emitWithEventName:@"touch" arguments:@[self]];
}

@end
