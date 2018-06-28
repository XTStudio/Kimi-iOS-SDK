//
//  UICollectionViewCell+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/28.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UICollectionViewCell+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UICollectionViewCell (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UICollectionViewCell", @"UIView");
}

@end
