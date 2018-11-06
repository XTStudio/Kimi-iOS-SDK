//
//  UIPanGestureRecognizer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/20.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIPanGestureRecognizer+Kimi.h"
#import <xt-engine/EDOExporter.h>
#import "UIGestureRecognizer+Kimi.h"

@implementation UIPanGestureRecognizer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIPanGestureRecognizer", @"UIGestureRecognizer");
    EDO_EXPORT_PROPERTY(@"minimumNumberOfTouches");
    EDO_EXPORT_PROPERTY(@"maximumNumberOfTouches");
    EDO_EXPORT_METHOD(translationInView:);
    EDO_EXPORT_METHOD_ALIAS(setTranslation:inView:, @"setTranslation");
    EDO_EXPORT_METHOD(velocityInView:);
}

- (void)edo_handleTouch:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self edo_emitWithEventName:@"began" arguments:@[sender]];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self edo_emitWithEventName:@"changed" arguments:@[sender]];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        [self edo_emitWithEventName:@"ended" arguments:@[sender]];
    }
    else if (sender.state == UIGestureRecognizerStateCancelled) {
        [self edo_emitWithEventName:@"cancelled" arguments:@[sender]];
    }
}

@end
