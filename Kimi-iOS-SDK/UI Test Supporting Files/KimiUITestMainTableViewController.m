//
//  KimiUITestMainTableViewController.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/12.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KimiUITestMainTableViewController.h"
#import "KimiUITestViewsViewController.h"
#import "KimiUITestVCController.h"

@interface KimiUITestMainTableViewController ()

@property (nonatomic, strong) KimiUITestVCController *testVCController;

@end

@implementation KimiUITestMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *testName = cell.textLabel.text;
    if ([testName hasSuffix:@"Controller"]) {
        self.testVCController = [[KimiUITestVCController alloc] initWithTestName:testName];
        [self.testVCController present:self];
    }
    else {
        KimiUITestViewsViewController *nextViewController = [[KimiUITestViewsViewController alloc] initWithTestName:cell.textLabel.text];
        [self.navigationController pushViewController:nextViewController animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
