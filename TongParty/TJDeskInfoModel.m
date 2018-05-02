//
//  TJDeskInfoModel.m
//  TongParty
//
//  Created by tojoin on 2018/4/16.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskInfoModel.h"

@implementation TJDeskInfoModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"my" : @"TJDeskInfoMy",
             };
}

- (void)getTableInfoWithPara:(NSDictionary *)dic success:(void(^)(id ))success {
    [DDResponseBaseHttp getWithAction:kTJTableInfo params:dic type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            success([TJDeskInfoModel mj_objectWithKeyValues:result.data]);
        } else
            [MBProgressHUD showMessage:result.msg_cn];
    } failure:^{
    }];
}

@end


@implementation TJDeskInfoMy
@end
