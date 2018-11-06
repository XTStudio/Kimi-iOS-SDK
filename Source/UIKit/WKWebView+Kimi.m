//
//  WKWebView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "WKWebView+Kimi.h"
#import <xt_engine/EDOExporter.h>

@interface KIMIWKScriptMessageHandler: NSObject<WKScriptMessageHandler>

@end

@implementation KIMIWKScriptMessageHandler

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if (![message.body isKindOfClass:[NSDictionary class]]) {
        return;
    }
    id body = message.body[@"body"];
    NSNumber *callbackIdx = message.body[@"callbackIdx"];
    id returnValue = [message.webView edo_valueWithEventName:@"message"
                                                  arguments:@[
                                                              body ?: [NSNull null]
                                                              ]];
    if ([callbackIdx isKindOfClass:[NSNumber class]] && [returnValue isKindOfClass:[NSString class]]) {
        [message.webView evaluateJavaScript:[NSString stringWithFormat:@"KIMI.onMessage(%@, [`%@`])", callbackIdx, returnValue]
                          completionHandler:nil];
    }
}

@end

@implementation KIMIWebView

+ (instancetype)new {
    return [[self alloc] init];
}

- (instancetype)init
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [[WKUserContentController alloc] init];
    WKUserScript *messageHandlerScript = [[WKUserScript alloc]
                                          initWithSource:@"var KIMICallbacks=[];var KIMI={postMessage:function(body,callback){var callbackIdx=typeof callback===\"function\"?KIMICallbacks.length:undefined;if(callbackIdx!==undefined){KIMICallbacks.push(callback)}window.webkit.messageHandlers.KIMI.postMessage({body:body,callbackIdx:callbackIdx})},onMessage:function(callbackIdx,args){try{KIMICallbacks[callbackIdx].apply(undefined,args)}catch(error){}}};"
                                          injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                          forMainFrameOnly:NO];
    [configuration.userContentController addUserScript:messageHandlerScript];
    [configuration.userContentController addScriptMessageHandler:[KIMIWKScriptMessageHandler new]
                                                            name:@"KIMI"];
    self = [super initWithFrame:CGRectZero configuration:configuration];
    if (self) {
        self.navigationDelegate = self;
    }
    return self;
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
}

@end
