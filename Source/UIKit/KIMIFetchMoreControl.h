//
//  UIFetchMoreControl.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/8/14.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIMIFetchMoreControl : UIView

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, readonly) BOOL fetching;

- (void)beginFetching;
- (void)endFetching;

// Private
@property (nonatomic, strong) UIView *fetchingView;
@property (nonatomic, weak) UIScrollView *scrollView;
- (void)scrollViewDidScroll;

@end
