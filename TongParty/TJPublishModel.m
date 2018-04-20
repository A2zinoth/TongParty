//
//  TJPublishModel.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJPublishModel.h"


@implementation TJPublishModel

- (void)publishWithModel {
    [MBProgressHUD showLoading:@"创建中..." toView:KEY_WINDOW];
    NSLog(@"%@", [self mj_keyValues]);
    
    [DDResponseBaseHttp getWithAction:kTJCreateTable params:[self mj_keyValues] type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
    } failure:^{
        
    }];
}

- (void)getActivityList:(void(^)(NSArray *))success {
    
    [DDResponseBaseHttp getWithAction:KTJActivityList params:@{@"token":[DDUserDefault objectForKey:@"token"]} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            success(result.data);
        }
    } failure:^{
        
    }];
}

@end
