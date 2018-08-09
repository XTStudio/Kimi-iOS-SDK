//
//  NSURLSessionTask+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSURLSessionTask+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation NSURLSessionTask (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"URLSessionTask", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"state");
    EDO_EXPORT_READONLY_PROPERTY(@"countOfBytesExpectedToReceive");
    EDO_EXPORT_READONLY_PROPERTY(@"countOfBytesReceived");
    EDO_EXPORT_READONLY_PROPERTY(@"countOfBytesExpectedToSend");
    EDO_EXPORT_READONLY_PROPERTY(@"countOfBytesSent");
    EDO_EXPORT_METHOD(cancel);
    EDO_EXPORT_METHOD(resume);
    [[EDOExporter sharedExporter] exportEnum:@"URLSessionTaskState"
                                      values:@{
                                               @"running": @(NSURLSessionTaskStateRunning),
                                               @"suspended": @(NSURLSessionTaskStateSuspended),
                                               @"cancelling": @(NSURLSessionTaskStateCanceling),
                                               @"completed": @(NSURLSessionTaskStateCompleted),
                                               }];
}

@end
