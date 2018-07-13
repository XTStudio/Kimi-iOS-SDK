//
//  WKWebView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "WKWebView+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation WKWebView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIWebView", @"UIView");
    EDO_EXPORT_READONLY_PROPERTY(@"title");
    EDO_EXPORT_READONLY_PROPERTY(@"URL");
    EDO_EXPORT_READONLY_PROPERTY(@"loading");
    EDO_EXPORT_METHOD(loadRequest:);
    EDO_EXPORT_METHOD_ALIAS(loadHTMLString:baseURL:, @"loadHTMLString");
    EDO_EXPORT_METHOD(goBack);
    EDO_EXPORT_METHOD(goForward);
    EDO_EXPORT_METHOD(reload);
    EDO_EXPORT_METHOD(stopLoading);
    EDO_EXPORT_METHOD_ALIAS(edo_evaluateJavaScript:completionHandler:, @"evaluateJavaScript");
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        WKWebView *instance = [[WKWebView alloc] init];
        instance.navigationDelegate = instance;
        return instance;
    }];
}

- (void)edo_evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(NSArray *))completionHandler {
    [self evaluateJavaScript:javaScriptString completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(@[result ?: [NSNull null], error ?: [NSNull null]]);
        }
    }];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSNumber *allow = [self edo_valueWithEventName:@"newRequest" arguments:@[navigationAction.request]];
    if (allow != nil) {
        decisionHandler(([allow boolValue] ? WKNavigationActionPolicyAllow : WKNavigationActionPolicyCancel));
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self edo_emitWithEventName:@"didStart" arguments:nil];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self edo_emitWithEventName:@"didFinish" arguments:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self edo_emitWithEventName:@"didFail" arguments:@[error ?: [NSNull null]]];
}

@end
