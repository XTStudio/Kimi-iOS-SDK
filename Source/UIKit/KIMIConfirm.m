//
//  KIMIConfirm.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIConfirm.h"
#import <Endo/EDOExporter.h>

@interface KIMIConfirm()

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *confirmTitle;
@property (nonatomic, copy) NSString *cancelTitle;

@end

@implementation KIMIConfirm

+ (void)load {
    EDO_EXPORT_CLASS(@"UIConfirm", nil);
    EDO_EXPORT_PROPERTY(@"confirmTitle");
    EDO_EXPORT_PROPERTY(@"cancelTitle");
    EDO_EXPORT_METHOD_ALIAS(show:canncelled:, @"show");
    EDO_EXPORT_INITIALIZER({
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            return [[KIMIConfirm alloc] initWithMessage:arguments[0]];
        }
        return [[KIMIConfirm alloc] initWithMessage:@""];
    });
}

- (instancetype)initWithMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        _message = message;
        _confirmTitle = @"Yes";
        _cancelTitle = @"No";
    }
    return self;
}

- (void)show:(void (^)(NSArray *))completed canncelled:(void (^)(NSArray *))canncelled {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:self.message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:self.confirmTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (completed != nil) {
            completed(nil);
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:self.cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (canncelled != nil) {
            canncelled(nil);
        }
    }]];
    [[self visibleViewController] presentViewController:alertController animated:YES completion:nil];
}

- (UIViewController *)visibleViewController {
    UIViewController *current = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    while (current.presentedViewController != nil) {
        current = current.presentedViewController;
    }
    return current;
}

@end
