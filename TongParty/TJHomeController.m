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
#import "TJCreatePwdController.h"
#import "TJHomeModel.h"
#import "TJDeskViewController.h"

@interface TJHomeController ()

@property (nonatomic, strong) TJHomeModel           *homeModel;
@property (nonatomic, strong) AMapLocationManager   *locationManager;

@end

@implementation TJHomeController
- (void)createData {
    _homeModel = [[TJHomeModel alloc] init];
    [self configLocationManager];
}
- (void)createUI {
    // 城市按钮
    UIImageView *cityIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TJCity"]];
    [self.view addSubview:cityIV];
    [cityIV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(16);
        } else {
            make.top.mas_equalTo(self.view).offset(36);
        }
        make.left.mas_equalTo(self.view).offset(24);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(12.3);
    }];
    
    UIButton *cityBtn = [[UIButton alloc] init];
    [cityBtn setTitle:@"北京" forState:UIControlStateNormal];
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cityBtn setTitleColor:[UIColor hx_colorWithHexString:@"#2E3041"] forState:UIControlStateNormal];
//    [cityBtn setImage:[UIImage imageNamed:@"TJCity"] forState:UIControlStateNormal];
    [self.view addSubview:cityBtn];
    [cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(14);
        } else {
            make.top.mas_equalTo(self.view).offset(34);
        }
        make.left.mas_equalTo(self.view).offset(34);
        make.width.mas_lessThanOrEqualTo(65);
        make.height.mas_equalTo(18);
    }];
    
    // 首页
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"首页";
    titleLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(67);
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
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
//    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = NO;
//    self.tableView. = header;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(122);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-kTabBarHeigthOrigin);
        } else {
            make.top.mas_equalTo(self.view).offset(142);
            make.bottom.mas_equalTo(self.view).offset(-kTabBarHeigthOrigin);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    
    // 发布按钮
    
    UIImageView *publishIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TJCreateDesk"]];
//    publishIV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:publishIV];
    [publishIV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-6-kTabBarHeigthOrigin);
        } else {
            make.bottom.mas_equalTo(self.view).offset(-6-kTabBarHeigthOrigin);
        }
        make.trailing.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    _publishBtn = [[TJButton alloc] init];
    [_publishBtn addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_publishBtn];
    [_publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-31-kTabBarHeigthOrigin);
        } else {
            make.bottom.mas_equalTo(self.view).offset(-31-kTabBarHeigthOrigin);
        }
        make.trailing.mas_equalTo(self.view).offset(-24);
        make.size.mas_equalTo(CGSizeMake(52, 52));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = true;
    
//    self.title = @"首页";
//    if (@available(ios 11,*)) {
//        self.navigationController.navigationBar.prefersLargeTitles = true;
//    }
    
    [DDUserDefault setObject:@"" forKey:@"isFirstOpenApp"];
    
#if DEBUG
    [DDUserDefault removeObjectForKey:@"token"];
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    WeakSelf(weakSelf);
    if ([DDUserDefault objectForKey:@"token"]) {
        [_homeModel requestTableList:^(id obj) {
            weakSelf.dataSource = obj;
            [weakSelf.tableView reloadData];
        }];
    } else {
        [self gotoLogin];
    }
    
    [self startLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJHomeTableViewCellID"];
    if (!cell) {
        cell = [[TJHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJHomeTableViewCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell updateWithModel:self.dataSource[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([DDUserSingleton shareInstance].latitude) {
        TJDeskViewController *deskVC = [[TJDeskViewController alloc] init];
        TJHomeModel *model = (TJHomeModel *)self.dataSource[indexPath.row];
        deskVC.tid = model.table_id;
        [self.navigationController pushViewController:deskVC animated:true];
    } else {
        [self startLocation];
    }
    
}
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
- (void)gotoLogin {
    if (![self isLogin]) {
        TJLoginController *vc = [TJLoginController new];
        vc.phone = @"直接";
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TJRegisterController new]];
        //[TJRegisterController new]

        [self presentViewController:nav animated:true completion:nil];
        [DDUserDefault removeObjectForKey:@"isFirstOpenApp"];
    }

}

- (BOOL)isLogin {
        if (![DDUserDefault objectForKey:@"token"]) {
  
            return false;
        } else
            return true;
}

- (void)publishAction {
    if ([self isLogin]) {
        [self.navigationController pushViewController:[TJPublishController new] animated:YES];
    } else {
        [self gotoLogin];
    }
}

- (void)headerRereshing {
    
}

- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:20];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:20];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
}

- (void)startLocation {
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        } else {
            NSLog(@"location:%@", location);
            [DDUserSingleton shareInstance].latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            [DDUserSingleton shareInstance].longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            [DDUserSingleton shareInstance].city = regeocode.city;
            [DDUserDefault setObject:regeocode.city forKey:@"current_city"];
        }
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}

@end
