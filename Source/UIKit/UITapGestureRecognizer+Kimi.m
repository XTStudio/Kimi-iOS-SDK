//
//  UITapGestureRecognizer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/20.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITapGestureRecognizer+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UITapGestureRecognizer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITapGestureRecognizer", @"UIGestureRecognizer");
    EDO_EXPORT_PROPERTY(@"numberOfTapsRequired");
    EDO_EXPORT_PROPERTY(@"numberOfTouchesRequired");
}

@end
