//
//  UITextField+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITextField+Kimi.h"
#import "UIView+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation UITextField (Kimi)

+ (void)load{
    // UITextField
    EDO_EXPORT_CLASS(@"UITextField", @"UIView");
    EDO_EXPORT_PROPERTY(@"text");
    EDO_EXPORT_PROPERTY(@"textColor");
    EDO_EXPORT_PROPERTY(@"font");
    EDO_EXPORT_PROPERTY(@"textAlignment");
    EDO_EXPORT_PROPERTY(@"placeholder");
    EDO_EXPORT_PROPERTY(@"clearsOnBeginEditing");
    EDO_EXPORT_PROPERTY(@"editing");
    EDO_EXPORT_PROPERTY(@"clearButtonMode");
    EDO_EXPORT_PROPERTY(@"leftView");
    EDO_EXPORT_PROPERTY(@"leftViewMode");
    EDO_EXPORT_PROPERTY(@"rightView");
    EDO_EXPORT_PROPERTY(@"rightViewMode");
    EDO_EXPORT_PROPERTY(@"clearsOnInsertion");
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
        UITextField *instance = [[UITextField alloc] init];
        instance.delegate = instance;
        return instance;
    }];
    [[EDOExporter sharedExporter] exportEnum:@"UITextFieldViewMode"
                                      values:@{
                                               @"never": @(UITextFieldViewModeNever),
                                               @"whileEditing": @(UITextFieldViewModeWhileEditing),
                                               @"unlessEditing": @(UITextFieldViewModeUnlessEditing),
                                               @"always": @(UITextFieldViewModeAlways),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UITextAutocapitalizationType"
                                      values:@{
                                               @"none": @(UITextAutocapitalizationTypeNone),
                                               @"words": @(UITextAutocapitalizationTypeWords),
                                               @"sentences": @(UITextAutocapitalizationTypeSentences),
                                               @"allCharacters": @(UITextAutocapitalizationTypeAllCharacters),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UITextAutocorrectionType"
                                      values:@{
                                               @"default": @(UITextAutocorrectionTypeDefault),
                                               @"no": @(UITextAutocorrectionTypeNo),
                                               @"yes": @(UITextAutocorrectionTypeYes),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UITextSpellCheckingType"
                                      values:@{
                                               @"default": @(UITextSpellCheckingTypeDefault),
                                               @"no": @(UITextSpellCheckingTypeNo),
                                               @"yes": @(UITextSpellCheckingTypeYes),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UIKeyboardType"
                                      values:@{
                                               @"default": @(UIKeyboardTypeDefault),
                                               @"ASCIICapable": @(UIKeyboardTypeASCIICapable),
                                               @"numbersAndPunctuation": @(UIKeyboardTypeNumbersAndPunctuation),
                                               @"numberPad": @(UIKeyboardTypeNumberPad),
                                               @"phonePad": @(UIKeyboardTypePhonePad),
                                               @"emailAddress": @(UIKeyboardTypeEmailAddress),
                                               @"decimalPad": @(UIKeyboardTypeDecimalPad),
                                               }];
    [[EDOExporter sharedExporter] exportEnum:@"UIReturnKeyType"
                                      values:@{
                                               @"default": @(UIReturnKeyDefault),
                                               @"go": @(UIReturnKeyGo),
                                               @"next": @(UIReturnKeyNext),
                                               @"send": @(UIReturnKeySend),
                                               @"done": @(UIReturnKeyDone),
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSNumber *value = [self edo_valueWithEventName:@"shouldBeginEditing" arguments:@[textField]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self edo_emitWithEventName:@"didBeginEditing" arguments:@[textField]];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSNumber *value = [self edo_valueWithEventName:@"shouldEndEditing" arguments:@[textField]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self edo_emitWithEventName:@"didEndEditing" arguments:@[textField]];
}

- (BOOL)shouldChangeTextInRange:(UITextRange *)range replacementText:(NSString *)text {
    UITextPosition *beginning = [self beginningOfDocument];
    NSRange nsRange = NSMakeRange([self offsetFromPosition:beginning toPosition:range.start], [self offsetFromPosition:range.start toPosition:range.end]);
    NSNumber *value = [self edo_valueWithEventName:@"shouldChange" arguments:@[self, [NSValue valueWithRange:nsRange], text]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSNumber *value = [self edo_valueWithEventName:@"shouldClear" arguments:@[textField]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSNumber *value = [self edo_valueWithEventName:@"shouldReturn" arguments:@[textField]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return YES;
}

@end
