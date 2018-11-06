//
//  UITabBarItem+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITabBarItem+Kimi.h"
#import "EDOExporter.h"

@implementation UITabBarItem (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITabBarItem", nil);
    EDO_EXPORT_PROPERTY(@"title");
    EDO_EXPORT_PROPERTY(@"image");
    EDO_EXPORT_PROPERTY(@"selectedImage");
    EDO_EXPORT_PROPERTY(@"imageInsets");
}

@end
