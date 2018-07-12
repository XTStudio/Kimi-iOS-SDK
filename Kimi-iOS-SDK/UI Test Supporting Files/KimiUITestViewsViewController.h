//
//  KimiUITestViewsViewController.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/12.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KimiUITestViewsViewController : UIViewController

@property (nonatomic, assign) BOOL fulfilled;

- (instancetype)initWithTestName:(NSString *)testName;

@end
