//
//  NSMutableParagraphStyle+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/12.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSMutableParagraphStyle+Kimi.h"
#import "EDOExporter.h"

@implementation NSMutableParagraphStyle (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIParagraphStyle", nil);
    EDO_EXPORT_PROPERTY(@"lineSpacing");
    EDO_EXPORT_PROPERTY(@"alignment");
    EDO_EXPORT_PROPERTY(@"lineBreakMode");
    EDO_EXPORT_PROPERTY(@"minimumLineHeight");
    EDO_EXPORT_PROPERTY(@"maximumLineHeight");
    EDO_EXPORT_PROPERTY(@"lineHeightMultiple");
}

@end
