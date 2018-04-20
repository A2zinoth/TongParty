//
//  TJDeskInfoModel.h
//  TongParty
//
//  Created by tojoin on 2018/4/16.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJDeskInfoModel : TJBaseModel


@property (nonatomic, copy)   NSString        *table_id;
@property (nonatomic, copy)   NSString        *oid;
@property (nonatomic, copy)   NSString        *aid;
@property (nonatomic, copy)   NSString        *title;
@property (nonatomic, copy)   NSString        *place;
@property (nonatomic, copy)   NSString        *begin_time;
@property (nonatomic, copy)   NSString        *average_price;
@property (nonatomic, copy)   NSString        *person_num;
@property (nonatomic, copy)   NSString        *current_num;
@property (nonatomic, copy)   NSString        *latitude;
@property (nonatomic, copy)   NSString        *longitude;
@property (nonatomic, copy)   NSString        *distance;
@property (nonatomic, copy)   NSString        *activity_name;
@property (nonatomic, copy)   NSString        *mobile;
@property (nonatomic, copy)   NSString        *serviceTime;
@property (nonatomic, strong) NSArray         *member;
@property (nonatomic, strong) NSDictionary    *my;

- (void)getTableInfoWithPara:(NSDictionary *)dic success:(void(^)(id ))success;

@end
