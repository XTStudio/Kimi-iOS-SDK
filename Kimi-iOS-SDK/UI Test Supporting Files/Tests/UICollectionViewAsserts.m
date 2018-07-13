//
//  UICollectionViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UICollectionViewAsserts.h"

@implementation UICollectionViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"dataSource - Wait"]) {
        UICollectionView *collectionView = mainObject.subviews[0];
        return [collectionView visibleCells].count == 4
        && collectionView.numberOfSections == 2
        && [[collectionView visibleCells][0].contentView.backgroundColor isEqual:[UIColor yellowColor]]
        && CGSizeEqualToSize([collectionView visibleCells][0].frame.size, CGSizeMake(44, 44));
    }
    if ([caseName isEqualToString:@"selectItem - Tap"]) {
        UICollectionView *collectionView = mainObject.subviews[0];
        return [[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].contentView.backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"deselectItem - Wait"]) {
        UICollectionView *collectionView = mainObject.subviews[0];
        return [[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].contentView.backgroundColor isEqual:[UIColor yellowColor]];
    }
    return YES;
}

@end
