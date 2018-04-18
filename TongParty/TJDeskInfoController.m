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
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDictionary *dic = @{
                          @"token":[DDUserDefault objectForKey:@"token"],
                          @"tid":self.tid,
                          @"latitude":[DDUserSingleton shareInstance].latitude,
                          @"longitude":[DDUserSingleton shareInstance].longitude
                          };
    
    WeakSelf(weakSelf);
    [_infoModel getTableInfoWithPara:dic success:^(NSObject *data) {
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
            if ([DDUserDefault objectForKey:@"masterID"]) {
                [DDResponseBaseHttp getWithAction:kTJTableJoin params:@{@"token":[DDUserDefault objectForKey:@"token"], @"oid":[DDUserDefault objectForKey:@"masterID"], @"tid":self.tid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
                    if ([result.status isEqualToString:@"success"]) {
                        [MBProgressHUD showMessage:@"申请成功"];
                    }
                } failure:^{
                    
                }];
            }
        }
            break;
        case 1215:{ //桌主
            NSLog(@"桌主");
            [self.navigationController pushViewController:[TJQRViewController new] animated:true];
        }
            break;
        case 1216:{ //玩家
            NSLog(@"玩家");
            [self QRCodeScanVC:[TJQRScanViewController new]];
        }
            break;
        default:
            break;
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
