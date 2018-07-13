//
//  UIButtonAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonAsserts.h"

@implementation UIButtonAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Set Title"]) {
        UIButton *button = mainObject.subviews[0];
        return [[button titleForState:UIControlStateNormal] isEqualToString:@"Hello, World!"]
        && [[button titleForState:UIControlStateSelected] isEqualToString:@"Selected."]
        && [[button titleForState:UIControlStateDisabled] isEqualToString:@"Disabled."];
    }
    if ([caseName isEqualToString:@"Set Enabled False"]) {
        UIButton *button = mainObject.subviews[0];
        return !button.enabled;
    }
    if ([caseName isEqualToString:@"Set Selected True"]) {
        UIButton *button = mainObject.subviews[0];
        return button.selected;
    }
    if ([caseName isEqualToString:@"contentVerticalAlignment"]) {
        UIButton *button = mainObject.subviews[0];
        return button.contentVerticalAlignment == UIControlContentVerticalAlignmentTop;
    }
    if ([caseName isEqualToString:@"contentHorizontalAlignment"]) {
        UIButton *button = mainObject.subviews[0];
        return button.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight;
    }
    if ([caseName isEqualToString:@"setTitleColor"]) {
        UIButton *button = mainObject.subviews[0];
        return [button.currentTitleColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"setTitleFont"]) {
        UIButton *button = mainObject.subviews[0];
        return button.titleLabel.font.pointSize == 24;
    }
    if ([caseName isEqualToString:@"setImage"]) {
        UIButton *button = mainObject.subviews[0];
        return button.currentImage.size.width == 45 && button.currentImage.size.height == 54;
    }
    if ([caseName isEqualToString:@"setAttributedTitle"]) {
        UIButton *button = mainObject.subviews[0];
        return [button.currentAttributedTitle.string isEqualToString:@"Hello!"];
    }
    if ([caseName isEqualToString:@"contentEdgeInsets"]) {
        UIButton *button = mainObject.subviews[0];
        return UIEdgeInsetsEqualToEdgeInsets(button.contentEdgeInsets, UIEdgeInsetsMake(12, 12, 0, 0));
    }
    if ([caseName isEqualToString:@"titleEdgeInsets"]) {
        UIButton *button = mainObject.subviews[0];
        return UIEdgeInsetsEqualToEdgeInsets(button.titleEdgeInsets, UIEdgeInsetsMake(12, 12, 0, 0));
    }
    if ([caseName isEqualToString:@"imageEdgeInsets"]) {
        UIButton *button = mainObject.subviews[0];
        return UIEdgeInsetsEqualToEdgeInsets(button.imageEdgeInsets, UIEdgeInsetsMake(12, 12, 0, 0));
    }
    if ([caseName isEqualToString:@"TouchUpInside"]) {
        UIButton *button = mainObject.subviews[0];
        return [button.backgroundColor isEqual:[UIColor yellowColor]];
    }
    return YES;
}

@end
