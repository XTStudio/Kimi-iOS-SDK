//
//  KIMITimer.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMITimer.h"
#import <xt-engine/EDOExporter.h>

typedef void(^KIMITimerFireBlock)(NSArray *);

@interface KIMITimer()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) KIMITimerFireBlock fireBlock;

@end

@implementation KIMITimer

+ (void)load {
    EDO_EXPORT_CLASS(@"Timer", nil);
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        NSTimeInterval secondsInInterval = 0 < arguments.count && [arguments[0] isKindOfClass:[NSNumber class]] ? [arguments[0] floatValue] : 0.0;
        KIMITimerFireBlock fireBlock = 1 < arguments.count && arguments[1] != nil ? arguments[1] : nil;
        BOOL repeats = 2 < arguments.count && [arguments[2] isKindOfClass:[NSNumber class]] ? [arguments[2] boolValue] : NO;
        KIMITimer *timer = [[KIMITimer alloc] init];
        timer.timer = [NSTimer scheduledTimerWithTimeInterval:secondsInInterval target:timer selector:@selector(handleFire) userInfo:nil repeats:repeats];
        timer.fireBlock = fireBlock;
        return timer;
    }];
    EDO_EXPORT_METHOD(edo_fire);
    EDO_EXPORT_METHOD(edo_invalidate);
}

- (void)handleFire {
    if (self.fireBlock != nil) {
        self.fireBlock(nil);
    }
}

- (void)edo_fire {
    [self.timer fire];
}

- (void)edo_invalidate {
    [self.timer invalidate];
}

@end
