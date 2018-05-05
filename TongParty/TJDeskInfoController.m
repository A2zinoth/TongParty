//
//  TJDeskInfoController.m
//  TongParty
//
//  Created by tojoin on 2018/4/15.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskInfoController.h"
#import "TJDeskInfoView.h"
#import "TJDeskInfoModel.h"
#import "TJQRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TJQRScanViewController.h"
#import "TJProfileController.h"
#import "ZLLAuthorizationCheckTool.h"

@interface TJDeskInfoController ()


@property (nonatomic, strong) TJDeskInfoView  *infoView;
@property (nonatomic, strong) TJDeskInfoModel *infoModel;
@property (nonatomic, assign) __block NSInteger  myIndex;

@end

@implementation TJDeskInfoController



- (void)createUI {
    
    [self.view addSubview:self.infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    kWeakSelf
    _infoView.noticeLock = ^(NSString *bLock) {
        weakSelf.noticeLock(bLock);
    };
    
    _infoModel = [[TJDeskInfoModel alloc] init];
    [_infoView.nextButton addTarget:self action:@selector(joinAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _infoView.memberSelected = ^(NSInteger index) {
        [weakSelf requestProfile:index];
    };
//    _infoView.myIndex = ^(NSInteger index) {
//        _myIndex = index;
//    };ui
    [_infoView.contactBtn addTarget:self action:@selector(contactBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)requestProfile:(NSInteger)index {
    TJProfileController *profile = [[TJProfileController alloc] init];
//    if (index == _myIndex) {
//        profile.act = @"DeskInfo";
//    } else {
        profile.act = _infoModel.member[index][@"uid"];;
//    }
    [self.navigationController pushViewController:profile animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    _myIndex = -1;
    NSDictionary *dic = @{
                          @"token":curUser.token,
                          @"tid":self.tid,
                          @"latitude":curUser.latitude,
                          @"longitude":curUser.longitude
                          };
    
    WeakSelf(weakSelf);
    [_infoModel getTableInfoWithPara:dic success:^(NSObject *data) {
        weakSelf.infoModel = (TJDeskInfoModel*)data;
        [weakSelf.infoView updateWithModel:(TJDeskInfoModel*)data];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)joinAction:(UIButton *)btn {
    switch (btn.tag) {
        case 1214:{ //加入
            [DDResponseBaseHttp getWithAction:kTJTableJoin params:@{@"token":curUser.token, @"oid":_infoModel.oid, @"tid":self.tid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
                [MBProgressHUD showMessage:result.msg_cn];
            } failure:^{
            }];
        }
            break;
        case 1215:{ //桌主
            [self masterSign];
        }
            break;
        case 1216:{ //玩家

            TJQRScanViewController *scanVC = [[TJQRScanViewController alloc] init];
            scanVC.tid = self.tid;
            scanVC.oid = _infoModel.oid;
            [self QRCodeScanVC:scanVC];
        }
            break;
        default:
            break;
    }
}

- (void)masterSign {
    kWeakSelf
    if([_infoView.nextButton.titleLabel.text isEqualToString:@"签到"]) {
        [DDResponseBaseHttp getWithAction:kTJTableMasterSign params:@{@"token":curUser.token, @"latitude":curUser.latitude, @"longitude":curUser.longitude, @"tid":self.tid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            if ([result.status isEqualToString:@"success"]) {
                [weakSelf.infoView.nextButton setTitle:@"签到二维码" forState:UIControlStateNormal];
                [weakSelf.infoView.nextButton setBackgroundColor:kBtnEnable];
                weakSelf.infoView.nextButton.enabled = true;
            }
            [MBProgressHUD showMessage:result.msg_cn];
        } failure:^{
        }];
    } else {
        [DDResponseBaseHttp getWithAction:kTJTableQRCode params:@{@"token":curUser.token, @"tid":self.tid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            if ([result.status isEqualToString:@"success"]) {
                TJQRViewController *qrVC = [[TJQRViewController alloc] init];
                qrVC.tid = self.tid;
                [self.navigationController pushViewController:qrVC animated:true];
            } else  {
                [MBProgressHUD showMessage:result.msg_cn];
            }
        } failure:^{
        }];
    }
    
    
}


- (void)QRCodeScanVC:(UIViewController *)scanVC {
    [ZLLAuthorizationCheckTool availablecheckAccessForCamera:true presentingVC:self jumpSettering:true alertNotAvailable:true resultBlock:^(BOOL isAvailable, ZLLAuthorizationStatus status) {
        if (isAvailable) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:scanVC animated:YES];
            });
        }
    }];
}

- (void)contactBtn {
    if (_infoModel.mobile == nil || _infoModel.mobile == NULL) {
        [MBProgressHUD showError:@"桌主的联系方式为空" toView:self.view];
    }else{
        
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", _infoModel.mobile];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
//        [self alertWithTitle:@"提示" message:@"是否联系桌主？" style:UIAlertControllerStyleAlert cancel:^{
//
//        } ok:^{
//            // telprompt://  iOS10显示手机号 回到应用
//            // tel:         // 直接拨打  回到应用
//
//
//        }];
        
//        NSString *mobilestr=[[NSMutableString alloc] initWithFormat:@"tel:%@",_infoModel.mobile];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobilestr]];
    }
}

- (TJDeskInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[TJDeskInfoView alloc] init];
    }
    return _infoView;
}


@end
