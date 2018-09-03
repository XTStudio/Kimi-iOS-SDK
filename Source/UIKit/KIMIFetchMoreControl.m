//
//  UIFetchMoreControl.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/8/14.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIFetchMoreControl.h"
#import <Endo/EDOExporter.h>

@interface KIMIFetchMoreControl()

@property (nonatomic, readwrite) BOOL fetching;
@property (nonatomic, strong) NSDate *triggerDelay;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation KIMIFetchMoreControl

+ (void)load {
    EDO_EXPORT_CLASS(@"UIFetchMoreControl", @"UIView");
    EDO_EXPORT_PROPERTY(@"enabled");
    EDO_EXPORT_READONLY_PROPERTY(@"refreshing");
    EDO_EXPORT_PROPERTY(@"tintColor");
    EDO_EXPORT_METHOD(beginFetching);
    EDO_EXPORT_METHOD(endFetching);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _enabled = YES;
        _fetchingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44.0)];
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_fetchingView addSubview:_activityIndicatorView];
    }
    return self;
}

- (void)handleValueChanged {
    [self edo_emitWithEventName:@"refresh" arguments:@[self]];
}

- (void)scrollViewDidScroll {
    if (self.enabled) {
        if (self.fetching || (self.triggerDelay != nil && [self.triggerDelay timeIntervalSinceNow] > 0)) {
            return;
        }
        if (self.scrollView.contentSize.height < self.scrollView.bounds.size.height) {
            return;
        }
        if (self.scrollView.contentOffset.y + self.scrollView.bounds.size.height > self.scrollView.contentSize.height - self.scrollView.bounds.size.height) {
            [self beginFetching];
            [self edo_emitWithEventName:@"fetch" arguments:@[self]];
        }
    }
}

- (void)beginFetching {
    self.fetching = YES;
    self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top,
                                                    self.scrollView.contentInset.left,
                                                    self.scrollView.contentInset.bottom + 44.0,
                                                    self.scrollView.contentInset.right);
    [self.scrollView addSubview:self.fetchingView];
    [self.activityIndicatorView startAnimating];
    [self layoutSubviews];
}

- (void)endFetching {
    self.fetching = NO;
    self.triggerDelay = [NSDate dateWithTimeIntervalSinceNow:1.0];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top,
                                                    self.scrollView.contentInset.left,
                                                    self.scrollView.contentInset.bottom - 44.0,
                                                    self.scrollView.contentInset.right);
    [self.fetchingView removeFromSuperview];
    [self.activityIndicatorView stopAnimating];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    self.activityIndicatorView.color = self.tintColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.fetching) {
        self.fetchingView.frame = CGRectMake(0.0, self.scrollView.contentSize.height, self.scrollView.bounds.size.width, 44.0);
        self.activityIndicatorView.center = CGPointMake(self.fetchingView.bounds.size.width / 2.0, self.fetchingView.bounds.size.height / 2.0);
    }
}

@end
