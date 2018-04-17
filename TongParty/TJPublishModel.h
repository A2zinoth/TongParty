//
//  TJPublishModel.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJPublishModel : NSObject

@property (nonatomic, copy)   NSString        *token;
@property (nonatomic, copy)   NSString        *aid;
@property (nonatomic, copy)   NSString        *title;
@property (nonatomic, copy)   NSString        *place;
@property (nonatomic, copy)   NSString        *begin_time;
@property (nonatomic, copy)   NSString        *average_price;
@property (nonatomic, copy)   NSString        *person_num;
@property (nonatomic, copy)   NSString        *is_heart;
@property (nonatomic, copy)   NSString        *latitude;
@property (nonatomic, copy)   NSString        *longitude;
@property (nonatomic, copy)   NSString        *activity;

- (void)publishWithModel;
- (void)getActivityList:(void(^)(NSArray *))success;

@end
