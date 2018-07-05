//
//  UITextField+Kimi.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Kimi)<UITextFieldDelegate>

@property (nonatomic, readwrite) UITextAutocapitalizationType edo_autocapitalizationType;
@property (nonatomic, readwrite) UITextAutocorrectionType edo_autocorrectionType;
@property (nonatomic, readwrite) UITextSpellCheckingType edo_spellCheckingType;
@property (nonatomic, readwrite) UIKeyboardType edo_keyboardType;
@property (nonatomic, readwrite) UIReturnKeyType edo_returnKeyType;

@end
