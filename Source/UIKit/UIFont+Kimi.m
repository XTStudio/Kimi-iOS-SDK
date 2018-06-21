//
//  UIFont+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIFont+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIFont (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIFont", nil);
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        CGFloat pointSize = 0 < arguments.count && [arguments[0] isKindOfClass:[NSNumber class]] ? [arguments[0] floatValue] : 0.0;
        NSString *fontWeight = 1 < arguments.count && [arguments[1] isKindOfClass:[NSString class]] ? arguments[1] : nil;
        NSString *fontName = 2 < arguments.count && [arguments[2] isKindOfClass:[NSString class]] ? arguments[2] : nil;
        if (fontName != nil) {
            return [UIFont fontWithName:fontName size:pointSize];
        }
        else {
            if ([fontWeight isEqualToString:@"thin"]) {
                return [UIFont systemFontOfSize:pointSize weight:UIFontWeightThin];
            }
            else if ([fontWeight isEqualToString:@"light"]) {
                return [UIFont systemFontOfSize:pointSize weight:UIFontWeightLight];
            }
            else if ([fontWeight isEqualToString:@"regular"]) {
                return [UIFont systemFontOfSize:pointSize weight:UIFontWeightRegular];
            }
            else if ([fontWeight isEqualToString:@"medium"]) {
                return [UIFont systemFontOfSize:pointSize weight:UIFontWeightMedium];
            }
            else if ([fontWeight isEqualToString:@"bold"]) {
                return [UIFont systemFontOfSize:pointSize weight:UIFontWeightBold];
            }
            else if ([fontWeight isEqualToString:@"heavy"]) {
                return [UIFont systemFontOfSize:pointSize weight:UIFontWeightHeavy];
            }
            else if ([fontWeight isEqualToString:@"black"]) {
                return [UIFont systemFontOfSize:pointSize weight:UIFontWeightBlack];
            }
            else if ([fontWeight isEqualToString:@"italic"]) {
                return [UIFont italicSystemFontOfSize:pointSize];
            }
            else {
                return [UIFont systemFontOfSize:pointSize];
            }
        }
    }];
}

@end
