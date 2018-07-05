//
//  KIMIPrompt.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIPrompt.h"
#import <Endo/EDOExporter.h>

@interface KIMIPrompt()

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *confirmTitle;
@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, copy) NSString *defaultValue;

@end

@implementation KIMIPrompt

+ (void)load {
    EDO_EXPORT_CLASS(@"UIPrompt", nil);
    EDO_EXPORT_PROPERTY(@"confirmTitle");
    EDO_EXPORT_PROPERTY(@"cancelTitle");
    EDO_EXPORT_PROPERTY(@"placeholder");
    EDO_EXPORT_PROPERTY(@"defaultValue");
    EDO_EXPORT_METHOD_ALIAS(show:canncelled:, @"show");
    EDO_EXPORT_INITIALIZER({
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            return [[KIMIPrompt alloc] initWithMessage:arguments[0]];
        }
        return [[KIMIPrompt alloc] initWithMessage:@""];
    });
}

- (instancetype)initWithMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        _message = message;
        _confirmTitle = @"Done";
        _cancelTitle = @"Cancel";
    }
    return self;
}

- (void)show:(void (^)(NSArray *))completed canncelled:(void (^)(NSArray *))canncelled {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:self.message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = self.placeHolder;
        textField.text = self.defaultValue;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:self.confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completed(@[[alertController.textFields[0] text] ?: @""]);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:self.cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (canncelled != nil) {
            canncelled(nil);
        }
    }]];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
}

@end
