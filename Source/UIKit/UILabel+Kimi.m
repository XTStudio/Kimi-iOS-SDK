//
//  UILabel+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UILabel+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UILabel (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UILabel", @"UIView");
    EDO_EXPORT_PROPERTY(@"text");
    EDO_EXPORT_PROPERTY(@"attributedText");
    EDO_EXPORT_PROPERTY(@"font");
    EDO_EXPORT_PROPERTY(@"textColor");
    EDO_EXPORT_PROPERTY(@"textAlignment");
    EDO_EXPORT_PROPERTY(@"lineBreakMode");
    EDO_EXPORT_PROPERTY(@"numberOfLines");
    [[EDOExporter sharedExporter] exportEnum:@"UITextAlignment"
                                      values:@{
                                               @"left": @(NSTextAlignmentLeft),
                                               @"center": @(NSTextAlignmentCenter),
                                               @"right": @(NSTextAlignmentRight),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UILineBreakMode"
                                      values:@{
                                               @"wordWrapping": @(NSLineBreakByWordWrapping),
                                               @"charWrapping": @(NSLineBreakByCharWrapping),
                                               @"clipping": @(NSLineBreakByClipping),
                                               @"truncatingHead": @(NSLineBreakByTruncatingHead),
                                               @"truncatingTail": @(NSLineBreakByTruncatingTail),
                                               @"truncatingMiddle": @(NSLineBreakByTruncatingMiddle),
                                               }];
}

@end
