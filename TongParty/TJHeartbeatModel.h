//
//  TJHeartbeatModel.h
//  TongParty
//
//  Created by tojoin on 2018/4/19.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJHeartbeatModel : TJBaseModel

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *begin_time;
@property (nonatomic, copy) NSString *average_price;
@property (nonatomic, copy) NSString *range;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;


@end
