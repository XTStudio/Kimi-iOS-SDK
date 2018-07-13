//
//  UIImageViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIImageViewAsserts.h"

@implementation UIImageViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Set Image"]) {
        UIImageView *imageView = mainObject.subviews[0];
        return imageView.image.size.width == 45 && imageView.image.size.height == 54;
    }
    return YES;
}

@end
