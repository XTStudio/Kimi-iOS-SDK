//
//  UITextView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITextView+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation UITextView (Kimi)

+ (void)load{
    // UITextView
    EDO_EXPORT_CLASS(@"UITextView", @"UIView");
    EDO_EXPORT_PROPERTY(@"text");
    EDO_EXPORT_PROPERTY(@"textColor");
    EDO_EXPORT_PROPERTY(@"font");
    EDO_EXPORT_PROPERTY(@"textAlignment");
    EDO_EXPORT_PROPERTY(@"editable");
    EDO_EXPORT_PROPERTY(@"selectable");
    EDO_EXPORT_READONLY_PROPERTY(@"editing");
    EDO_EXPORT_METHOD(edo_focus);
    EDO_EXPORT_METHOD(edo_blur);
    // UITextInput
    EDO_EXPORT_PROPERTY(@"edo_autocapitalizationType");
    EDO_EXPORT_PROPERTY(@"edo_autocorrectionType");
    EDO_EXPORT_PROPERTY(@"edo_spellCheckingType");
    EDO_EXPORT_PROPERTY(@"edo_keyboardType");
    EDO_EXPORT_PROPERTY(@"edo_returnKeyType");
    EDO_EXPORT_PROPERTY(@"secureTextEntry");
    // Classes
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        UITextView *instance = [[UITextView alloc] init];
        instance.delegate = instance;
        return instance;
    }];
}

- (UITextAutocapitalizationType)edo_autocapitalizationType {
    return self.autocapitalizationType;
}

- (void)setEdo_autocapitalizationType:(UITextAutocapitalizationType)edo_autocapitalizationType {
    self.autocapitalizationType = edo_autocapitalizationType;
}

- (UITextAutocorrectionType)edo_autocorrectionType {
    return self.autocorrectionType;
}

- (void)setEdo_autocorrectionType:(UITextAutocorrectionType)edo_autocorrectionType {
    self.autocorrectionType = edo_autocorrectionType;
}

- (UITextSpellCheckingType)edo_spellCheckingType {
    return self.spellCheckingType;
}

- (void)setEdo_spellCheckingType:(UITextSpellCheckingType)edo_spellCheckingType {
    self.spellCheckingType = edo_spellCheckingType;
}

- (UIKeyboardType)edo_keyboardType {
    return self.keyboardType;
}

- (void)setEdo_keyboardType:(UIKeyboardType)edo_keyboardType {
    self.keyboardType = edo_keyboardType;
}

- (UIReturnKeyType)edo_returnKeyType {
    return self.returnKeyType;
}

- (void)setEdo_returnKeyType:(UIReturnKeyType)edo_returnKeyType {
    self.returnKeyType = edo_returnKeyType;
}

- (void)edo_focus {
    [self becomeFirstResponder];
}

- (void)edo_blur {
    [self resignFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    NSNumber *value = [self edo_valueWithEventName:@"shouldBeginEditing" arguments:@[textView]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self edo_emitWithEventName:@"didBeginEditing" arguments:@[textView]];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    NSNumber *value = [self edo_valueWithEventName:@"shouldEndEditing" arguments:@[textView]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self edo_emitWithEventName:@"didEndEditing" arguments:@[textView]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSNumber *value = [self edo_valueWithEventName:@"shouldChange" arguments:@[self, [NSValue valueWithRange:range], text]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return YES;
}

@end
