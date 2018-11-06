//
//  UICollectionView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/28.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UICollectionView+Kimi.h"
#import <xt_engine/EDOExporter.h>
#import <objc/runtime.h>

typedef id(^KimiCollectionViewCellInitializer)(NSArray *arguments, BOOL);

@interface UICollectionView(Kimi_Private)

@property (nonatomic, strong) JSContext *kimi_context;
@property (nonatomic, copy) NSDictionary<NSString *, KimiCollectionViewCellInitializer> *kimi_cellInitializer;

@end

@implementation UICollectionView(Kimi_Private)

static int kKimiContextTag;
static int kCellInitializerTag;

- (NSDictionary<NSString *,KimiCollectionViewCellInitializer> *)kimi_cellInitializer {
    return objc_getAssociatedObject(self, &kCellInitializerTag);
}

- (void)setKimi_cellInitializer:(NSDictionary<NSString *,KimiCollectionViewCellInitializer> *)kimi_cellInitializer {
    objc_setAssociatedObject(self, &kCellInitializerTag, kimi_cellInitializer, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JSContext *)kimi_context {
    return [objc_getAssociatedObject(self, &kKimiContextTag) nonretainedObjectValue];
}

- (void)setKimi_context:(JSContext *)kimi_context {
    objc_setAssociatedObject(self, &kKimiContextTag, [NSValue valueWithNonretainedObject:kimi_context], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UICollectionView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UICollectionView", @"UIScrollView");
    EDO_EXPORT_READONLY_PROPERTY(@"collectionViewLayout");
    EDO_EXPORT_PROPERTY(@"allowsSelection");
    EDO_EXPORT_PROPERTY(@"allowsMultipleSelection");
    EDO_EXPORT_METHOD_ALIAS(edo_register:reuseIdentifier:, @"register");
    EDO_EXPORT_METHOD_ALIAS(edo_dequeueReusableCell:indexPath:, @"dequeueReusableCell");
    EDO_EXPORT_METHOD(reloadData);
    EDO_EXPORT_METHOD_ALIAS(selectItemAtIndexPath:animated:scrollPosition:, @"selectItem");
    EDO_EXPORT_METHOD_ALIAS(deselectItemAtIndexPath:animated:, @"deselectItem");
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        if (0 < arguments.count && [arguments[0] isKindOfClass:[UICollectionViewLayout class]]) {
            UICollectionView *instance = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:arguments[0]];
            instance.kimi_context = [JSContext currentContext];
            instance.delegate = instance;
            instance.dataSource = instance;
            instance.backgroundColor = [UIColor clearColor];
            return instance;
        }
        else {
            UICollectionView *instance = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
            instance.kimi_context = [JSContext currentContext];
            instance.delegate = instance;
            instance.dataSource = instance;
            instance.backgroundColor = [UIColor clearColor];
            return instance;
        }
    }];
}

- (void)edo_register:(id (^)(NSArray *arguments))initializer reuseIdentifier:(NSString *)reuseIdentifier {
    NSMutableDictionary *mutable = [(self.kimi_cellInitializer ?: @{}) mutableCopy];
    [mutable setObject:initializer forKey:reuseIdentifier];
    self.kimi_cellInitializer = mutable;
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (UICollectionViewCell *)edo_dequeueReusableCell:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [[EDOExporter sharedExporter] createScriptObjectIfNeed:cell
                                                   context:self.kimi_context
                                               initializer:self.kimi_cellInitializer[reuseIdentifier]
                                            createIfNeeded:YES];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    id value = [self edo_valueWithEventName:@"numberOfSections" arguments:nil];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id value = [self edo_valueWithEventName:@"numberOfItems" arguments:@[@(section)]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self edo_valueWithEventName:@"cellForItem"
                                                    arguments:@[indexPath]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self edo_emitWithEventName:@"didSelectItem"
                      arguments:@[
                                  indexPath,
                                  [collectionView cellForItemAtIndexPath:indexPath] ?: [NSNull null],
                                  ]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self edo_emitWithEventName:@"didDeselectItem"
                      arguments:@[
                                  indexPath,
                                  [collectionView cellForItemAtIndexPath:indexPath] ?: [NSNull null],
                                  ]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *value = [collectionViewLayout edo_valueWithEventName:@"sizeForItem"
                                                             arguments:@[indexPath]];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return CGSizeMake([value[@"width"] floatValue], [value[@"height"] floatValue]);
    }
    return [collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]] ? [(UICollectionViewFlowLayout *)collectionViewLayout itemSize] : CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSDictionary *value = [collectionViewLayout edo_valueWithEventName:@"insetForSection"
                                                             arguments:@[@(section)]];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return UIEdgeInsetsMake([value[@"top"] floatValue],
                                [value[@"left"] floatValue],
                                [value[@"bottom"] floatValue],
                                [value[@"right"] floatValue]);
    }
    return [collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]] ? [(UICollectionViewFlowLayout *)collectionViewLayout sectionInset] : UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    id value = [collectionViewLayout edo_valueWithEventName:@"minimumLineSpacing" arguments:@[@(section)]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return [collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]] ? [(UICollectionViewFlowLayout *)collectionViewLayout minimumLineSpacing] : 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    id value = [collectionViewLayout edo_valueWithEventName:@"minimumInteritemSpacing" arguments:@[@(section)]];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return [collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]] ? [(UICollectionViewFlowLayout *)collectionViewLayout minimumInteritemSpacing] : 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    NSDictionary *value = [collectionViewLayout edo_valueWithEventName:@"referenceSizeForHeader"
                                                             arguments:@[@(section)]];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return CGSizeMake([value[@"width"] floatValue], [value[@"height"] floatValue]);
    }
    return [collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]] ? [(UICollectionViewFlowLayout *)collectionViewLayout headerReferenceSize] : CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSDictionary *value = [collectionViewLayout edo_valueWithEventName:@"referenceSizeForFooter"
                                                             arguments:@[@(section)]];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return CGSizeMake([value[@"width"] floatValue], [value[@"height"] floatValue]);
    }
    return [collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]] ? [(UICollectionViewFlowLayout *)collectionViewLayout footerReferenceSize] : CGSizeZero;
}

@end
