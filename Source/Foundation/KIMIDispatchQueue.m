//
//  KIMIDispatchQueue.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/19.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIDispatchQueue.h"
#import <Endo/EDOExporter.h>
#import <Endo/EDOObjectTransfer.h>

@interface KIMIDispatchQueue()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) JSContext *operationContext;
@property (nonatomic, copy) NSString *queueIdentifier;

@end

@implementation KIMIDispatchQueue

+ (void)load {
    EDO_EXPORT_CLASS(@"DispatchQueue", nil);
    EDO_EXPORT_SCRIPT(@";Initializer.main = new Initializer('main');");
    EDO_EXPORT_SCRIPT(@";Initializer.global = new Initializer('global');");
    EDO_EXPORT_SCRIPT(@";Initializer.prototype.isolate = function(){ var args = []; for(var i=1;i<arguments.length;i++){ args.push(arguments[i]); } this._isolate(arguments[0].toString(), args); };");
    EDO_EXPORT_METHOD(async:);
    EDO_EXPORT_METHOD_ALIAS(asyncAfter:asyncBlock:, @"asyncAfter");
    EDO_EXPORT_METHOD_ALIAS(_isolate:arguments:, @"_isolate");
    static KIMIDispatchQueue *mainQueueDispatcher;
    static KIMIDispatchQueue *globalQueueDispatcher;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainQueueDispatcher = [[KIMIDispatchQueue alloc] initWithQueueIdentifier:@"main"];
        globalQueueDispatcher = [[KIMIDispatchQueue alloc] initWithQueueIdentifier:@"global"];
    });
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            if ([arguments[0] isEqualToString:@"main"]) {
                return mainQueueDispatcher;
            }
            if ([arguments[0] isEqualToString:@"global"]) {
                return globalQueueDispatcher;
            }
            return [[KIMIDispatchQueue alloc] initWithQueueIdentifier:arguments[0]];
        }
        return mainQueueDispatcher;
    }];
}

- (instancetype)initWithQueueIdentifier:(NSString *)queueIdentifier
{
    self = [super init];
    if (self) {
        _queueIdentifier = queueIdentifier;
        if ([queueIdentifier isEqualToString:@"main"]) {
            _operationQueue = [NSOperationQueue mainQueue];
        }
        else if ([queueIdentifier isEqualToString:@"global"]) {
            _operationQueue = [[NSOperationQueue alloc] init];
            _operationQueue.maxConcurrentOperationCount = 1;
        }
        else {
            _operationQueue = [[NSOperationQueue alloc] init];
            _operationQueue.maxConcurrentOperationCount = 1;
        }
    }
    return self;
}

- (void)async:(void (^)(NSArray *arguments))asyncBlock {
    [self.operationQueue addOperationWithBlock:^{
        asyncBlock(@[]);
    }];
}

- (void)asyncAfter:(double)delayInSeconds asyncBlock:(void (^)(NSArray *arguments))asyncBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self async:asyncBlock];
    });
}

- (void)_isolate:(NSString *)script arguments:(NSArray *)arguments {
    if (self.operationContext == nil) {
        self.operationContext = [[JSContext alloc] init];
        [[EDOExporter sharedExporter] exportWithContext:self.operationContext];
        Class uulogClazz = NSClassFromString(@"UULog");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if (uulogClazz != NULL && [uulogClazz respondsToSelector:@selector(attachToContext:)]) {
            [uulogClazz performSelector:@selector(attachToContext:) withObject:self.operationContext];
        }
#pragma clang diagnostic pop
#pragma clang diagnostic pop
    }
    [self.operationQueue addOperationWithBlock:^{
        [self.operationContext evaluateScript:[NSString stringWithFormat:@"var __isolate_exec_func = %@", script]];
        JSValue *func = [self.operationContext objectForKeyedSubscript:@"__isolate_exec_func"];
        [func callWithArguments:[EDOObjectTransfer convertToJSArgumentsWithNSArguments:arguments context:self.operationContext]];
    }];
}

@end
