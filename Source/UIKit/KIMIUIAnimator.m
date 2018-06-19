//
//  KIMIUIAnimator.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/19.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIUIAnimator.h"
#import <Endo/EDOExporter.h>
#import <pop/POP.h>
#import <Aspects/Aspects.h>

static KIMIUIAnimator *activeAnimator;

typedef POPPropertyAnimation *(^KIMIAnimationCreater)(void);

@interface KIMIUIAnimator()

@property (nonatomic, copy) KIMIAnimationCreater animationCreater;

@end

@implementation UIView (KIMIUIAnimator)

+ (void)load {
    [UIView aspect_hookSelector:@selector(setFrame:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        if (activeAnimator != nil && activeAnimator.animationCreater != nil) {
            POPPropertyAnimation *animation = activeAnimator.animationCreater();
            [animation setProperty:[POPAnimatableProperty propertyWithName:kPOPViewFrame]];
            [animation setFromValue:[NSValue valueWithCGRect:[(UIView *)aspectInfo.instance frame]]];
            [animation setToValue:aspectInfo.arguments[0]];
            [aspectInfo.instance pop_addAnimation:animation forKey:@"frame"];
        }
    } error:NULL];
    [UIView aspect_hookSelector:@selector(setCenter:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        if (activeAnimator != nil && activeAnimator.animationCreater != nil) {
            POPPropertyAnimation *animation = activeAnimator.animationCreater();
            [animation setProperty:[POPAnimatableProperty propertyWithName:kPOPViewCenter]];
            [animation setFromValue:[NSValue valueWithCGPoint:[(UIView *)aspectInfo.instance center]]];
            [animation setToValue:aspectInfo.arguments[0]];
            [aspectInfo.instance pop_addAnimation:animation forKey:@"center"];
        }
    } error:NULL];
    [UIView aspect_hookSelector:@selector(setTransform:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//        if (activeAnimator != nil && activeAnimator.animationCreater != nil) {
//            POPPropertyAnimation *animation = activeAnimator.animationCreater();
//            [animation setProperty:[POPAnimatableProperty propertyWithName:kPOPViewCenter]];
//            [animation setFromValue:[NSValue valueWithCGPoint:[(UIView *)aspectInfo.instance center]]];
//            [animation setToValue:aspectInfo.arguments[0]];
//            [aspectInfo.instance pop_addAnimation:animation forKey:@"center"];
//        }
    } error:NULL];
    [UIView aspect_hookSelector:@selector(setBackgroundColor:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        if (activeAnimator != nil && activeAnimator.animationCreater != nil) {
            POPPropertyAnimation *animation = activeAnimator.animationCreater();
            [animation setProperty:[POPAnimatableProperty propertyWithName:kPOPViewBackgroundColor]];
            [animation setFromValue:[(UIView *)aspectInfo.instance backgroundColor]];
            [animation setToValue:aspectInfo.arguments[0]];
            [aspectInfo.instance pop_addAnimation:animation forKey:@"backgroundColor"];
        }
    } error:NULL];
    [UIView aspect_hookSelector:@selector(setAlpha:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        if (activeAnimator != nil && activeAnimator.animationCreater != nil) {
            POPPropertyAnimation *animation = activeAnimator.animationCreater();
            [animation setProperty:[POPAnimatableProperty propertyWithName:kPOPViewAlpha]];
            [animation setFromValue:@([(UIView *)aspectInfo.instance alpha])];
            [animation setToValue:aspectInfo.arguments[0]];
            [aspectInfo.instance pop_addAnimation:animation forKey:@"alpha"];
        }
    } error:NULL];
}

@end

@implementation KIMIUIAnimator

+ (void)load {
    static KIMIUIAnimator *sharedAnimator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAnimator = [KIMIUIAnimator new];
    });
    EDO_EXPORT_CLASS(@"UIAnimator", nil)
    EDO_EXPORT_SCRIPT(@"Initializer.shared = new Initializer();")
    EDO_EXPORT_INITIALIZER({
        return sharedAnimator;
    })
    EDO_EXPORT_METHOD_ALIAS(linear:animations:completion:, @"linear")
    EDO_EXPORT_METHOD_ALIAS(spring:friction:animations:completion:, @"spring")

}

- (void)linear:(double)duration animations:(void (^)(NSArray *))animation completion:(void (^)(NSArray *))completion {
    activeAnimator = self;
    self.animationCreater = ^POPPropertyAnimation *{
        POPBasicAnimation *animation = [POPBasicAnimation linearAnimation];
        [animation setDuration:duration];
        return animation;
    };
    animation(@[]);
    activeAnimator = nil;
}

- (void)spring:(double)tension friction:(double)friction animations:(void (^)(NSArray *))animation completion:(void (^)(NSArray *))completion {
    activeAnimator = self;
    self.animationCreater = ^POPPropertyAnimation *{
        POPSpringAnimation *animation = [POPSpringAnimation animation];
        animation.dynamicsTension = tension;
        animation.dynamicsFriction = friction;
        return animation;
    };
    animation(@[]);
    activeAnimator = nil;
}

@end
