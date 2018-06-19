//
//  KIMIDispatchQueue.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/19.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIDispatchQueue.h"
#import <Endo/EDOExporter.h>

@implementation KIMIDispatchQueue

+ (void)load {
    EDO_EXPORT_CLASS(@"DispatchQueue", nil)
    EDO_EXPORT_SCRIPT(@"Initializer.main = new Initializer('main');");
    EDO_EXPORT_METHOD(async:)
    EDO_EXPORT_METHOD_ALIAS(asyncAfter:asyncBlock:, @"asyncAfter")
}

- (void)async:(void (^)(NSArray *arguments))asyncBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        asyncBlock(@[]);
    });
}

- (void)asyncAfter:(double)delayInSeconds asyncBlock:(void (^)(NSArray *arguments))asyncBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        asyncBlock(@[]);
    });
}

@end
