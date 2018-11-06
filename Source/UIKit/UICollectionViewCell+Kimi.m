//
//  UICollectionViewCell+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/28.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UICollectionViewCell+Kimi.h"
#import "EDOExporter.h"
#import <Aspects/Aspects.h>

@implementation UICollectionViewCell (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UICollectionViewCell", @"UIView");
    EDO_EXPORT_READONLY_PROPERTY(@"contentView");
    EDO_EXPORT_READONLY_PROPERTY(@"reuseIdentifier");
    [self aspect_hookSelector:@selector(setSelected:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL selected) {
        [(UICollectionViewCell *)aspectInfo.instance edo_emitWithEventName:@"selected"
                                                                 arguments:@[
                                                                             aspectInfo.instance,
                                                                             @(selected),
                                                                             ]];
    } error:NULL];
    [self aspect_hookSelector:@selector(setHighlighted:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL highlighted) {
        [(UICollectionViewCell *)aspectInfo.instance edo_emitWithEventName:@"highlighted"
                                                                 arguments:@[
                                                                             aspectInfo.instance,
                                                                             @(highlighted),
                                                                             ]];
    } error:NULL];
}

@end
