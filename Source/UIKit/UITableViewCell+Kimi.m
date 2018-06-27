//
//  UITableViewCell+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITableViewCell+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation UITableViewCell (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITableViewCell", @"UIView");
}

@end
