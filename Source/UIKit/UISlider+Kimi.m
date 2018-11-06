//
//  UISlider+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UISlider+Kimi.h"
#import "EDOExporter.h"

@implementation UISlider (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UISlider", @"UIView");
    EDO_EXPORT_PROPERTY(@"value");
    EDO_EXPORT_PROPERTY(@"minimumValue");
    EDO_EXPORT_PROPERTY(@"maximumValue");
    EDO_EXPORT_PROPERTY(@"minimumTrackTintColor");
    EDO_EXPORT_PROPERTY(@"maximumTrackTintColor");
    EDO_EXPORT_PROPERTY(@"thumbTintColor");
    EDO_EXPORT_METHOD_ALIAS(setValue:animated:, @"setValue");
    EDO_EXPORT_INITIALIZER({
        UISlider *instance = [[UISlider alloc] init];
        [instance addTarget:instance action:@selector(kimi_handleValueChanged) forControlEvents:UIControlEventValueChanged];
        return instance;
    });
}

- (void)kimi_handleValueChanged {
    [self edo_emitWithEventName:@"valueChanged" arguments:@[self]];
}

@end
