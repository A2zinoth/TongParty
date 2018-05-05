//
//  DDTabbarViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTabbarViewController.h"
#import "PlusAnimate.h"
#import "TJHomeController.h"
#import "TJHeartbeatController.h"
#import "TJProfileController.h"
#import "DDNavViewController.h"


@interface DDTabbarViewController ()<CYTabBarDelegate>
@end

@implementation DDTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [CYTabBarConfig shared].selectedTextColor = kBtnEnable;
    [CYTabBarConfig shared].textColor = [UIColor hx_colorWithHexString:@"#9E9E9E"];
    [CYTabBarConfig shared].backgroundColor = [UIColor whiteColor];
    [CYTabBarConfig shared].selectIndex = 0 ;
    [CYTabBarConfig shared].centerBtnIndex = 2;
    // 设置子控制器
    //---------------- 首页 ---------------
    DDNavViewController *nav1 = [[DDNavViewController alloc]initWithRootViewController:[TJHomeController new]];
    [self addChildController:nav1 title:@"首页" imageName:@"TJHomeBar" selectedImageName:@"TJHomeBar_selected"];
    //---------------- 心跳桌 ---------------
    DDNavViewController *nav2 = [[DDNavViewController alloc]initWithRootViewController:[TJHeartbeatController new]];
    [self addChildController:nav2 title:@"心跳桌" imageName:@"TJHeartBeat" selectedImageName:@"TJHeartBeat_selected"];
    //---------------- 我的 ---------------
    DDNavViewController *nav3 = [[DDNavViewController alloc]initWithRootViewController:[TJProfileController new]];
    [self addChildController:nav3 title:@"我的" imageName:@"TJProfile" selectedImageName:@"TJProfile_selected"];
    
//    // 设置子控制器
//    //---------------- 首页 ---------------
//    DDNavViewController *nav1 = [[DDNavViewController alloc]initWithRootViewController:[DDHomeMainVC new]];
//    [self addChildController:nav1 title:@"首页" imageName:@"tab_sy_default" selectedImageName:@"tab_sy_selected"];
//    //---------------- 桌子 ---------------
//    DDNavViewController *nav2 = [[DDNavViewController alloc]initWithRootViewController:[DDDeskViewController new]];
//    [self addChildController:nav2 title:@"桌子" imageName:@"tab_zb_default" selectedImageName:@"tab_zb_selected"];
//    //---------------- 发现 ---------------
//    DDNavViewController *nav3 = [[DDNavViewController alloc]initWithRootViewController:[DDDiscoverViewController new]];
//    [self addChildController:nav3 title:@"发现" imageName:@"tab_fw_default" selectedImageName:@"tab_fw_selected"];
//    //---------------- 个人 ---------------
//    DDNavViewController   *nav4 = [[DDNavViewController alloc]initWithRootViewController:[DDUsercenterVc new]];
//    [self addChildController:nav4 title:@"我的" imageName:@"tab_sq_default" selectedImageName:@"tab_sq_selected"];
//    //---------------- 中间凸出 ---------------
//    [self addCenterController:nil bulge:YES title:nil imageName:@"tabbar_center" selectedImageName:@"tabbar_center"];
//
//    // 监听中间按钮弹出视图子按钮点击事件
//    [kNotificationCenter addObserver:self selector:@selector(didSelectBtnWithBtnTag:) name:@"centerPopAction" object:nil];

    self.tabbar.delegate = self;
}

//- (void)toLogin {
//    DDLoginViewController *loginVC = [[DDLoginViewController alloc] init];
//    loginVC.isModen = YES;
//    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    loginVC.islogSuccess = ^(BOOL isSuccess) {
//        if (isSuccess) {
//
//        }
//    };
//    [self presentViewController:nv animated:YES completion:^{}];
//}


//- (void)didSelectBtnWithBtnTag:(NSNotification *)notification {
//    UIButton *btn = (UIButton *)notification.object;
//    
//        if (![DDUserDefault objectForKey:@"token"]){
//            [self toLogin];
//            return;
//        }
////    //判断资料是否完善，如果没有完善则
//    if (![DDUserSingleton shareInstance].image || [[DDUserSingleton shareInstance].image isEqualToString:@""] || ![DDUserSingleton shareInstance].name || [[DDUserSingleton shareInstance].name isEqualToString:@""] || ![DDUserSingleton shareInstance].sex || [[DDUserSingleton shareInstance].sex isEqualToString:@""]) {
//
//        //判断资料是否完善，如果没有完善则
//        DDPrefectDataVC *dataVC = [[DDPrefectDataVC alloc] init];
//        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:dataVC];
//        dataVC.isModen = YES;
//        [self presentViewController:nv animated:YES completion:^{}];
//        return;
//    }
//    switch (btn.tag) {
//        case 0:{
//            DDNavViewController   *nav = [[DDNavViewController alloc]initWithRootViewController:[LSCreateDeskViewController new]];
//            [self presentViewController:nav animated:YES completion:nil];
//        }break;
//        case 1:{
//            
//            DDNavViewController   *nav = [[DDNavViewController alloc]initWithRootViewController:[DDLoveDeskViewController new]];
//            [self presentViewController:nav animated:YES completion:nil];
//        }break;
//        default:
//            break;
//    }
//}
#pragma mark - CYTabBarDelegate
//中间按钮点击
- (void)tabbar:(CYTabBar *)tabbar clickForCenterButton:(CYCenterButton *)centerButton{
    [PlusAnimate standardPublishAnimateWithView:centerButton];
}
//是否允许切换
- (BOOL)tabBar:(CYTabBar *)tabBar willSelectIndex:(NSInteger)index{
//    NSLog(@"将要切换到---> %ld",(long)index);
    return YES;
}
//通知切换的下标
- (void)tabBar:(CYTabBar *)tabBar didSelectIndex:(NSInteger)index{
//    NSLog(@"切换到---> %ld",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

