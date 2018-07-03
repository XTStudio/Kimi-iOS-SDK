//
//  UIColor+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/19.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIColor+Kimi.h"
#import <Endo/EDOExporter.h>

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
    EDO_EXPORT_SCRIPT(@"Initializer.blackColor = new Initializer(0,0,0,1);");
    EDO_EXPORT_SCRIPT(@"Initializer.clearColor = new Initializer(0,0,0,0);");
    EDO_EXPORT_SCRIPT(@"Initializer.grayColor = new Initializer(0.5,0.5,0.5,1);");
    EDO_EXPORT_SCRIPT(@"Initializer.redColor = new Initializer(1,0,0,1);");
    EDO_EXPORT_SCRIPT(@"Initializer.yellowColor = new Initializer(1,1,0,1);");
    EDO_EXPORT_SCRIPT(@"Initializer.greenColor = new Initializer(0,1,0,1);");
    EDO_EXPORT_SCRIPT(@"Initializer.blueColor = new Initializer(0,0,1,1);");
    EDO_EXPORT_SCRIPT(@"Initializer.whiteColor = new Initializer(1,1,1,1);");
}

@end
