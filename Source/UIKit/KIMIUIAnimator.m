//
//  KIMIUIAnimator.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/19.
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
    static POPAnimatableProperty *transformDegreePropertyAnimation;
    static POPAnimatableProperty *transformTranslatePropertyAnimation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transformDegreePropertyAnimation = [POPAnimatableProperty propertyWithName:@"com.xt.kimi.transform.degree" initializer:^(POPMutableAnimatableProperty *prop) {
            [prop setReadBlock:^(id obj, CGFloat *values) {
                [self kimi_unmatrix:[(UIView *)obj transform] completion:^(CGPoint scale, CGFloat degree, CGPoint translate) {
                    values[0] = degree;
                }];
            }];
            [prop setWriteBlock:^(id obj, const CGFloat *values) {
                [self kimi_unmatrix:[(UIView *)obj transform] completion:^(CGPoint scale, CGFloat degree, CGPoint translate) {
                    CGAffineTransform newMatrix = CGAffineTransformIdentity;
                    newMatrix = CGAffineTransformRotate(newMatrix, values[0] * (M_PI / 180.0));
                    newMatrix = CGAffineTransformScale(newMatrix, scale.x, scale.y);
                    newMatrix = CGAffineTransformTranslate(newMatrix, translate.x, translate.y);
                    [(UIView *)obj setTransform:newMatrix];
                }];
            }];
        }];
        transformTranslatePropertyAnimation = [POPAnimatableProperty propertyWithName:@"com.xt.kimi.transform.translate" initializer:^(POPMutableAnimatableProperty *prop) {
            [prop setReadBlock:^(id obj, CGFloat *values) {
                [self kimi_unmatrix:[(UIView *)obj transform] completion:^(CGPoint scale, CGFloat degree, CGPoint translate) {
                    values[0] = translate.x;
                    values[1] = translate.y;
                }];
            }];
            [prop setWriteBlock:^(id obj, const CGFloat *values) {
                [self kimi_unmatrix:[(UIView *)obj transform] completion:^(CGPoint scale, CGFloat degree, CGPoint translate) {
                    CGAffineTransform newMatrix = CGAffineTransformIdentity;
                    newMatrix = CGAffineTransformRotate(newMatrix, degree * (M_PI / 180.0));
                    newMatrix = CGAffineTransformScale(newMatrix, scale.x, scale.y);
                    newMatrix = CGAffineTransformTranslate(newMatrix, values[0], values[1]);
                    [(UIView *)obj setTransform:newMatrix];
                }];
            }];
        }];
    });
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
        if (activeAnimator != nil && activeAnimator.animationCreater != nil) {
            [self kimi_unmatrix:[(UIView *)aspectInfo.instance transform] completion:^(CGPoint fromScale, CGFloat fromDegree, CGPoint fromTranslate) {
                [self kimi_unmatrix:[aspectInfo.arguments[0] CGAffineTransformValue] completion:^(CGPoint toScale, CGFloat toDegree, CGPoint toTranslate) {
                    if (!CGPointEqualToPoint(fromScale, toScale)) {
                        POPPropertyAnimation *animation = activeAnimator.animationCreater();
                        [animation setProperty:[POPAnimatableProperty propertyWithName:kPOPViewScaleXY]];
                        [animation setFromValue:[NSValue valueWithCGPoint:fromScale]];
                        [animation setToValue:[NSValue valueWithCGPoint:toScale]];
                        [aspectInfo.instance pop_addAnimation:animation forKey:@"transfrom.scale"];
                    }
                    if (fabs(fromDegree - toDegree) >= 1.0) {
                        POPPropertyAnimation *animation = activeAnimator.animationCreater();
                        [animation setProperty:transformDegreePropertyAnimation];
                        [animation setFromValue:@(fromDegree)];
                        [animation setToValue:@(toDegree)];
                        [aspectInfo.instance pop_addAnimation:animation forKey:@"transfrom.degree"];
                    }
                    if (!CGPointEqualToPoint(fromTranslate, toTranslate)) {
                        POPPropertyAnimation *animation = activeAnimator.animationCreater();
                        [animation setProperty:transformTranslatePropertyAnimation];
                        [animation setFromValue:[NSValue valueWithCGPoint:fromTranslate]];
                        [animation setToValue:[NSValue valueWithCGPoint:toTranslate]];
                        [aspectInfo.instance pop_addAnimation:animation forKey:@"transfrom.translate"];
                    }
                }];
            }];
        }
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

+ (void)kimi_unmatrix:(CGAffineTransform)matrix completion:(void (^)(CGPoint, CGFloat, CGPoint))completion {
    CGFloat A = matrix.a;
    CGFloat B = matrix.b;
    CGFloat C = matrix.c;
    CGFloat D = matrix.d;
    if (A * D == B * C) {
        completion(CGPointMake(1.0, 1.0), 0.0, CGPointZero);
        return;
    }
    // step (3)
    CGFloat scaleX = sqrt(A * A + B * B);
    A /= scaleX;
    B /= scaleX;
    // step (4)
    CGFloat skew = A * C + B * D;
    C -= A * skew;
    D -= B * skew;
    // step (5)
    CGFloat scaleY = sqrt(C * C + D * D);
    C /= scaleY;
    D /= scaleY;
    skew /= scaleY;
    // step (6)
    if ( A * D < B * C ) {
        A = -A;
        B = -B;
        skew = -skew;
        scaleX = -scaleX;
    }
    completion(CGPointMake(scaleX, scaleY), atan2(B, A) / (M_PI / 180.0), CGPointMake(matrix.tx, matrix.ty));
}

@end

@implementation KIMIUIAnimator

+ (void)load {
    static KIMIUIAnimator *sharedAnimator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAnimator = [KIMIUIAnimator new];
    });
    EDO_EXPORT_CLASS(@"UIAnimator", nil);
    EDO_EXPORT_SCRIPT(@"Initializer.shared = new Initializer();");
    EDO_EXPORT_INITIALIZER({
        return sharedAnimator;
    });
    EDO_EXPORT_METHOD_ALIAS(linear:animations:completion:, @"linear");
    EDO_EXPORT_METHOD_ALIAS(spring:friction:animations:completion:, @"spring");

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
