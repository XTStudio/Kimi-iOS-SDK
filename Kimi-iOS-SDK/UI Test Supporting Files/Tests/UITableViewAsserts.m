//
//  UITableViewAsserts.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/16.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITableViewAsserts.h"

@implementation UITableViewAsserts

- (BOOL)assert:(NSString *)caseName mainObject:(UIView *)mainObject {
    if ([caseName isEqualToString:@"DataSource - Wait"]) {
        UITableView *tableView = mainObject.subviews[0];
        return tableView.numberOfSections == 2
        && [tableView numberOfRowsInSection:0] == 1000
        && [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].contentView.backgroundColor isEqual:[UIColor yellowColor]];
    }
    if ([caseName isEqualToString:@"selectItem - Tap"]) {
        UITableView *tableView = mainObject.subviews[0];
        return [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].contentView.backgroundColor isEqual:[UIColor redColor]];
    }
    if ([caseName isEqualToString:@"deselectItem - Wait"]) {
        UITableView *tableView = mainObject.subviews[0];
        return [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].contentView.backgroundColor isEqual:[UIColor yellowColor]];
    }
    if ([caseName isEqualToString:@"tableHeaderView & tableFooterView - Wait"]) {
        UITableView *tableView = mainObject.subviews[0];
        return [tableView.tableHeaderView.backgroundColor isEqual:[UIColor blueColor]]
        && [tableView.tableFooterView.backgroundColor isEqual:[UIColor greenColor]];
    }
    return YES;
}

@end
