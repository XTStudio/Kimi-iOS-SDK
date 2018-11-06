//
//  UIRefreshControl+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/8/14.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIRefreshControl+Kimi.h"
#import "EDOExporter.h"

@implementation UIRefreshControl (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIRefreshControl", @"UIView");
    EDO_EXPORT_PROPERTY(@"enabled");
    EDO_EXPORT_READONLY_PROPERTY(@"refreshing");
    EDO_EXPORT_PROPERTY(@"tintColor");
    EDO_EXPORT_METHOD(edo_beginRefreshing);
    EDO_EXPORT_METHOD(endRefreshing);
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:refreshControl action:@selector(edo_handleValueChanged) forControlEvents:UIControlEventValueChanged];
        return refreshControl;
    }];
}

- (void)edo_beginRefreshing {
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        [self beginRefreshing];
        [scrollView setContentOffset:CGPointMake(0, -54.0)
                            animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self edo_emitWithEventName:@"refresh" arguments:@[self]];
        });
    }
}

- (void)edo_handleValueChanged {
    [self edo_emitWithEventName:@"refresh" arguments:@[self]];
}

@end
