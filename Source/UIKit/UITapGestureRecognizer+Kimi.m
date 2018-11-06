//
//  UITapGestureRecognizer+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/20.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITapGestureRecognizer+Kimi.h"
#import "EDOExporter.h"
#import "UIGestureRecognizer+Kimi.h"

@implementation UITapGestureRecognizer (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITapGestureRecognizer", @"UIGestureRecognizer");
    EDO_EXPORT_PROPERTY(@"numberOfTapsRequired");
    EDO_EXPORT_PROPERTY(@"numberOfTouchesRequired");
}

- (void)edo_handleTouch:(UIGestureRecognizer *)sender {
    [self edo_emitWithEventName:@"touch" arguments:@[sender]];
}

@end
