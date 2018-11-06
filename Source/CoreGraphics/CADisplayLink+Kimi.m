//
//  CADisplayLink+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "CADisplayLink+Kimi.h"
#import <xt_engine/EDOExporter.h>

typedef void(^KIMICADisplayLinkVsyncBlock)(NSArray *);

@interface KIMICADisplayLinkWrapper: NSObject

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, copy) KIMICADisplayLinkVsyncBlock vsyncBlock;
@property (nonatomic, readonly) float timestamp;

@end

@implementation KIMICADisplayLinkWrapper

+ (void)load {
    EDO_EXPORT_CLASS(@"CADisplayLink", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"timestamp");
    EDO_EXPORT_METHOD(active);
    EDO_EXPORT_METHOD(invalidate);
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        KIMICADisplayLinkWrapper *instance = [[KIMICADisplayLinkWrapper alloc] init];
        instance.displayLink = [CADisplayLink displayLinkWithTarget:instance selector:@selector(handleDisplay)];
        instance.vsyncBlock = 0 < arguments.count ? arguments[0] : nil;
        return instance;
    }];
}

- (void)handleDisplay {
    if (self.vsyncBlock != nil) {
        self.vsyncBlock(nil);
    }
}

- (float)timestamp {
    return (float)self.displayLink.timestamp;
}

- (void)active {
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)invalidate {
    [self.displayLink invalidate];
}

@end

@implementation CADisplayLink (Kimi)

@end
