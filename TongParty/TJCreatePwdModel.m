//
//  TJCreatePwdModel.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJCreatePwdModel.h"
#import "DDResponseBaseHttp.h"

@implementation TJCreatePwdModel

//- (void)registerUser:(void (^)())success failure:(void (^)(id))failure {
//    [MBProgressHUD showLoading:@"登录中..." toView:KEY_WINDOW];
//    NSLog(@"%@", [self mj_keyValues]);
//    [DDResponseBaseHttp getWithAction:kTJUserRegisterAPI params:[self mj_keyValues] type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
//        [MBProgressHUD hideAllHUDsInView:KEY_WINDOW];
//        if ([result.msg_cn isEqualToString:@"注册成功。"]) {
//            NSDictionary *dict = result.data;
//            [DDUserDefault setObject:dict[@"token"] forKey:@"token"];
//            success();
//        }
//        [MBProgressHUD showMessage:result.msg_cn toView:KEY_WINDOW];
//    } failure:^{
//        [MBProgressHUD hideAllHUDsInView:KEY_WINDOW];
//    }];
//}

@end
