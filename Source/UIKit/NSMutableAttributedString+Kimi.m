//
//  NSMutableAttributedString+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/2.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSMutableAttributedString+Kimi.h"
#import <xt-engine/EDOExporter.h>

@implementation NSMutableAttributedString (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIMutableAttributedString", @"UIAttributedString");
    EDO_EXPORT_METHOD_ALIAS(replaceCharactersInRange:withString:, @"replaceCharacters");
    EDO_EXPORT_METHOD_ALIAS(setAttributes:range:, @"setAttributes");
    EDO_EXPORT_METHOD_ALIAS(addAttribute:value:range:, @"addAttribute");
    EDO_EXPORT_METHOD_ALIAS(addAttributes:range:, @"addAttributes");
    EDO_EXPORT_METHOD_ALIAS(removeAttribute:range:, @"removeAttribute");
    EDO_EXPORT_METHOD_ALIAS(replaceCharactersInRange:withAttributedString:, @"replaceCharactersWithAttributedString");
    EDO_EXPORT_METHOD_ALIAS(insertAttributedString:atIndex:, @"insertAttributedString");
    EDO_EXPORT_METHOD_ALIAS(appendAttributedString:, @"appendAttributedString");
    EDO_EXPORT_METHOD_ALIAS(deleteCharactersInRange:, @"deleteCharacters");
    EDO_EXPORT_METHOD(edo_immutable);
    EDO_EXPORT_INITIALIZER({
        NSString *str = 0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]] ? arguments[0] : @"";
        NSDictionary *attributes = 1 < arguments.count && [arguments[1] isKindOfClass:[NSDictionary class]] ? arguments[1] : @{};
        return [[NSMutableAttributedString alloc] initWithString:str attributes:attributes];
    });
}

- (NSAttributedString *)edo_immutable {
    return [self copy];
}

- (void)setEdo_objectRef:(NSString *)edo_objectRef {
    [super setEdo_objectRef:edo_objectRef];
}

@end
