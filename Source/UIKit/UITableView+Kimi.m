//
//  UITableView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITableView+Kimi.h"
#import <Endo/EDOExporter.h>
#import <objc/runtime.h>

typedef id(^KimiTableViewCellInitializer)(NSArray *arguments, BOOL);

@interface UITableView(Kimi_Private)

@property (nonatomic, strong) JSContext *kimi_context;
@property (nonatomic, copy) NSDictionary<NSString *, KimiTableViewCellInitializer> *kimi_cellInitializer;

@end

@implementation UITableView(Kimi_Private)

static int kKimiContextTag;
static int kCellInitializerTag;

- (NSDictionary<NSString *,KimiTableViewCellInitializer> *)kimi_cellInitializer {
    return objc_getAssociatedObject(self, &kCellInitializerTag);
}

- (void)setKimi_cellInitializer:(NSDictionary<NSString *,KimiTableViewCellInitializer> *)kimi_cellInitializer {
    objc_setAssociatedObject(self, &kCellInitializerTag, kimi_cellInitializer, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JSContext *)kimi_context {
    return [objc_getAssociatedObject(self, &kKimiContextTag) nonretainedObjectValue];
}

- (void)setKimi_context:(JSContext *)kimi_context {
    objc_setAssociatedObject(self, &kKimiContextTag, [NSValue valueWithNonretainedObject:kimi_context], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UITableView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITableView", @"UIScrollView");
    EDO_EXPORT_PROPERTY(@"tableHeaderView");
    EDO_EXPORT_PROPERTY(@"tableFooterView");
    EDO_EXPORT_PROPERTY(@"separatorColor");
    EDO_EXPORT_PROPERTY(@"separatorInset");
    EDO_EXPORT_PROPERTY(@"allowsSelection");
    EDO_EXPORT_PROPERTY(@"allowsMultipleSelection");
    EDO_EXPORT_METHOD_ALIAS(edo_register:reuseIdentifier:, @"register");
    EDO_EXPORT_METHOD_ALIAS(edo_dequeueReusableCell:indexPath:, @"dequeueReusableCell");
    EDO_EXPORT_METHOD(reloadData);
    EDO_EXPORT_METHOD_ALIAS(selectRowAtIndexPath:animated:scrollPosition:, @"selectRow");
    EDO_EXPORT_METHOD_ALIAS(deselectRowAtIndexPath:animated:, @"deselectRow");
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        view.estimatedRowHeight = 0;
        view.kimi_context = [JSContext currentContext];
        view.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        view.backgroundColor = [UIColor clearColor];
        UIView *headerView = [UIView new];
        headerView.frame = CGRectMake(0, 0, 0, 0.01);
        view.tableHeaderView = headerView;
        UIView *footerView = [UIView new];
        [footerView setBackgroundColor:[UIColor redColor]];
        footerView.frame = CGRectMake(0, 0, 0, 0.01);
        view.tableFooterView = footerView;
        view.delegate = view;
        view.dataSource = view;
        return view;
    }];
}

- (void)edo_register:(id (^)(NSArray *arguments))initializer reuseIdentifier:(NSString *)reuseIdentifier {
    NSMutableDictionary *mutable = [(self.kimi_cellInitializer ?: @{}) mutableCopy];
    [mutable setObject:initializer forKey:reuseIdentifier];
    self.kimi_cellInitializer = mutable;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (UITableViewCell *)edo_dequeueReusableCell:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [[EDOExporter sharedExporter] createScriptObjectIfNeed:cell
                                                   context:self.kimi_context
                                               initializer:self.kimi_cellInitializer[reuseIdentifier]
                                            createIfNeeded:YES];
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
    UITableViewCell *cell = [self edo_valueWithEventName:@"cellForRow"
                                               arguments:@[indexPath]];
    if (![cell isKindOfClass:[UITableViewCell class]]) {
        return [UITableViewCell new];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id value = [self edo_valueWithEventName:@"heightForRow"
                                  arguments:@[indexPath]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return self.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [self edo_valueWithEventName:@"viewForHeader"
                                      arguments:@[@(section)]];
    if ([view isKindOfClass:[UIView class]]) {
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id value = [self edo_valueWithEventName:@"heightForHeader"
                                  arguments:@[@(section)]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [self edo_valueWithEventName:@"viewForFooter"
                                      arguments:@[@(section)]];
    if ([view isKindOfClass:[UIView class]]) {
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id value = [self edo_valueWithEventName:@"heightForFooter"
                                  arguments:@[@(section)]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return 0.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self edo_emitWithEventName:@"didSelectRow"
                      arguments:@[
                                  indexPath,
                                  [tableView cellForRowAtIndexPath:indexPath] ?: [NSNull null],
                                  ]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self edo_emitWithEventName:@"didDeselectRow"
                      arguments:@[
                                  indexPath,
                                  [tableView cellForRowAtIndexPath:indexPath] ?: [NSNull null],
                                  ]];
}

@end
