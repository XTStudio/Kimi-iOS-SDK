//
//  UIDialogsAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIDialogsAsserts.h"

@implementation UIDialogsAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"Alert - Tap"]) {
        return [mainObject.accessibilityIdentifier containsString:@"Alert|"];
    }
    if ([caseName isEqualToString:@"UIPrompt - Confirm"]) {
        return [mainObject.accessibilityIdentifier containsString:@"UIPrompt,Confirm|"];
    }
    if ([caseName isEqualToString:@"UIPrompt - Cancel"]) {
        return [mainObject.accessibilityIdentifier containsString:@"UIPrompt,Cancel|"];
    }
    if ([caseName isEqualToString:@"UIConfirm - Confirm"]) {
        return [mainObject.accessibilityIdentifier containsString:@"UIConfirm,Confirm|"];
    }
    if ([caseName isEqualToString:@"UIConfirm - Cancel"]) {
        return [mainObject.accessibilityIdentifier containsString:@"UIConfirm,Cancel|"];
    }
    return YES;
}

@end
