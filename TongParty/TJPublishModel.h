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
@property (nonatomic, assign) NSInteger       aid;
@property (nonatomic, copy)   NSString        *title;
@property (nonatomic, copy)   NSString        *place;
@property (nonatomic, assign) NSTimeInterval  *begin_time;
@property (nonatomic, assign) float           *average_num;
@property (nonatomic, assign) NSInteger       *person_num;
@property (nonatomic, assign) short           *is_heart;
@property (nonatomic, assign) float           *latitude;
@property (nonatomic, assign) float           *longitude;

@end
