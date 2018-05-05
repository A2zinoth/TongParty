//
//  TJPublishModel.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJPublishModel.h"
#import "MJExtension.h"

@implementation TJPublishModel

- (void)publishWithModel:(void (^)())success {
    [MBProgressHUD showLoading:@"创建中..." toView:KEY_WINDOW];
    
    [DDResponseBaseHttp getWithAction:kTJCreateTable params:[self mj_keyValues] type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        [MBProgressHUD hideAllHUDsInView:KEY_WINDOW];
        [MBProgressHUD showMessage:result.msg_cn];
        if([result.status isEqualToString:@"success"]) {
            success();
        }
    } failure:^{
        [MBProgressHUD hideAllHUDsInView:KEY_WINDOW];
    }];
}

- (void)getActivityList:(void(^)(NSArray *))success {
    
    [DDResponseBaseHttp getWithAction:KTJActivityList params:@{@"token":curUser.token} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            success(result.data);
        }
    } failure:^{
        
    }];
}

@end
