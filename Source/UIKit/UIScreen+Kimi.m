//
//  UIScreen+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/7/3.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIScreen+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIScreen (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIScreen", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"bounds");
    EDO_EXPORT_READONLY_PROPERTY(@"scale");
    EDO_EXPORT_INITIALIZER({
        return [UIScreen mainScreen];
    });
    EDO_EXPORT_SCRIPT(@"Initializer.mainScreen = new Initializer();");
}

@end
