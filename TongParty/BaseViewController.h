//
//  BaseViewController.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
@interface BaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView        *tableView;
@property (nonatomic, strong) NSArray            *dataSource;

- (void)push:(UIViewController *)viewController;
- (void)pop;

- (void)createData;
- (void)createUI;
//- (void)willRequestData;

- (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(void (^)())cancel ok:(void (^)())ok;
- (void)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancelTitle ok:(NSString *)okTitle cancel:(void (^)())cancel ok:(void (^)())ok;
@end
