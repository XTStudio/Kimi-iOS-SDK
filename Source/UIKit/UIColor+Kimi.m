//
//  UIColor+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/19.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIColor+Kimi.h"
#import "EDOExporter.h"

@implementation UIColor (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIColor", nil);
    EDO_EXPORT_INITIALIZER({
        if (arguments.count == 4) {
            return [UIColor colorWithRed:[arguments[0] floatValue]
                                   green:[arguments[1] floatValue]
                                    blue:[arguments[2] floatValue]
                                   alpha:[arguments[3] floatValue]];
        }
        return [UIColor clearColor];
    });
    EDO_EXPORT_STATIC_METHOD(edo_hexColor:);
    EDO_EXPORT_SCRIPT(@";Initializer.black = new Initializer(0,0,0,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.clear = new Initializer(0,0,0,0);");
    EDO_EXPORT_SCRIPT(@";Initializer.gray = new Initializer(0.5,0.5,0.5,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.red = new Initializer(1,0,0,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.yellow = new Initializer(1,1,0,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.green = new Initializer(0,1,0,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.blue = new Initializer(0,0,1,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.white = new Initializer(1,1,1,1);");
}

+ (UIColor *)edo_hexColor:(NSString *)value {
    NSString *trimmedValue = [value stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([trimmedValue length] == 6) {
        unsigned int r = 0;
        unsigned int g = 0;
        unsigned int b = 0;
        [[NSScanner scannerWithString:[trimmedValue substringWithRange:NSMakeRange(0, 2)]] scanHexInt:&r];
        [[NSScanner scannerWithString:[trimmedValue substringWithRange:NSMakeRange(2, 2)]] scanHexInt:&g];
        [[NSScanner scannerWithString:[trimmedValue substringWithRange:NSMakeRange(4, 2)]] scanHexInt:&b];
        return [UIColor colorWithRed:r / 255.0
                               green:g / 255.0
                                blue:b / 255.0
                               alpha:1.0];
    }
    else if ([trimmedValue length] == 8) {
        unsigned int r = 0;
        unsigned int g = 0;
        unsigned int b = 0;
        unsigned int a = 0;
        [[NSScanner scannerWithString:[trimmedValue substringWithRange:NSMakeRange(0, 2)]] scanHexInt:&a];
        [[NSScanner scannerWithString:[trimmedValue substringWithRange:NSMakeRange(2, 2)]] scanHexInt:&r];
        [[NSScanner scannerWithString:[trimmedValue substringWithRange:NSMakeRange(4, 2)]] scanHexInt:&g];
        [[NSScanner scannerWithString:[trimmedValue substringWithRange:NSMakeRange(6, 2)]] scanHexInt:&b];
        return [UIColor colorWithRed:r / 255.0
                               green:g / 255.0
                                blue:b / 255.0
                               alpha:a / 255.0];
    }
    return [UIColor clearColor];
}

@end
