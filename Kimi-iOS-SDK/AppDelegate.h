//
//  AppDelegate.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class EDOExporter;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (JSContext *)unitTestContext;
+ (void)setUnitTestObject:(NSObject *)anObject forKey:(NSString *)forKey;

@end

