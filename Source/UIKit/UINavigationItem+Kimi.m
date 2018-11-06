//
//  UINavigationItem+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UINavigationItem+Kimi.h"
#import "EDOExporter.h"

@implementation UINavigationItem (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UINavigationItem", nil);
    EDO_EXPORT_PROPERTY(@"title");
    EDO_EXPORT_PROPERTY(@"hidesBackButton");
    EDO_EXPORT_PROPERTY(@"leftBarButtonItem");
    EDO_EXPORT_PROPERTY(@"leftBarButtonItems");
    EDO_EXPORT_PROPERTY(@"rightBarButtonItem");
    EDO_EXPORT_PROPERTY(@"rightBarButtonItems");
}

@end
