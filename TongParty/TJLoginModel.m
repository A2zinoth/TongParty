//
//  TJLoginModel.m
//  Tojoin
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 Beijing Tojoin Network Technology Co., Ltd. All rights reserved.
//

#import "TJLoginModel.h"

#import <UMSocialCore/UMSocialCore.h>

@implementation TJLoginModel

- (void)login:(void (^)(void))success {

    [self.loginManager loginWithUsername:_mobile password:_password block:^(NSDictionary *dict) {
        success();
    } failure:^{
    }];
}
#pragma  mark - 第三方登录
- (void)thirdLogin:(NSInteger)sender {
    switch ((sender-10)) {
        case 0:
        {
            //微博登录
            [self weiboLogin];
        }
            break;
        case 1:
        {
            //微信登录
            [self wxLogin];
        }break;
        case 2:
        {
         
            //QQ登录
            [self QQLogin];
        }break;
        default:
            break;
    }
}

#pragma mark - 微信登录
-(void)wxLogin{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            [self otherLoginWithOpenID:resp.openid act:@"wx" imageURL:resp.iconurl];
        }
    }];
}
#pragma mark - QQ登录
-(void)QQLogin{
    /**
     设置QQ授权登录
     
     @param platformType 平台
     @param result 授权成功
     @param error 授权失败
     */
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            [self otherLoginWithOpenID:resp.openid act:@"qq" imageURL:resp.iconurl];
        }
    }];
}
#pragma mark - 微博登录
- (void)weiboLogin{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        [self otherLoginWithOpenID:resp.openid act:@"wb" imageURL:resp.iconurl];
    }];
}

- (DDLoginManager *)loginManager {
    if(!_loginManager) {
        _loginManager = [[DDLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

- (void)otherLoginWithOpenID:(NSString *)openID act:(NSString *)act imageURL:(NSString *)imageURL {
    kWeakSelf
    [MBProgressHUD showLoading:@"登录中..." toView:KEY_WINDOW];
    [DDResponseBaseHttp getWithAction:kTJOtherLogin params:@{@"open_id":openID, @"act":act, @"image_url":imageURL} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        [MBProgressHUD hideAllHUDsInView:KEY_WINDOW];
        if ([result.status isEqualToString:@"success"]) {
            [DDUserDefault setObject:result.data[@"token"] forKey:@"token"];
            [DDUserSingleton shareInstance].image = result.data[@"head_image"];
            weakSelf.thirdLoginSuccess();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:KEY_WINDOW];
    } failure:^{
        [MBProgressHUD hideAllHUDsInView:KEY_WINDOW];
    }];
}



@end
