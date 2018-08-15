//
//  UIViewController+Kimi.h
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIMIDefaultViewController: UIViewController

@property (nonatomic, strong) id keyboardWillShowObserver;
@property (nonatomic, strong) id keyboardWillHideObserver;

@end

@interface UIViewController (Kimi)

@end
