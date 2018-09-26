//
//  KIMIMenu.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/9/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIMenu.h"
#import <Endo/EDOExporter.h>

typedef void(^KIMIMenuItemBlock)(NSArray *);

@interface KIMIMenuItem : UIMenuItem

@property (nonatomic, copy) KIMIMenuItemBlock block;

@end

@implementation KIMIMenuItem

@end

@interface KIMIMenuHostingView : UIView

@property (nonatomic, strong) NSMutableArray<void (^)(NSArray *)> *menuItemBlocks;

@end

@implementation KIMIMenuHostingView

+ (KIMIMenuHostingView *)shared {
    static KIMIMenuHostingView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [KIMIMenuHostingView new];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]
         addObserverForName:UIMenuControllerDidHideMenuNotification
         object:nil
         queue:[NSOperationQueue mainQueue]
         usingBlock:^(NSNotification * _Nonnull note) {
            [self removeFromSuperview];
        }];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([self respondsToSelector:action] && [NSStringFromSelector(action) hasPrefix:@"handleItem"]) {
        return YES;
    }
    return NO;
}

- (void)handleItem0Touched:(UIMenuController *)sender {
    if (0 < sender.menuItems.count && [sender.menuItems[0] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[0] block](nil);
    }
}

- (void)handleItem1Touched:(UIMenuController *)sender {
    if (1 < sender.menuItems.count && [sender.menuItems[1] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[1] block](nil);
    }
}

- (void)handleItem2Touched:(UIMenuController *)sender {
    if (2 < sender.menuItems.count && [sender.menuItems[2] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[2] block](nil);
    }
}

- (void)handleItem3Touched:(UIMenuController *)sender {
    if (3 < sender.menuItems.count && [sender.menuItems[3] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[3] block](nil);
    }
}

- (void)handleItem4Touched:(UIMenuController *)sender {
    if (4 < sender.menuItems.count && [sender.menuItems[4] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[4] block](nil);
    }
}

- (void)handleItem5Touched:(UIMenuController *)sender {
    if (5 < sender.menuItems.count && [sender.menuItems[5] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[5] block](nil);
    }
}

- (void)handleItem6Touched:(UIMenuController *)sender {
    if (6 < sender.menuItems.count && [sender.menuItems[6] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[6] block](nil);
    }
}

- (void)handleItem7Touched:(UIMenuController *)sender {
    if (7 < sender.menuItems.count && [sender.menuItems[7] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[7] block](nil);
    }
}

- (void)handleItem8Touched:(UIMenuController *)sender {
    if (8 < sender.menuItems.count && [sender.menuItems[8] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[8] block](nil);
    }
}

- (void)handleItem9Touched:(UIMenuController *)sender {
    if (9 < sender.menuItems.count && [sender.menuItems[9] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[9] block](nil);
    }
}

- (void)handleItem10Touched:(UIMenuController *)sender {
    if (10 < sender.menuItems.count && [sender.menuItems[10] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[10] block](nil);
    }
}

- (void)handleItem11Touched:(UIMenuController *)sender {
    if (11 < sender.menuItems.count && [sender.menuItems[11] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[11] block](nil);
    }
}

- (void)handleItem12Touched:(UIMenuController *)sender {
    if (12 < sender.menuItems.count && [sender.menuItems[12] isKindOfClass:[KIMIMenuItem class]]) {
        [(KIMIMenuItem *)sender.menuItems[12] block](nil);
    }
}

@end

@interface KIMIMenu ()

@property (nonatomic, strong) NSMutableArray<KIMIMenuItem *> *menuItems;

@end

@implementation KIMIMenu

+ (void)load {
    EDO_EXPORT_CLASS(@"UIMenu", nil);
    EDO_EXPORT_METHOD_ALIAS(addMenuItem:actionBlock:, @"addMenuItem");
    EDO_EXPORT_METHOD(show:);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _menuItems = [NSMutableArray array];
    }
    return self;
}

- (void)addMenuItem:(NSString *)title actionBlock:(void (^)(NSArray *))actionBlock {
    KIMIMenuItem *item = [[KIMIMenuItem alloc] initWithTitle:title action:NSSelectorFromString([NSString stringWithFormat:@"handleItem%luTouched:",
                                                                                                (unsigned long)self.menuItems.count])];
    item.block = actionBlock;
    [self.menuItems addObject:item];
}

- (void)show:(UIView *)inView {
    KIMIMenuHostingView *hostingView = [KIMIMenuHostingView shared];
    hostingView.userInteractionEnabled = NO;
    [inView addSubview:hostingView];
    hostingView.frame = inView.bounds;
    [hostingView becomeFirstResponder];
    [UIMenuController.sharedMenuController setMenuItems:self.menuItems];
    [UIMenuController.sharedMenuController setTargetRect:hostingView.bounds inView:hostingView];
    [UIMenuController.sharedMenuController setMenuVisible:YES animated:YES];
}

@end
