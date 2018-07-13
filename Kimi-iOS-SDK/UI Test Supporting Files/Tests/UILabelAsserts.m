//
//  UILabelAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UILabelAsserts.h"

@implementation UILabelAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Plain text"]) {
        UILabel *label = mainObject.subviews[0];
        return [label.text isEqualToString:@"Hello, World!"]
        && label.font.pointSize == 28
        && [label.textColor isEqual:[UIColor redColor]]
        && label.textAlignment == NSTextAlignmentCenter
        && label.lineBreakMode == NSLineBreakByTruncatingTail
        && label.numberOfLines == 10;
    }
    if ([caseName isEqualToString:@"Attributed Text"]) {
        UILabel *label = mainObject.subviews[0];
        return [label.attributedText.string isEqualToString:@"Hello!"];
    }
    return YES;
}

@end
