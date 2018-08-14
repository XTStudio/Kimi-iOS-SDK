//
//  KIMINavigationBarViewController.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/8/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMINavigationBarViewController.h"
#import <Endo/EDOExporter.h>

@interface KIMINavigationControllerState: NSObject

@property (nonatomic, assign) BOOL barHidden;
@property (nonatomic, strong) id interactivePopGestureRecognizerDelegate;

@end

@implementation KIMINavigationControllerState

@end

@interface KIMINavigationBarViewController ()

@property (nonatomic, assign) CGFloat navigationBarContentHeight;
@property (nonatomic, assign) BOOL navigationBarInFront;
@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, readonly) UIView *edo_view;
@property (nonatomic, strong) KIMINavigationControllerState *navigationControllerState;

@end

@implementation KIMINavigationBarViewController

+ (void)load {
    EDO_EXPORT_CLASS(@"UINavigationBarViewController", @"UIViewController");
    EDO_EXPORT_PROPERTY(@"navigationBarContentHeight");
    EDO_EXPORT_PROPERTY(@"navigationBarInFront");
    EDO_EXPORT_READONLY_PROPERTY(@"navigationBar");
    EDO_EXPORT_READONLY_PROPERTY(@"edo_view");
}

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _navigationBarContentHeight = 44.0;
        _navigationBarInFront = YES;
        _navigationBar = [[UIView alloc] init];
        _contentView = [[UIView alloc] init];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.navigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController != nil) {
        if (self.navigationControllerState == nil) {
            self.navigationControllerState = [[KIMINavigationControllerState alloc] init];
            self.navigationControllerState.barHidden = self.navigationController.navigationBarHidden;
            self.navigationControllerState.interactivePopGestureRecognizerDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        }
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController != nil) {
        if (self.navigationControllerState != nil) {
            [self.navigationController setNavigationBarHidden:self.navigationControllerState.barHidden animated:YES];
            self.navigationController.interactivePopGestureRecognizer.delegate = self.navigationControllerState.interactivePopGestureRecognizerDelegate;
        }
    }
}

- (void)viewWillLayoutSubviews {
    if (@available(iOS 11.0, *)) {
        self.navigationBar.frame = CGRectMake(0.0,
                                              0.0,
                                              CGRectGetWidth(self.view.bounds),
                                              self.view.safeAreaInsets.top + self.navigationBarContentHeight);
    } else {
        self.navigationBar.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.topLayoutGuide.length + self.navigationBarContentHeight);
    }
    self.contentView.frame = CGRectMake(0.0,
                                        CGRectGetMaxY(self.navigationBar.frame),
                                        CGRectGetWidth(self.view.bounds),
                                        CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.navigationBar.bounds));
    [super viewWillLayoutSubviews];
}

- (void)setNavigationBarContentHeight:(CGFloat)navigationBarContentHeight {
    _navigationBarContentHeight = navigationBarContentHeight;
    [self.view setNeedsLayout];
}

- (void)setNavigationBarInFront:(BOOL)navigationBarInFront {
    _navigationBarInFront = navigationBarInFront;
    if (navigationBarInFront) {
        [self.view bringSubviewToFront:self.navigationBar];
    }
    else {
        [self.view bringSubviewToFront:self.contentView];
    }
}

- (UIView *)edo_view {
    return self.contentView;
}

@end
