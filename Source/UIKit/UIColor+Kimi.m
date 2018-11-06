//
//  UIColor+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/19.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIColor+Kimi.h"
#import <xt-engine/EDOExporter.h>

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
    EDO_EXPORT_SCRIPT(@";Initializer.black = new Initializer(0,0,0,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.clear = new Initializer(0,0,0,0);");
    EDO_EXPORT_SCRIPT(@";Initializer.gray = new Initializer(0.5,0.5,0.5,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.red = new Initializer(1,0,0,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.yellow = new Initializer(1,1,0,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.green = new Initializer(0,1,0,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.blue = new Initializer(0,0,1,1);");
    EDO_EXPORT_SCRIPT(@";Initializer.white = new Initializer(1,1,1,1);");
}

@end
