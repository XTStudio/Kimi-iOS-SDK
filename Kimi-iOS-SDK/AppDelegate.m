//
//  AppDelegate.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "AppDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Endo/EDOExporter.h>
#import <Endo/EDOObjectTransfer.h>
#import <UULog/UULog.h>

@interface AppDelegate ()

@property (nonatomic, strong) JSContext *context;

@end

@implementation AppDelegate

+ (JSContext *)unitTestContext {
    static JSContext *context;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        context = [[JSContext alloc] init];
        [[EDOExporter sharedExporter] exportWithContext:context];
        [UULog attachToContext:context];
    });
    return context;
}

+ (void)setUnitTestObject:(NSObject *)anObject forKey:(NSString *)forKey {
    [[self unitTestContext] setObject:[EDOObjectTransfer convertToJSValueWithObject:anObject context:[self unitTestContext]]
                    forKeyedSubscript:forKey];
}

+ (id)fetchUnitTestObjectForKey:(NSString *)forKey {
    JSValue *value = [[self unitTestContext] objectForKeyedSubscript:forKey];
    return [EDOObjectTransfer convertToNSValueWithJSValue:value owner:value];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.context = [[JSContext alloc] init];
    [[EDOExporter sharedExporter] exportWithContext:self.context];
    [UULog attachToContext:self.context];
    [self.context evaluateScript:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"]
                                                       usedEncoding:nil
                                                              error:NULL]];
    UIViewController *mainViewController = [[EDOExporter sharedExporter] nsValueWithJSValue:[self.context objectForKeyedSubscript:@"main"]];
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
