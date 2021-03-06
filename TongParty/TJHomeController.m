//
//  TJHomeController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJHomeController.h"
#import "TJHomeTableViewCell.h"
#import "TJPublishController.h"
#import "TJRegisterController.h"
#import "TJLoginController.h"
#import "TJCreatePwdController.h"
#import "TJHomeModel.h"
#import "TJDeskViewController.h"
#import "AppDelegate+AppLocation.h"
#import "ZLLAuthorizationCheckTool.h"

@interface TJHomeController ()<AMapLocationManagerDelegate>

@property (nonatomic, strong) TJHomeModel           *homeModel;
@property (nonatomic, strong) AMapLocationManager   *locationManager;

@end

@implementation TJHomeController

- (void)createData {
    _homeModel = [[TJHomeModel alloc] init];
    [self configLocationManager];
}
- (void)createUI {
//    // 城市按钮
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
    cityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
    [cityBtn addTarget:self action:@selector(cityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cityBtn];
    [cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(14);
        } else {
            make.top.mas_equalTo(self.view).offset(34);
        }
        make.left.mas_equalTo(self.view).offset(40);
        make.width.mas_lessThanOrEqualTo(65);
        make.height.mas_equalTo(18);
    }];
    
//    // 首页
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.text = @"首页";
//    titleLabel.font = [UIFont systemFontOfSize:24];
//    [self.view addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (@available(ios 11.0,*)) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(67);
//        } else {
//            make.top.mas_equalTo(self.view).offset(87);
//        }
//        make.left.mas_equalTo(self.view).offset(24);
//        make.size.mas_equalTo(CGSizeMake(50, 34));
//    }];
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = NO;
    self.tableView.mj_header = header;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-kTabBarHeigthOrigin);
        } else {
            make.top.mas_equalTo(self.view).offset(64);
            make.bottom.mas_equalTo(self.view).offset(-kTabBarHeigthOrigin);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
    // 首页
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 23, 50, 34)];
    titleLabel.text = @"首页";
    titleLabel.font = [UIFont systemFontOfSize:24];

    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 78)];
    [tableHeadView addSubview:titleLabel];
    self.tableView.tableHeaderView = tableHeadView;

    
    
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
    
    _publishBtn = [[UIButton alloc] init];
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
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self requestData];
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

- (void)checkLocationAuthorizationStatus:(void(^)())success failure:(void(^)())failure {
    
    [ZLLAuthorizationCheckTool availableAccessForLocationServices:self jumpSettering:true alertNotAvailable:true resultBlock:^(BOOL isAvailable, ZLLAuthorizationStatus status) {
        if (isAvailable) {
            success();
        } else {
            failure();
        }
    }];
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"打开[定位服务]来允许桐聚确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        }];
//
//        [ac addAction:cancel];
//        [ac addAction:ok];
//
//        [self presentViewController:ac animated:true completion:nil];
//        return false;
//    }
//    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self checkLocationAuthorizationStatus:^{
        if (curUser.latitude) {
            TJDeskViewController *deskVC = [[TJDeskViewController alloc] init];
            TJHomeModel *model = (TJHomeModel *)self.dataSource[indexPath.row];
            deskVC.tid = model.table_id;
            [self.navigationController pushViewController:deskVC animated:true];
        } else {
            [self startLocation];
        }
    } failure:^{
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 119.0;
}

- (void)gotoLogin {
    TJLoginController *vc = [TJLoginController new];
    vc.phone = @"直接";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:true completion:nil];
}

- (BOOL)isLogin {
    if (!bLogined) {
        return false;
    } else
        return true;
}


- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
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
            curUser.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            curUser.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            curUser.city = regeocode.city;
            curUser.district = regeocode.district;
            curUser.AOIName = regeocode.AOIName;
            [userManager saveUserInfo];
        }

        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}

- (void)requestData {
    WeakSelf(weakSelf);
    
    if (curUser.token) {
//        if ([self checkLocationAuthorizationStatus]) {
        [self checkLocationAuthorizationStatus:^{
            if(curUser.latitude) {
                [_homeModel requestTableList:^(id obj) {
                    if (obj) {
                        weakSelf.dataSource = obj;
                        [weakSelf.tableView reloadData];
                    }
                    
                    [weakSelf.tableView.mj_header endRefreshing];
                } failure:^{
                    [weakSelf.tableView.mj_header endRefreshing];
                }];
            } else {
                [self.tableView.mj_header endRefreshing];
                [self startLocation];
            }
        } failure:^{
            
        }];
        
//        }
    } else {
        [self gotoLogin];
    }
}

- (void)headerRereshing {
    [self requestData];
}

- (void)publishAction {
    kWeakSelf
    if ([self isLogin]) {
        [self checkLocationAuthorizationStatus:^ {
            if(curUser.latitude) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:[TJPublishController new] animated:YES];
                });
            } else {
                [MBProgressHUD showMessage:@"正在获取位置..."];
                [weakSelf startLocation];
            }
        } failure:^ {
        }];
    } else {
        [self gotoLogin];
    }
}



- (void)cityAction {
#if DEBUG
    [userManager logout:^(BOOL success, NSString *des) {
        
    }];
#endif
}


@end
