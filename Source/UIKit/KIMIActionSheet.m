//
//  KIMIActionSheet.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/9/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIActionSheet.h"
#import <xt_engine/EDOExporter.h>

@interface KIMIActionSheet()

@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) NSString *message;

@end

@implementation KIMIActionSheet

+ (void)load {
    EDO_EXPORT_CLASS(@"UIActionSheet", nil);
    EDO_EXPORT_PROPERTY(@"message");
    EDO_EXPORT_METHOD_ALIAS(addRegularAction:actionBlock:, @"addRegularAction")
    EDO_EXPORT_METHOD_ALIAS(addDangerAction:actionBlock:, @"addDangerAction")
    EDO_EXPORT_METHOD_ALIAS(addCancelAction:actionBlock:, @"addCancelAction")
    EDO_EXPORT_METHOD(show)
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _alertController = [UIAlertController alertControllerWithTitle:nil
                                                               message:nil
                                                        preferredStyle:UIAlertControllerStyleActionSheet];
    }
    return self;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    [self.alertController setMessage:message];
}

- (void)addRegularAction:(NSString *)title actionBlock:(void (^)(NSArray *))actionBlock {
    [self.alertController addAction:[UIAlertAction actionWithTitle:title
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (actionBlock != nil) {
                                                                   actionBlock(nil);
                                                               }
                                                           }]];
}

- (void)addDangerAction:(NSString *)title actionBlock:(void (^)(NSArray *))actionBlock {
    [self.alertController addAction:[UIAlertAction actionWithTitle:title
                                                             style:UIAlertActionStyleDestructive
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (actionBlock != nil) {
                                                                   actionBlock(nil);
                                                               }
                                                           }]];
}

- (void)addCancelAction:(NSString *)title actionBlock:(void (^)(NSArray *))actionBlock {
    [self.alertController addAction:[UIAlertAction actionWithTitle:title
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (actionBlock != nil) {
                                                                   actionBlock(nil);
                                                               }
                                                           }]];
}

- (void)show {
    [[self visibleViewController] presentViewController:self.alertController animated:YES completion:nil];
}

- (UIViewController *)visibleViewController {
    UIViewController *current = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    while (current.presentedViewController != nil) {
        current = current.presentedViewController;
    }
    return current;
}

@end
