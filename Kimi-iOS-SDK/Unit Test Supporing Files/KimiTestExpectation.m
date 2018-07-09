//
//  KimiTestExpectation.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KimiTestExpectation.h"
#import <Endo/EDOExporter.h>
#import <Endo/EDOObjectTransfer.h>

@implementation KimiTestExpectation

+ (void)load {
    [[EDOExporter sharedExporter] exportClass:[self class] name:@"KimiTestExpectation" superName:nil];
    [[EDOExporter sharedExporter] exportMethodToJavaScript:[self class] selector:@selector(fulfill)];
}

- (void)fulfill {
    self.fulfilled = YES;
}

@end
