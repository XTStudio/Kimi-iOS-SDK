//
//  ViewController.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "CustomTestViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Endo/EDOExporter.h>
#import <UULog/UULog.h>

@interface CustomTestViewController ()

@property (nonatomic, strong) JSContext *context;

@end

@implementation CustomTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Custom";
    self.context = [[JSContext alloc] init];
    [UULog attachToContext:self.context];
    [[EDOExporter sharedExporter] exportWithContext:self.context];
    [self.context evaluateScript:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"custom" ofType:@"js"]
                                                           encoding:NSUTF8StringEncoding
                                                              error:nil]];
}

@end
