//
//  BaseViewController.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
@interface BaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView        *tableView;
@property (nonatomic, strong) NSArray            *dataSource;

- (void)createData;
- (void)createUI;
@end
