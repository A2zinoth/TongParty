//
//  TJHomeController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJHomeController.h"
#import "TJHomeTableViewCell.h"
#import "LRTranstionAnimationPush.h"
#import "TJPublishController.h"
#import "TJRegisterController.h"
#import "TJLoginController.h"

@interface TJHomeController ()

@end

@implementation TJHomeController
- (void)createData {
    self.dataSource = @[@"", @"", @"", @"", @"", @""];
}
- (void)createUI {
    // 城市按钮
    UIButton *cityBtn = [[UIButton alloc] init];
    [cityBtn setTitle:@"北京" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor hx_colorWithHexString:@"#2E3041"] forState:UIControlStateNormal];
    [cityBtn setImage:[UIImage imageNamed:@"info_address"] forState:UIControlStateNormal];
    [self.view addSubview:cityBtn];
    [cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(33);
        } else {
            make.top.mas_equalTo(self.view).offset(33);
        }
        make.left.mas_equalTo(self.view).offset(24);
        make.width.mas_lessThanOrEqualTo(65);
        make.height.mas_equalTo(18);
    }];
    
    // 首页
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"首页";
    titleLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(87);
        } else {
            make.top.mas_equalTo(self.view).offset(87);
        }
        make.left.mas_equalTo(self.view).offset(24);
        make.size.mas_equalTo(CGSizeMake(50, 34));
    }];
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(142);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-kTabBarHeight);
        } else {
            make.top.mas_equalTo(self.view).offset(142);
            make.bottom.mas_equalTo(self.view).offset(-kTabBarHeight);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    
    // 发布按钮
    _publishBtn = [[YYLabel alloc] init];
    _publishBtn.text = @"+";
    _publishBtn.textAlignment = NSTextAlignmentCenter;
    _publishBtn.font = [UIFont systemFontOfSize:40];
    _publishBtn.layerCornerRadius = 26;
    _publishBtn.textColor = kWhiteColor;
    _publishBtn.backgroundColor = kBtnEnable;
    [self.view addSubview:_publishBtn];
    [_publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-31-kTabBarHeight);
        } else {
            make.bottom.mas_equalTo(self.view).offset(-31-kTabBarHeight);
        }
        make.trailing.mas_equalTo(self.view).offset(-24);
        make.size.mas_equalTo(CGSizeMake(52, 52));
    }];
    _publishBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
       [self.navigationController pushViewController:[TJPublishController new] animated:YES];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = true;
    self.navigationController.delegate = self;
    [DDUserDefault setObject:@"" forKey:@"isFirstOpenApp"];
    
#if DEBUG
    [DDUserDefault removeObjectForKey:@"token"];
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 没登录要去登录
    if (![DDUserDefault objectForKey:@"token"] && [DDUserDefault objectForKey:@"isFirstOpenApp"]) {
        TJLoginController *vc = [TJLoginController new];
        vc.phone = @"直接";
        
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TJRegisterController new]];
        //[TJRegisterController new]
        
        [self presentViewController:nav animated:true completion:nil];
        [DDUserDefault removeObjectForKey:@"isFirstOpenApp"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeTableViewCellID"];
    if (!cell) {
        cell = [[TJHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJHomeTableViewCellID"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 119.0;
}

#pragma mark -- UINavigationControllerDelegate --

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        return [LRTranstionAnimationPush new];
    }else{
        return nil;
    }
}

@end
