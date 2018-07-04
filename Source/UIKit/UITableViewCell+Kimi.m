//
//  UITableViewCell+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITableViewCell+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>

@implementation UITableViewCell (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITableViewCell", @"UIView");
    EDO_EXPORT_READONLY_PROPERTY(@"contentView");
    EDO_EXPORT_READONLY_PROPERTY(@"reuseIdentifier");
    EDO_EXPORT_PROPERTY(@"edo_hasSelectionStyle");
    [self aspect_hookSelector:@selector(setSelected:animated:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL selected, BOOL animated) {
        [(UITableViewCell *)aspectInfo.instance edo_emitWithEventName:@"selected"
                                                            arguments:@[
                                                                        aspectInfo.instance,
                                                                        @(selected),
                                                                        @(animated),
                                                                        ]];
    } error:NULL];
    [self aspect_hookSelector:@selector(setHighlighted:animated:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL highlighted, BOOL animated) {
        [(UITableViewCell *)aspectInfo.instance edo_emitWithEventName:@"highlighted"
                                                            arguments:@[
                                                                        aspectInfo.instance,
                                                                        @(highlighted),
                                                                        @(animated),
                                                                        ]];
    } error:NULL];
}

- (BOOL)edo_hasSelectionStyle {
    return self.selectionStyle != UITableViewCellSelectionStyleNone;
}

- (void)setEdo_hasSelectionStyle:(BOOL)edo_hasSelectionStyle {
    self.selectionStyle = edo_hasSelectionStyle ? UITableViewCellSelectionStyleGray : UITableViewCellSelectionStyleNone;
}

@end
