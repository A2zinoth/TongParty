//
//  BaseViewController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self createData];
    [self createUI];

}

- (void)createData {
}

- (void)createUI {
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self willRequestData];
//}
//
//- (void)willRequestData {
//
//}

#pragma mark - TableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 0;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { return  nil;}

#pragma  mark - Navigation
- (void)push:(UIViewController *)viewController {
    if (self.navigationController)
        [self.navigationController pushViewController:viewController animated:true];
}

- (void)pop {
    if (self.navigationController != nil) return ;
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - AlertController
- (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(void (^)())cancel ok:(void (^)())ok {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancel();
    }];
    [ac addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ok();
    }];
    [ac addAction:okAction];
    [self presentViewController:ac animated:true completion:nil];
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancelTitle ok:(NSString *)okTitle cancel:(void (^)())cancel ok:(void (^)())ok {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancel();
    }];
    [ac addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ok();
    }];
    [ac addAction:okAction];
    [self presentViewController:ac animated:true completion:nil];
}


@end
