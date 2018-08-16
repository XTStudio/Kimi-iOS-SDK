//
//  KIMIAlert.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIAlert.h"
#import <Endo/EDOExporter.h>

@interface KIMIAlert()

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *buttonText;

@end

@implementation KIMIAlert

+ (void)load {
    EDO_EXPORT_CLASS(@"UIAlert", nil);
    EDO_EXPORT_METHOD(show:);
    EDO_EXPORT_INITIALIZER({
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            return [[KIMIAlert alloc] initWithMessage:arguments[0] buttonText:(1 < arguments.count && [arguments[1] isKindOfClass:[NSString class]] ? arguments[1] : @"OK")];
        }
        return [[KIMIAlert alloc] initWithMessage:@"" buttonText:@"OK"];
    });
}

- (instancetype)initWithMessage:(NSString *)message buttonText:(NSString *)buttonText
{
    self = [super init];
    if (self) {
        _message = message;
        _buttonText = buttonText;
    }
    return self;
}

- (void)show:(void (^)(NSArray *))callback {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:self.message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:self.buttonText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (callback) {
            callback(nil);
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
