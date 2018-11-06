//
//  NSObject+KimiTestExpectation.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSObject+KimiTestExpectation.h"
#import <xt-engine/EDOExporter.h>
#import <xt-engine/EDOObjectTransfer.h>

@implementation NSObject (KimiTestExpectation)

+ (void)load {
    Class clazz = NSClassFromString(@"KimiTestExpectation");
    if (clazz != NULL) {
        [[EDOExporter sharedExporter] exportClass:clazz name:@"KimiTestExpectation" superName:nil];
        [[EDOExporter sharedExporter] exportMethodToJavaScript:clazz selector:@selector(fulfill)];
    }
}

@end
