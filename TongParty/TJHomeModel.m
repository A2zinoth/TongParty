//
//  TJHomeModel.m
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJHomeModel.h"

@implementation TJHomeModel


- (void)requestTableList:(void(^)(id))success failure:(void(^)())failure {
    [DDResponseBaseHttp getWithAction:KTJTableList params:@{@"token":curUser.token, @"latitude":curUser.latitude, @"longitude":curUser.longitude} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            success([TJHomeModel mj_objectArrayWithKeyValuesArray:result.data[@"table"]]);
        } else {
            success(nil);
        }
    } failure:^{
        failure();
    }];
}

@end
