//
//  UICollectionViewFlowLayout+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/28.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UICollectionViewFlowLayout+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UICollectionViewFlowLayout (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UICollectionViewFlowLayout", @"UICollectionViewLayout");
}

@end
