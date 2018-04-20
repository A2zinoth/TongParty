//
//  TJHeartbeatController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJHeartbeatController.h"
#import "TJHeartbeatView.h"
#import "TJHeartbeatModel.h"
#import "TJThemeView.h"
#import "TJHomeModel.h"
#import "TJPublishModel.h"
#import "TJDistanceView.h"
#import "TJDatePicker.h"
#import "TJAverage.h"
#import "TJMatchController.h"
#import "TJAnimation.h"

@interface TJHeartbeatController ()

@property (nonatomic, strong) TJHeartbeatView  *heartbeatView;
@property (nonatomic, strong) TJHeartbeatModel *heartbeatModel;

@property (nonatomic, strong) TJPublishModel *publishModel;
@property (nonatomic, strong) TJThemeView    *themeView;
@property (nonatomic, strong) TJDistanceView *distance;
@property (nonatomic, strong) TJDatePicker   *datePicker;
@property (nonatomic, strong) TJAverage      *average;


@end

@implementation TJHeartbeatController
- (void)createData {
    _heartbeatModel = [[TJHeartbeatModel alloc] init];
    _heartbeatModel.token = [DDUserDefault objectForKey:@"token"];
    _heartbeatModel.latitude = [DDUserSingleton shareInstance].latitude;
    _heartbeatModel.longitude = [DDUserSingleton shareInstance].longitude;
    _heartbeatModel.aid = @"29";
    _heartbeatModel.range = @"15000";
    NSString *str = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]/3600];
    _heartbeatModel.begin_time = [NSString stringWithFormat:@"%zd",[str integerValue]*3600];
    _heartbeatModel.average_price = @"200";
    
}

- (void)createUI {
    _heartbeatView = [[TJHeartbeatView alloc] init];
    [self.view addSubview:_heartbeatView];
    [_heartbeatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    kWeakSelf
    _heartbeatView.buttonBlick = ^(NSInteger tag) {
        [weakSelf getFilterWithTag:tag];
    };
    
    [_heartbeatView.startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _publishModel = [[TJPublishModel alloc] init];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getFilterWithTag:(NSUInteger)tag {
    kWeakSelf
    switch (tag) {
        case 1156:// 主题
        {
            [self.view addSubview:self.themeView];
            [_themeView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (@available(ios 11.0,*)) {
                    make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                } else {
                    make.bottom.mas_equalTo(0);
                }
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(449);
            }];
            
            // 返回主题 id
            
            _themeView.complete = ^(NSString *input) {
                if (input.length) {
                    weakSelf.heartbeatModel.aid = input;
                }
            };
            
            // 返回主题名称
            _themeView.themeNameBlock = ^(NSString *themeName) {
                if (themeName) {
                    UIButton *button = [weakSelf.heartbeatView viewWithTag:1156];
                    [button setTitle:themeName forState:UIControlStateNormal];
                }
            };
            
            // 获取主题
            [self.publishModel getActivityList:^(NSArray *dataArr) {
                NSArray *array = [TJThemeModel mj_objectArrayWithKeyValuesArray:dataArr];
                [weakSelf.themeView updateData:array];
            }];
        }
            break;
        case 1157:
        {
            [self.view addSubview:self.distance];
            [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
                if (@available(ios 11.0,*)) {
                    make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
                } else {
                    make.bottom.mas_equalTo(0);
                }
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(167);
            }];
            _distance.complete = ^(NSString *distance) {
                weakSelf.heartbeatModel.range = [distance stringByAppendingString:@"000"];
                UIButton *button = [weakSelf.heartbeatView viewWithTag:1157];
                [button setTitle:[NSString stringWithFormat:@"%@KM",distance] forState:UIControlStateNormal];
            };
        }
            break;
        case 1158:
        {
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
                weakSelf.heartbeatModel.begin_time = time;
                
            };
            _datePicker.formatDate = ^(NSString *formatDate) {
                UIButton *button = [weakSelf.heartbeatView viewWithTag:1158];
                [button setTitle:formatDate forState:UIControlStateNormal];
            }; 
        }
            break;
        case 1159:
        {
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
                weakSelf.heartbeatModel.average_price = average;
                UIButton *button = [weakSelf.heartbeatView viewWithTag:1159];
                [button setTitle:[NSString stringWithFormat:@"￥%@/人",average] forState:UIControlStateNormal];
            };
        }
        default:
            break;
    }
}

- (void)startAction:(UIButton *)btn {
    
    if ([DDUserDefault objectForKey:@"token"]) {
        if (btn.selected) {
            [self stopAnimation];
        } else {
            [self startAnimation];
            [DDResponseBaseHttp getWithAction:kTJHeartBeat params:[self.heartbeatModel mj_keyValues] type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
                [self stopAnimation];
                btn.selected = false;
                if ([result.status isEqualToString:@"success"]) {
                    TJMatchController *matchVC = [TJMatchController new];
                    matchVC.data = result.data;
                    [self.navigationController pushViewController:matchVC animated:true];
                } else {
                    [MBProgressHUD showMessage:result.msg_cn toView:KEY_WINDOW];
                }
            } failure:^{
                [self stopAnimation];
                btn.selected = false;
            }];
        }
        btn.selected = !btn.selected;
        
    } else {
        [MBProgressHUD showMessage:@"请登录"];
    }
}

- (void)stopAnimation {
    UILabel *notice = [_heartbeatView viewWithTag:2211];
    UIImageView *filterBackground = [_heartbeatView viewWithTag:1912];
    UIImageView *startIV = [_heartbeatView viewWithTag:1916];
    UILabel *startL = [_heartbeatView viewWithTag:1917];
    notice.text = @"心跳桌会直接帮您匹配空闲桌位，\n一旦匹配成功，将无法退出桌位。";
    filterBackground.hidden = false;
    startIV.hidden = false;
    startL.hidden = false;
}

- (void)startAnimation {
    //    正在为您快速匹配心跳桌…
    UILabel *notice = [_heartbeatView viewWithTag:2211];
    UIImageView *filterBackground = [_heartbeatView viewWithTag:1912];
    UIImageView *startIV = [_heartbeatView viewWithTag:1916];
    UILabel *startL = [_heartbeatView viewWithTag:1917];
    notice.text = @"正在为您快速匹配心跳桌…";
    filterBackground.hidden = true;
    startIV.hidden = true;
    startL.hidden = true;
}


- (TJAverage *)average {
    if (!_average) {
        _average = [[TJAverage alloc] init];
    }
    return _average;
}

- (TJDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[TJDatePicker alloc] init];
    }
    return _datePicker;
}


- (TJDistanceView *)distance {
    if (!_distance) {
        _distance = [[TJDistanceView alloc] init];
    }
    return _distance;
}

- (TJThemeView *)themeView {
    if (!_themeView) {
        _themeView = [[TJThemeView alloc] init];
    }
    return _themeView;
}


@end
