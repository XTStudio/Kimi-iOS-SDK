//
//  UISliderAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UISliderAsserts.h"

@implementation UISliderAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Plain Props"]) {
        UISlider *view = mainObject.subviews[0];
        return view.value == 50
        && [view.minimumTrackTintColor isEqual:[UIColor greenColor]]
        && [view.maximumTrackTintColor isEqual:[UIColor redColor]]
        && [view.thumbTintColor isEqual:[UIColor blueColor]]
        && view.minimumValue == 0
        && view.maximumValue == 100;
    }
    if ([caseName isEqualToString:@"Change Value - Slide"]) {
        UISlider *view = mainObject.subviews[0];
        return view.value == 100 && [mainObject.accessibilityIdentifier containsString:@"valueChanged|"];
    }
    if ([caseName isEqualToString:@"setValue"]) {
        UISlider *view = mainObject.subviews[0];
        return view.value == 0;
    }
    return YES;
}

@end
