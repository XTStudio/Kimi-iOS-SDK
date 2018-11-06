//
//  UISwitch+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UISwitch+Kimi.h"
#import <xt-engine/EDOExporter.h>

@implementation UISwitch (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UISwitch", @"UIView");
    EDO_EXPORT_PROPERTY(@"onTintColor");
    EDO_EXPORT_PROPERTY(@"thumbTintColor");
    EDO_EXPORT_PROPERTY(@"edo_isOn");
    EDO_EXPORT_METHOD_ALIAS(setOn:animated:, @"setOn");
    EDO_EXPORT_INITIALIZER({
        UISwitch *instance = [[UISwitch alloc] init];
        [instance addTarget:instance action:@selector(kimi_handleValueChanged) forControlEvents:UIControlEventValueChanged];
        return instance;
    })
}

- (BOOL)edo_isOn {
    return self.isOn;
}

- (void)setEdo_isOn:(BOOL)edo_isOn {
    [self setOn:edo_isOn animated:NO];
}

- (void)kimi_handleValueChanged {
    [self edo_emitWithEventName:@"valueChanged" arguments:@[self]];
}

@end
