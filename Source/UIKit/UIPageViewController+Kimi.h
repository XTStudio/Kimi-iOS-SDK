//
//  UIPageViewController+Kimi.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPageViewController (Kimi)<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, assign) BOOL edo_loops;
@property (nonatomic, copy) NSArray<UIViewController *> *edo_pageItems;
@property (nonatomic, strong) UIViewController *edo_currentPage;

@end
