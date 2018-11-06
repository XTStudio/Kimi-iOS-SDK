//
//  UIGestureRecognizer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/20.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIGestureRecognizer+Kimi.h"
#import <xt-engine/EDOExporter.h>
#import <xt-engine/NSObject+EDOObjectRef.h>

@implementation UIGestureRecognizer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIGestureRecognizer", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"state");
    EDO_EXPORT_PROPERTY(@"enabled");
    EDO_EXPORT_READONLY_PROPERTY(@"view");
    EDO_EXPORT_PROPERTY(@"requiresExclusiveTouchType");
    EDO_EXPORT_METHOD(requireGestureRecognizerToFail:);
    EDO_EXPORT_METHOD(locationInView:);
    [[EDOExporter sharedExporter] exportEnum:@"UIGestureRecognizerState"
                                      values:@{
                                               @"possible": @(UIGestureRecognizerStatePossible),
                                               @"began": @(UIGestureRecognizerStateBegan),
                                               @"changed": @(UIGestureRecognizerStateChanged),
                                               @"ended": @(UIGestureRecognizerStateEnded),
                                               @"cancelled": @(UIGestureRecognizerStateCancelled),
                                               @"failed": @(UIGestureRecognizerStateFailed),
                                               }];
}

- (void)edo_handleTouch:(UIGestureRecognizer *)sender {}

- (void)setEdo_objectRef:(NSString *)edo_objectRef {
    [super setEdo_objectRef:edo_objectRef];
    [self addTarget:self action:@selector(edo_handleTouch:)];
}

@end
