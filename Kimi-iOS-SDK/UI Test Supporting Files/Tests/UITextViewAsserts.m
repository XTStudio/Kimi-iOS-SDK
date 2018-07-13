//
//  UITextViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITextViewAsserts.h"

@implementation UITextViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Plain Properties"]) {
        UITextView *textView = mainObject.subviews[0];
        return [textView.text isEqualToString:@"Pony"]
        && textView.font.pointSize == 28
        && [textView.textColor isEqual:[UIColor redColor]]
        && textView.textAlignment == NSTextAlignmentCenter
        && textView.editable
        && textView.selectable
        && textView.autocapitalizationType == UITextAutocapitalizationTypeWords
        && textView.autocorrectionType == UITextAutocorrectionTypeNo
        && textView.spellCheckingType == UITextSpellCheckingTypeYes
        && textView.keyboardType == UIKeyboardTypeASCIICapable
        && textView.returnKeyType == UIReturnKeyGo;
    }
    if ([caseName isEqualToString:@"Focus"]) {
        UITextView *textView = mainObject.subviews[0];
        return [textView isFirstResponder]
        && [mainObject.accessibilityIdentifier containsString:@"shouldBeginEditing|"]
        && [mainObject.accessibilityIdentifier containsString:@"didBeginEditing|"];
    }
    if ([caseName isEqualToString:@"Input Sentense - Input"]) {
        UITextView *textView = mainObject.subviews[0];
        return [textView.text isEqualToString:@"Hello, Pony!"]
        && [mainObject.accessibilityIdentifier containsString:@"shouldChange|"];
    }
    if ([caseName isEqualToString:@"Blur"]) {
        UITextView *textView = mainObject.subviews[0];
        return ![textView isFirstResponder]
        && [mainObject.accessibilityIdentifier containsString:@"shouldEndEditing|"]
        && [mainObject.accessibilityIdentifier containsString:@"didEndEditing|"];
    }
    return YES;
}

@end
