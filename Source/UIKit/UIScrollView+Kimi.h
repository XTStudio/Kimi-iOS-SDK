//
//  UIScrollView+Kimi.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KIMIFetchMoreControl;

@interface UIScrollView (Kimi) <UIScrollViewDelegate>

@property (nonatomic, strong) KIMIFetchMoreControl *kimi_fetchMoreControl;

@end
