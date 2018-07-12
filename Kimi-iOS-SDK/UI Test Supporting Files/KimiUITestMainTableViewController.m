//
//  KimiUITestMainTableViewController.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/12.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KimiUITestMainTableViewController.h"
#import "KimiUITestViewsViewController.h"

@interface KimiUITestMainTableViewController ()

@end

@implementation KimiUITestMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    KimiUITestViewsViewController *nextViewController = [[KimiUITestViewsViewController alloc] initWithTestName:cell.textLabel.text];
    [self.navigationController pushViewController:nextViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
