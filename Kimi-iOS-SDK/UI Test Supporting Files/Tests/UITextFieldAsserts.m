//
//  UITextFieldAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITextFieldAsserts.h"

@implementation UITextFieldAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Plain Properties"]) {
        UITextField *textField = mainObject.subviews[0];
        return [textField.text isEqualToString:@"Pony"]
        && textField.font.pointSize == 28
        && [textField.textColor isEqual:[UIColor redColor]]
        && textField.textAlignment == NSTextAlignmentCenter
        && [textField.placeholder isEqualToString:@"Username"]
        && textField.clearsOnBeginEditing == YES
        && textField.clearButtonMode == UITextFieldViewModeAlways
        && textField.leftView != nil
        && textField.leftViewMode == UITextFieldViewModeAlways
        && textField.autocapitalizationType == UITextAutocapitalizationTypeWords
        && textField.autocorrectionType == UITextAutocorrectionTypeNo
        && textField.spellCheckingType == UITextSpellCheckingTypeYes
        && textField.keyboardType == UIKeyboardTypeASCIICapable
        && textField.returnKeyType == UIReturnKeyGo;
    }
    if ([caseName isEqualToString:@"Focus"]) {
        UITextField *textField = mainObject.subviews[0];
        return [textField isFirstResponder]
        && [mainObject.accessibilityIdentifier containsString:@"shouldBeginEditing|"]
        && [mainObject.accessibilityIdentifier containsString:@"didBeginEditing|"];
    }
    if ([caseName isEqualToString:@"Input Sentense - Input"]) {
        UITextField *textField = mainObject.subviews[0];
        return [textField.text isEqualToString:@"Hello, Pony!"]
        && [mainObject.accessibilityIdentifier containsString:@"shouldChange|"];
    }
    if ([caseName isEqualToString:@"Clear - Clear"]) {
        UITextField *textField = mainObject.subviews[0];
        return [textField.text length] == 0
        && [mainObject.accessibilityIdentifier containsString:@"shouldClear|"];
    }
    if ([caseName isEqualToString:@"Return - Return"]) {
        return [mainObject.accessibilityIdentifier containsString:@"shouldReturn|"];
    }
    if ([caseName isEqualToString:@"Blur"]) {
        UITextField *textField = mainObject.subviews[0];
        return ![textField isFirstResponder]
        && [mainObject.accessibilityIdentifier containsString:@"shouldEndEditing|"]
        && [mainObject.accessibilityIdentifier containsString:@"didEndEditing|"];
    }
    return YES;
}

@end
