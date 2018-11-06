//
//  UILongPressGestureRecognizer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/20.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UILongPressGestureRecognizer+Kimi.h"
#import <xt-engine/EDOExporter.h>
#import "UIGestureRecognizer+Kimi.h"

@implementation UILongPressGestureRecognizer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UILongPressGestureRecognizer", @"UIGestureRecognizer");
    EDO_EXPORT_PROPERTY(@"numberOfTapsRequired");
    EDO_EXPORT_PROPERTY(@"numberOfTouchesRequired");
    EDO_EXPORT_PROPERTY(@"minimumPressDuration");
    EDO_EXPORT_PROPERTY(@"allowableMovement");
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
