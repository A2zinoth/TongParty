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

@interface TJDeskInfoController ()

@property (nonatomic, strong) TJDeskInfoView  *infoView;
@property (nonatomic, strong) TJDeskInfoModel *infoModel;

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
        NSLog(@"index:%zd", index);
        [weakSelf requestProfile:index];
    };
}

- (void)requestProfile:(NSInteger)index {
    TJProfileController *profile = [[TJProfileController alloc] init];
    profile.act = _infoModel.member[index][@"uid"];;
    [self.navigationController pushViewController:profile animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
            NSLog(@"加入");
                [DDResponseBaseHttp getWithAction:kTJTableJoin params:@{@"token":curUser.token, @"oid":_infoModel.oid, @"tid":self.tid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
                    [MBProgressHUD showMessage:result.msg_cn];
                } failure:^{
                    
                }];
        }
            break;
        case 1215:{ //桌主
            NSLog(@"桌主");
            [self masterSign];
        }
            break;
        case 1216:{ //玩家
            NSLog(@"玩家");
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
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 桐聚] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (TJDeskInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[TJDeskInfoView alloc] init];
    }
    return _infoView;
}


@end
