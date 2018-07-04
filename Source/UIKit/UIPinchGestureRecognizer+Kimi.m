//
//  UIPinchGestureRecognizer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/20.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIPinchGestureRecognizer+Kimi.h"
#import <Endo/EDOExporter.h>
#import "UIGestureRecognizer+Kimi.h"

@implementation UIPinchGestureRecognizer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIPinchGestureRecognizer", @"UIGestureRecognizer");
    EDO_EXPORT_PROPERTY(@"scale");
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
