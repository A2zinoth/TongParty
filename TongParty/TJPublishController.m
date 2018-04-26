//
//  TJPublishController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJPublishController.h"
#import "TJPublishView.h"
#import "TJPublishModel.h"
#import "TJPublishTableViewCell.h"
#import "TJEventView.h"
#import "TJThemeView.h"
#import "TJDatePicker.h"
#import "TJPeopleNum.h"
#import "TJAverage.h"
#import "TJEventAddrController.h"
#import "TJThemeModel.h"

#import "DDLocationAddressVC.h"

@interface TJPublishController ()<AMapLocationManagerDelegate>

@property (nonatomic, strong) TJPublishView  *publishView;
@property (nonatomic, strong) TJPublishModel *publishModel;

@property (nonatomic, strong) TJEventView    *eventView;
@property (nonatomic, strong) TJThemeView    *themeView;
@property (nonatomic, strong) TJDatePicker   *datePicker;
@property (nonatomic, strong) TJPeopleNum    *peopleNum;
@property (nonatomic, strong) TJAverage      *average;
@property (nonatomic, strong) TJThemeModel   *themeModel;

@property (nonatomic, strong) AMapLocationManager *locationManager;


@end

@implementation TJPublishController
- (void)createData {
    self.dataSource = @[@{@"title":@"活动描述",@"pic":@"TJCreteDesk_0"},
                        @{@"title":@"选择主题",@"pic":@"TJCreteDesk_1"},
                        @{@"title":@"选择时间",@"pic":@"TJCreteDesk_2"},
                        @{@"title":@"活动地点",@"pic":@"TJCreteDesk_3"},
                        @{@"title":@"活动人数",@"pic":@"TJCreteDesk_4"},
                        @{@"title":@"预估人均",@"pic":@"TJCreteDesk_5"},
                        @{@"title":@"是否加入心跳桌", @"pic":@"TJCreteDesk_6"}];
    
    _publishModel = [[TJPublishModel alloc] init];
    NSString *str = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]/3600];
//
    _publishModel = [_publishModel mj_setKeyValues:@{@"token":curUser.token,
                                                     @"title":@"狼人杀到黎明",
                                                     @"aid":@"29",
                                                     @"place":@"北京市朝阳区望京 SOHO",
                                                     @"begin_time":[NSString stringWithFormat:@"%zd",[str integerValue]*3600],
                                                     @"average_price":@"200",
                                                     @"person_num":@"2",
                                                     @"is_heart":@"0",
                                                     @"latitude":@"40.002581",
                                                     @"longitude":@"116.487706",
                                                     @"activity":@"狼人杀"
                                     }];
    
    [self configLocationManager];
}


- (void)createUI {
    _publishView = [[TJPublishView alloc] init];
    [self.view addSubview:_publishView];
    [_publishView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    [_publishView.cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_publishView.okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(72);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.mas_equalTo(self.view).offset(92);
            make.bottom.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        CLLocationCoordinate2D coordinate=location.coordinate;
        self.publishModel.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        self.publishModel.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            self.publishModel.place = [NSString stringWithFormat:@"%@%@%@", regeocode.city, regeocode.district,regeocode.AOIName];
            //            self.publishModel.place = regeocode.formattedAddress;
            [self.tableView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.locationManager startUpdatingLocation];
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.locationManager stopUpdatingLocation];
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
    TJPublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJPublishTableViewCellID"];
    if (!cell) {
        cell = [[TJPublishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJPublishTableViewCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell updateDataWithDic:self.dataSource[indexPath.row]];
    [cell updateDataWithRow:indexPath.row model:_publishModel];

    if (indexPath.row == 6) {
        [cell.switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf(weakSelf);
    if (indexPath.row == 0) {
        [self.view addSubview:self.eventView];
        [_eventView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
        }];
        _eventView.complete = ^(NSString *input) {
            if (input.length) {
                weakSelf.publishModel.title = input;
                [weakSelf.tableView reloadData];
            }
        };
        [_eventView.inputTF becomeFirstResponder];
    } else if (indexPath.row == 1) {
        [self.view addSubview:self.themeView];
        [_themeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            if (@available(ios 11.0,*)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(449);
        }];
        
        // 返回主题 id
        _themeView.complete = ^(NSString *input) {
            if (input.length) {
                weakSelf.publishModel.aid = input;
            }
        };
        
        // 返回主题名称
        _themeView.themeNameBlock = ^(NSString *themeName) {
            if (themeName) {
                weakSelf.publishModel.activity = themeName;
                [weakSelf.tableView reloadData];
            }
        };
        
        // 获取主题
        [self.publishModel getActivityList:^(NSArray *dataArr) {
            NSArray *array = [TJThemeModel mj_objectArrayWithKeyValuesArray:dataArr];
            [weakSelf.themeView updateData:array];
//            [weakSelf.tableView reloadData];
        }];
    } else if (indexPath.row == 2) {
        [self.view addSubview:self.datePicker];
        [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0,*)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(244);
        }];
        _datePicker.complete = ^(NSString *time) {
            weakSelf.publishModel.begin_time = time;
            [weakSelf.tableView reloadData];
        };
    } else if (indexPath.row == 3) {
        // 地图选择地点
        DDLocationAddressVC *locationVC   = [[DDLocationAddressVC alloc] init];
        locationVC.locationAddressSelectBlcok = ^(AMapPOI *POI) {
            weakSelf.publishModel.place = [NSString stringWithFormat:@"%@%@%@", POI.city, POI.district,POI.name];
            weakSelf.publishModel.latitude = [NSString stringWithFormat:@"%lf",POI.location.latitude];
            weakSelf.publishModel.longitude =[NSString stringWithFormat:@"%lf",POI.location.longitude];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:locationVC animated:YES];
    } else if (indexPath.row == 4) {
        // 禁用返回手势
        [self setPopGestureEnable:NO];
        [self.view addSubview:self.peopleNum];
        [_peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0,*)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(167);
        }];
        _peopleNum.complete = ^(NSString *peopleNum) {
            [weakSelf setPopGestureEnable:true];
            weakSelf.publishModel.person_num = peopleNum ;
            [weakSelf.tableView reloadData];
            NSLog(@"%@", peopleNum);
        };
        
        _peopleNum.cancel = ^{
            [weakSelf setPopGestureEnable:true];
        };
    } else if (indexPath.row == 5) {
        // 禁用返回手势
        [self setPopGestureEnable:false];
        
        [self.view addSubview:self.average];
        [_average mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0,*)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(167);
        }];
        _average.complete = ^(NSString *average) {
            [weakSelf setPopGestureEnable:true];
            
            weakSelf.publishModel.average_price = average;
            [weakSelf.tableView reloadData];
            NSLog(@"%@", average);
        };
        
        _average.cancel = ^{
            [weakSelf setPopGestureEnable:true];
        };
    }
}



- (void)enumrateSubviewsInView:(UIView *)view {
    
    NSArray *subViews = view.subviews;
    if (subViews.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < subViews.count; i++) {
        UIView *subView = subViews[i];
        [self enumrateSubviewsInView:subView];
        
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            if ([label.attributedText.string isEqualToString:@"心跳桌会直接帮您匹配空闲桌位\n是否确定创建心跳桌"]) {
                label.textAlignment = NSTextAlignmentCenter;
            }
        }
    }
}

-(void)switchAction:(id)sender {
    WeakSelf(weakSelf);
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        
        NSAttributedString *attrStr = [DDUtils attStringWithString:@"心跳桌会直接帮您匹配空闲桌位\n是否确定创建心跳桌" keyWord:@"" font:[UIFont systemFontOfSize:13] highlightedColor:nil textColor:[UIColor hx_colorWithHexString:@"#262626"]];
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertControl setValue:attrStr forKey:@"attributedMessage"];
        [self enumrateSubviewsInView:alertControl.view];
        
        UIAlertAction *alertCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            switchButton.on = false;
            weakSelf.publishModel.is_heart = @"0";
            NSLog(@"撤！");
        }];
        UIAlertAction *alertAlbum = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.publishModel.is_heart = @"1";
        }];
        
        [alertControl addAction:alertCancle];
        [alertControl addAction:alertAlbum];
        [alertCancle setValue:[UIColor hx_colorWithHexString:@"#BDC9D4"] forKey:@"titleTextColor"];
        [self presentViewController:alertControl animated:YES completion:nil];
        NSLog(@"开");
        self.publishModel.is_heart = @"1";
    }else {
        NSLog(@"关");
        self.publishModel.is_heart = @"0";
    }
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {

}

- (void)setPopGestureEnable:(BOOL)b {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = b;
    }
}


- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)okAction {
    // 发布
    [_publishModel publishWithModel];
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


- (TJThemeModel *)themeModel {
    if (!_themeModel) {
        _themeModel = [[TJThemeModel alloc] init];
    }
    return _themeModel;
}


- (TJAverage *)average {
    if (!_average) {
        _average = [[TJAverage alloc] init];
    }
    return _average;
}

- (TJPeopleNum *)peopleNum {
    if (!_peopleNum) {
        _peopleNum = [[TJPeopleNum alloc] init];
    }
    return _peopleNum;
}

- (TJDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[TJDatePicker alloc] init];
    }
    return _datePicker;
}

- (TJThemeView *)themeView {
    if (!_themeView) {
        _themeView = [[TJThemeView alloc] init];
    }
    return _themeView;
}

- (TJEventView *)eventView {
    if (!_eventView) {
        _eventView = [[TJEventView alloc] init];
    }
    return _eventView;
}

@end
