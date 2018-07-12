//
//  UIViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/12.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewAsserts.h"

@implementation UIViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Change Frame"]) {
        UIView *sampleView = [mainObject subviews][0];
        return CGRectEqualToRect(sampleView.frame, CGRectMake(([UIScreen mainScreen].bounds.size.width - 128) / 2.0,
                                                              ([UIScreen mainScreen].bounds.size.height - 128) / 2.0 - 64.0,
                                                              128,
                                                              128));
    }
    if ([caseName isEqualToString:@"Change Center"]) {
        UIView *sampleView = [mainObject subviews][0];
        return CGPointEqualToPoint(sampleView.center, CGPointMake([mainObject center].x, 128.0));
    }
    if ([caseName isEqualToString:@"Change Transform"]) {
        UIView *sampleView = [mainObject subviews][0];
        return CGAffineTransformEqualToTransform(sampleView.transform, CGAffineTransformMake(0.5, 0.0, 0.0, 0.5, 0.0, 44.0));
    }
    if ([caseName isEqualToString:@"Set Tag / Get View Via Tag"]) {
        UIView *sampleView = [mainObject subviews][0];
        return sampleView.tag == 3000 && [sampleView.backgroundColor isEqual:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    }
    if ([caseName isEqualToString:@"Get Superview and Set it's BackgroundColor"]) {
        return [[mainObject backgroundColor] isEqual:[UIColor yellowColor]];
    }
    if ([caseName isEqualToString:@"Get Subviews and Set it's BackgroundColor"]) {
        UIView *sampleView = [mainObject subviews][0];
        return [sampleView.backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"Remove From Superview"]) {
        return [mainObject subviews].count == 0;
    }
    if ([caseName isEqualToString:@"insertSubviewAtIndex"]) {
        return [mainObject.subviews[0].backgroundColor isEqual:[UIColor yellowColor]] && [mainObject.subviews[1].backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"exchangeSubview"]) {
        return [mainObject.subviews[1].backgroundColor isEqual:[UIColor yellowColor]] && [mainObject.subviews[0].backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"addSubview"]) {
        return [mainObject.subviews[2].backgroundColor isEqual:[UIColor greenColor]];
    }
    if ([caseName isEqualToString:@"insertSubviewBelowSubview"]) {
        return [mainObject.subviews[0].backgroundColor isEqual:[UIColor blueColor]];
    }
    if ([caseName isEqualToString:@"insertSubviewAboveSubview"]) {
        return [mainObject.subviews[1].backgroundColor isEqual:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    }
    if ([caseName isEqualToString:@"bringSubviewToFront"]) {
        return [mainObject.subviews.lastObject.backgroundColor isEqual:[UIColor blueColor]];
    }
    if ([caseName isEqualToString:@"sendSubviewToBack"]) {
        return [mainObject.subviews.firstObject.backgroundColor isEqual:[UIColor blueColor]];
    }
    if ([caseName isEqualToString:@"isDescendantOfView"]) {
        return [mainObject.backgroundColor isEqual:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    }
    if ([caseName isEqualToString:@"layoutSubviews"]) {
        [mainObject layoutSubviews];
        return CGRectEqualToRect(mainObject.subviews[0].frame, CGRectMake(0, 0, 300, 300));
    }
    if ([caseName isEqualToString:@"Props"]) {
        return mainObject.clipsToBounds && mainObject.alpha == 0.5 && mainObject.hidden && mainObject.contentMode == UIViewContentModeScaleAspectFit && [mainObject.tintColor isEqual:[UIColor blueColor]] && !mainObject.userInteractionEnabled;
    }
    if ([caseName isEqualToString:@"addGestureRecognizer - Tap"]) {
        return [mainObject.backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"Delegates"]) {
        return [mainObject.accessibilityIdentifier isEqualToString:@"main viewdidAddSubview|willRemoveSubview|willMoveToSuperview|didMoveToSuperview"];
    }
    return YES;
}

@end
