//
//  CALayer+Kimi.h
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Kimi)

@property (nonatomic, strong) UIColor *edo_backgroundColor;
@property (nonatomic, strong) UIColor *edo_borderColor;
@property (nonatomic, strong) UIColor *edo_shadowColor;

- (void)kimi_dealloc;

@end
