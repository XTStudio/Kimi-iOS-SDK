//
//  UIRefreshControl+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/8/14.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIRefreshControl+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIRefreshControl (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIRefreshControl", @"UIView");
    EDO_EXPORT_PROPERTY(@"enabled");
    EDO_EXPORT_READONLY_PROPERTY(@"refreshing");
    EDO_EXPORT_PROPERTY(@"tintColor");
    EDO_EXPORT_METHOD(beginRefreshing);
    EDO_EXPORT_METHOD(endRefreshing);
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:refreshControl action:@selector(edo_handleValueChanged) forControlEvents:UIControlEventValueChanged];
        return refreshControl;
    }];
}

- (void)edo_handleValueChanged {
    [self edo_emitWithEventName:@"refresh" arguments:@[self]];
}

@end
