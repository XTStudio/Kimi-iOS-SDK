//
//  UISwitchAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UISwitchAsserts.h"

@implementation UISwitchAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"color"]) {
        UISwitch *view = mainObject.subviews[0];
        return view.isOn && [view.onTintColor isEqual:[UIColor blueColor]] && [view.thumbTintColor isEqual:[UIColor greenColor]];
    }
    if ([caseName isEqualToString:@"Change Value - Tap"]) {
        UISwitch *view = mainObject.subviews[0];
        return !view.isOn && [mainObject.accessibilityIdentifier containsString:@"valueChanged|"];
    }
    if ([caseName isEqualToString:@"setOn"]) {
        UISwitch *view = mainObject.subviews[0];
        return view.isOn;
    }
    return YES;
}

@end
