//
//  NSAttributedString+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSAttributedString+Kimi.h"
#import <xt-engine/EDOExporter.h>

@implementation NSAttributedString (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIAttributedString", nil);
    EDO_EXPORT_METHOD(edo_measure:);
    EDO_EXPORT_METHOD(edo_mutable);
    EDO_EXPORT_INITIALIZER({
        NSString *str = 0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]] ? arguments[0] : @"";
        NSDictionary *attributes = 1 < arguments.count && [arguments[1] isKindOfClass:[NSDictionary class]] ? arguments[1] : @{};
        return [[NSAttributedString alloc] initWithString:str attributes:attributes];
    });
    [[EDOExporter sharedExporter] exportEnum:@"UIAttributedStringKey"
                                      values:@{
                                               @"foregroundColor": NSForegroundColorAttributeName,
                                               @"font": NSFontAttributeName,
                                               @"backgroundColor": NSBackgroundColorAttributeName,
                                               @"kern": NSKernAttributeName,
                                               @"strikethroughStyle": NSStrikethroughStyleAttributeName,
                                               @"underlineStyle": NSUnderlineStyleAttributeName,
                                               @"strokeColor": NSStrokeColorAttributeName,
                                               @"strokeWidth": NSStrokeWidthAttributeName,
                                               @"underlineColor": NSUnderlineColorAttributeName,
                                               @"strikethroughColor": NSStrikethroughColorAttributeName,
                                               @"paragraphStyle": NSParagraphStyleAttributeName,
                                               }];
}

- (CGRect)edo_measure:(CGSize)inSize {
    return [self boundingRectWithSize:inSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
}

- (NSMutableAttributedString *)edo_mutable {
    return [self mutableCopy];
}

@end
