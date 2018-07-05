//
//  KIMIUIAnimator.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/19.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIMIUIAnimator : NSObject

- (void)linear:(double)duration animations:(nonnull void (^)(NSArray *))animation completion:(nullable void (^)(NSArray *))completion;
- (void)spring:(double)tension friction:(double)friction animations:(void (^)(NSArray *))animation completion:(void (^)(NSArray *))completion;

@end
