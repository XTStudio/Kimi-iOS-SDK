//
//  KimiUITestVCController.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/16.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KimiUITestVCController : NSObject

@property (nonatomic, assign) BOOL fulfilled;

- (instancetype)initWithTestName:(NSString *)testName;

- (void)present:(UIViewController *)fromViewController;

@end
