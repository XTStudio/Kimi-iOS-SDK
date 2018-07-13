//
//  UIActivityIndicatorViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIActivityIndicatorViewAsserts.h"

@implementation UIActivityIndicatorViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Start Animating"]) {
        UIActivityIndicatorView *view = mainObject.subviews[0];
        return [view.color isEqual:[UIColor redColor]]
        && view.activityIndicatorViewStyle == UIActivityIndicatorViewStyleWhiteLarge
        && view.isAnimating;
    }
    if ([caseName isEqualToString:@"Stop Animating"]) {
        UIActivityIndicatorView *view = mainObject.subviews[0];
        return !view.isAnimating && view.hidden;
    }
    return YES;
}

@end
