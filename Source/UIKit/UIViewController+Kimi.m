//
//  UIViewController+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIViewController+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation KIMIDefaultViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationItem.hidesBackButton) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.keyboardWillShowObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
                                                                                      object:nil
                                                                                       queue:[NSOperationQueue mainQueue]
                                                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                                                      [self edo_emitWithEventName:@"keyboardWillShow"
                                                                                                        arguments:@[
                                                                                                                    note.userInfo[UIKeyboardFrameEndUserInfoKey] ?: [NSValue valueWithCGRect:CGRectZero],
                                                                                                                    note.userInfo[UIKeyboardAnimationDurationUserInfoKey] ?: @(0),
                                                                                                                    ]];
                                                                                  }];
    self.keyboardWillHideObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
                                                                                      object:nil
                                                                                       queue:[NSOperationQueue mainQueue]
                                                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                                                      [self edo_emitWithEventName:@"keyboardWillHide"
                                                                                                        arguments:@[
                                                                                                                    note.userInfo[UIKeyboardAnimationDurationUserInfoKey] ?: @(0),
                                                                                                                    ]];
                                                                                  }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardWillShowObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.keyboardWillHideObserver];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    NSNumber *value = [self edo_valueWithEventName:@"statusBarStyle" arguments:@[]];
    return value.integerValue;
}

@end

@implementation UIViewController (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIViewController", nil);
    EDO_EXPORT_PROPERTY(@"title");
    EDO_EXPORT_PROPERTY(@"view");
    EDO_EXPORT_READONLY_PROPERTY(@"edo_safeAreaInsets");
    EDO_BIND_METHOD(viewDidLoad);
    EDO_BIND_METHOD(viewWillAppear:);
    EDO_BIND_METHOD(viewDidAppear:);
    EDO_BIND_METHOD(viewWillDisappear:);
    EDO_BIND_METHOD(viewDidDisappear:);
    EDO_BIND_METHOD(viewWillLayoutSubviews);
    EDO_BIND_METHOD(viewDidLayoutSubviews);
    EDO_EXPORT_READONLY_PROPERTY(@"parentViewController");
    EDO_EXPORT_READONLY_PROPERTY(@"presentedViewController");
    EDO_EXPORT_READONLY_PROPERTY(@"presentingViewController");
    EDO_EXPORT_METHOD_ALIAS(edo_presentViewController:animated:completion:, @"presentViewController");
    EDO_EXPORT_METHOD_ALIAS(edo_dismissViewControllerAnimated:completion:, @"dismissViewController");
    EDO_EXPORT_READONLY_PROPERTY(@"childViewControllers");
    EDO_EXPORT_METHOD(addChildViewController:);
    EDO_EXPORT_METHOD(removeFromParentViewController);
    EDO_BIND_METHOD(willMoveToParentViewController:);
    EDO_BIND_METHOD(didMoveToParentViewController:);
    EDO_EXPORT_READONLY_PROPERTY(@"navigationController");
    EDO_EXPORT_READONLY_PROPERTY(@"navigationItem");
    EDO_EXPORT_READONLY_PROPERTY(@"tabBarController");
    EDO_EXPORT_READONLY_PROPERTY(@"tabBarItem");
    EDO_EXPORT_METHOD(setNeedsStatusBarAppearanceUpdate);
    [[EDOExporter sharedExporter] exportEnum:@"UIStatusBarStyle"
                                      values:@{
                                               @"default": @(UIStatusBarStyleDefault),
                                               @"lightContent": @(UIStatusBarStyleLightContent),
                                               }];
    EDO_EXPORT_INITIALIZER({
        return [[KIMIDefaultViewController alloc] initWithNibName:nil bundle:nil];
    });
    [self aspect_hookSelector:@selector(viewWillLayoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        [aspectInfo.instance edo_emitWithEventName:@"viewWillLayoutSubviews" arguments:@[aspectInfo.instance]];
    } error:NULL];
}

- (UIEdgeInsets)edo_safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        return self.view.safeAreaInsets;
    } else {
        return UIEdgeInsetsMake(self.topLayoutGuide.length, 0.0, self.bottomLayoutGuide.length, 0.0);
    }
}

- (void)edo_presentViewController:(UIViewController *)viewControllerToPresent animated:(NSNumber *)animated completion:(void (^)(NSArray *))completion {
    [self presentViewController:viewControllerToPresent
                       animated:[animated isKindOfClass:[NSNumber class]] ? [animated boolValue] : YES
                     completion:^{
                         if (completion) {
                             completion(nil);
                         }
                     }];
}

- (void)edo_dismissViewControllerAnimated:(NSNumber *)animated completion:(void (^)(NSArray *))completion {
    [self dismissViewControllerAnimated:[animated isKindOfClass:[NSNumber class]] ? [animated boolValue] : YES
                             completion:^{
                                 if (completion) {
                                     completion(nil);
                                 }
                             }];
}

@end
