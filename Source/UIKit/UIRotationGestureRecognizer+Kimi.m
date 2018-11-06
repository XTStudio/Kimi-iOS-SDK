//
//  UIRotationGestureRecognizer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/20.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIRotationGestureRecognizer+Kimi.h"
#import <xt-engine/EDOExporter.h>
#import "UIGestureRecognizer+Kimi.h"

@implementation UIRotationGestureRecognizer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIRotationGestureRecognizer", @"UIGestureRecognizer");
    EDO_EXPORT_PROPERTY(@"rotation");
    EDO_EXPORT_READONLY_PROPERTY(@"velocity");
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
