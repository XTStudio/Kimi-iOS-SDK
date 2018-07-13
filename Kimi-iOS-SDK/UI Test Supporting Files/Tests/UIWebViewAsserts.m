//
//  UIWebViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIWebViewAsserts.h"
#import <WebKit/WebKit.h>

@implementation UIWebViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"loadRequest Fail - Wait"]) {
        return [mainObject.accessibilityIdentifier containsString:@"didFail|"];
    }
    if ([caseName isEqualToString:@"loadRequest Finish - Wait"]) {
        return [mainObject.accessibilityIdentifier containsString:@"didStart|"]
        && [mainObject.accessibilityIdentifier containsString:@"newRequest|"]
        && [mainObject.accessibilityIdentifier containsString:@"didFinish|"];
    }
    if ([caseName isEqualToString:@"loadHTML - Wait"]) {
        WKWebView *webView = mainObject.subviews[0];
        return [webView.title isEqualToString:@"Pony's Page"];
    }
    if ([caseName isEqualToString:@"evaluateScript - Wait"]) {
        return [mainObject.accessibilityIdentifier containsString:@"evaluateScript|"];
    }
    return YES;
}

@end
