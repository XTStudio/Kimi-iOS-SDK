//
//  UIStackViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIStackViewAsserts.h"

@implementation UIStackViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"distribution = fill - Wait"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return redView.frame.size.width == 200 && yellowView.frame.size.width == 50 && blueView.frame.size.width == 50;
    }
    if ([caseName isEqualToString:@"distribution = fillEqually - Wait"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return redView.frame.size.width == yellowView.frame.size.width && yellowView.frame.size.width == blueView.frame.size.width;
    }
    if ([caseName isEqualToString:@"distribution = fillProportionally - Wait"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return redView.frame.size.width == 80 && redView.frame.size.width == yellowView.frame.size.width && yellowView.frame.size.width == blueView.frame.size.width;
    }
    if ([caseName isEqualToString:@"distribution = equalSpacing - Wait"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return redView.frame.origin.x == 0 && yellowView.frame.origin.x == 85 && blueView.frame.origin.x == 200;
    }
    if ([caseName isEqualToString:@"distribution = equalCentering - Wait"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return yellowView.center.x - redView.center.x == blueView.center.x - yellowView.center.x;
    }
    if ([caseName isEqualToString:@"alignment = fill"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return redView.frame.size.height == 88.0
        && yellowView.frame.size.height == 88.0
        && blueView.frame.size.height == 88.0;
    }
    if ([caseName isEqualToString:@"alignment = leading"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return redView.frame.size.height == 44 && redView.frame.origin.y == 0.0
        && yellowView.frame.size.height == 55 && yellowView.frame.origin.y == 0.0
        && blueView.frame.size.height == 66 && blueView.frame.origin.y == 0.0;
    }
    if ([caseName isEqualToString:@"alignment = center"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return redView.frame.size.height == 44 && redView.center.y == 44
        && yellowView.frame.size.height == 55 && yellowView.center.y == 44
        && blueView.frame.size.height == 66 && blueView.center.y == 44;
    }
    if ([caseName isEqualToString:@"alignment = trailing"]) {
        UIView *redView = [mainObject viewWithTag:100];
        UIView *yellowView = [mainObject viewWithTag:101];
        UIView *blueView = [mainObject viewWithTag:102];
        return redView.frame.size.height == 44 && CGRectGetMaxY(redView.frame) == 88
        && yellowView.frame.size.height == 55 && CGRectGetMaxY(yellowView.frame) == 88
        && blueView.frame.size.height == 66 && CGRectGetMaxY(blueView.frame) == 88;
    }
    return YES;
}

@end
