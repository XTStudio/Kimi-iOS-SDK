//
//  KIMIDebugger.h
//  Kimi-iOS-SDK
//
//  Created by 崔 明辉 on 2018/8/31.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface KIMIDebugger : NSObject

- (nonnull instancetype)initWithRemoteAddress:(nullable NSString *)remoteAddress;
- (void)connect:(nonnull void (^)(JSContext *))callback fallback:(nonnull void (^)(void))fallback;

@end
