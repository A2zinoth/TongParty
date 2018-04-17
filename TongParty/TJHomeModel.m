//
//  TJHomeModel.m
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJHomeModel.h"

@implementation TJHomeModel


- (void)requestTableList:(void(^)(id))success {
    NSLog(@"%@", [DDUserDefault objectForKey:@"token"]);
    [DDResponseBaseHttp getWithAction:KTJTableList params:@{@"token":[DDUserDefault objectForKey:@"token"], @"latitude":@"40.002581", @"longitude":@"116.487706"} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        success([TJHomeModel mj_objectArrayWithKeyValuesArray:result.data[@"table"]]);
    } failure:^{
        
    }];
}

@end
