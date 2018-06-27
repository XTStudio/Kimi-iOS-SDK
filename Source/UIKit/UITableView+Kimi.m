//
//  UITableView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITableView+Kimi.h"
#import "UIView+Kimi.h"
#import <Endo/EDOExporter.h>
#import <Aspects/Aspects.h>
#import <objc/runtime.h>

typedef id(^KimiTableViewCellInitializer)(NSArray *arguments);

@interface UITableView(Kimi_Private)

@property (nonatomic, strong) NSMutableSet<UITableViewCell *> *kimi_allocatedCells;
@property (nonatomic, strong) NSMutableSet<NSIndexPath *> *kimi_allocatedIndexes;
@property (nonatomic, copy) NSDictionary<NSString *, KimiTableViewCellInitializer> *kimi_cellInitializer;

@end

@implementation UITableView(Kimi_Private)

static int kCellInitializerTag;
static int kAllocatedCellsTag;
static int kAllocatedIndexesTag;

- (NSDictionary<NSString *,KimiTableViewCellInitializer> *)kimi_cellInitializer {
    return objc_getAssociatedObject(self, &kCellInitializerTag);
}

- (void)setKimi_cellInitializer:(NSDictionary<NSString *,KimiTableViewCellInitializer> *)kimi_cellInitializer {
    objc_setAssociatedObject(self, &kCellInitializerTag, kimi_cellInitializer, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableSet<UITableViewCell *> *)kimi_allocatedCells {
    if (objc_getAssociatedObject(self, &kAllocatedCellsTag) == nil) {
        self.kimi_allocatedCells = [NSMutableSet set];
    }
    return objc_getAssociatedObject(self, &kAllocatedCellsTag);
}

- (void)setKimi_allocatedCells:(NSMutableSet<UITableViewCell *> *)kimi_allocatedCells {
    objc_setAssociatedObject(self, &kAllocatedCellsTag, kimi_allocatedCells, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet<UITableViewCell *> *)kimi_allocatedIndexes {
    if (objc_getAssociatedObject(self, &kAllocatedIndexesTag) == nil) {
        self.kimi_allocatedIndexes = [NSMutableSet set];
    }
    return objc_getAssociatedObject(self, &kAllocatedIndexesTag);
}

- (void)setKimi_allocatedIndexes:(NSMutableSet<UITableViewCell *> *)kimi_allocatedIndexes {
    objc_setAssociatedObject(self, &kAllocatedIndexesTag, kimi_allocatedIndexes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UITableView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITableView", @"UIScrollView");
    EDO_EXPORT_PROPERTY(@"tableHeaderView");
    EDO_EXPORT_PROPERTY(@"tableFooterView");
    EDO_EXPORT_METHOD_ALIAS(edo_register:reuseIdentifier:, @"register");
    EDO_EXPORT_METHOD_ALIAS(edo_dequeueReusableCell:indexPath:, @"dequeueReusableCell");
    EDO_EXPORT_METHOD(reloadData);
    EDO_EXPORT_METHOD_ALIAS(selectRowAtIndexPath:animated:scrollPosition:, @"selectRow");
    EDO_EXPORT_METHOD_ALIAS(deselectRowAtIndexPath:animated:, @"deselectRow");
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        view.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        view.backgroundColor = [UIColor clearColor];
        UIView *headerView = [UIView new];
        headerView.frame = CGRectMake(0, 0, 0, 0.01);
        view.tableHeaderView = headerView;
        UIView *footerView = [UIView new];
        [footerView setBackgroundColor:[UIColor redColor]];
        footerView.frame = CGRectMake(0, 0, 0, 0.01);
        view.tableFooterView = footerView;
//        view.contentInset = UIEdgeInsetsMake(0, 0, -20, 0);
        if (@available(iOS 11.0, *)) {
            view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        view.delegate = view;
        view.dataSource = view;
        return view;
    }];
}

- (void)edo_release {
    [super edo_release];
    [self.kimi_allocatedCells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull obj, BOOL * _Nonnull stop) {
        EDO_RELEASE(obj);
    }];
    [self.kimi_allocatedIndexes enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, BOOL * _Nonnull stop) {
        EDO_RELEASE(obj);
    }];
}

- (void)edo_register:(id (^)(NSArray *arguments))initializer reuseIdentifier:(NSString *)reuseIdentifier {
    NSMutableDictionary *mutable = [(self.kimi_cellInitializer ?: @{}) mutableCopy];
    [mutable setObject:initializer forKey:reuseIdentifier];
    self.kimi_cellInitializer = mutable;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (UITableViewCell *)edo_dequeueReusableCell:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    [self kimi_retainIndexPath:indexPath];
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (![self.kimi_allocatedCells containsObject:cell]) {
        KimiTableViewCellInitializer cellInitializer = self.kimi_cellInitializer[reuseIdentifier];
        if (cellInitializer != nil) {
            [[EDOExporter sharedExporter] scriptObjectWithObject:cell initializer:cellInitializer];
            EDO_RETAIN(cell);
        }
        [self.kimi_allocatedCells addObject:cell];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    id value = [self edo_valueWithEventName:@"numberOfSections" arguments:nil];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id value = [self edo_valueWithEventName:@"numberOfRows" arguments:@[@(section)]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self kimi_retainIndexPath:indexPath];
    UITableViewCell *cell = [self edo_valueWithEventName:@"cellForRow"
                                               arguments:@[indexPath]];
    if (![cell isKindOfClass:[UITableViewCell class]]) {
        return [UITableViewCell new];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self kimi_retainIndexPath:indexPath];
    id value = [self edo_valueWithEventName:@"heightForRow"
                                  arguments:@[indexPath]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return self.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self kimi_retainIndexPath:indexPath];
    [self edo_emitWithEventName:@"didSelectRow"
                      arguments:@[
                                  indexPath,
                                  [tableView cellForRowAtIndexPath:indexPath] ?: [NSNull null],
                                  ]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self kimi_retainIndexPath:indexPath];
    [self edo_emitWithEventName:@"didDeselectRow"
                      arguments:@[
                                  indexPath,
                                  [tableView cellForRowAtIndexPath:indexPath] ?: [NSNull null],
                                  ]];
}

- (void)kimi_retainIndexPath:(NSIndexPath *)indexPath {
    if (![self.kimi_allocatedIndexes containsObject:indexPath]) {
        [[EDOExporter sharedExporter] scriptObjectWithObject:indexPath];
        EDO_RETAIN(indexPath);
        [self.kimi_allocatedIndexes addObject:indexPath];
    }
}

@end
