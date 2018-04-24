//
//  TJProfessionModel.h
//  TongParty
//
//  Created by tojoin on 2018/4/23.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJProfessionModel : TJBaseModel


@property (nonatomic, copy)   NSString                      *career_id;
@property (nonatomic, copy)   NSString                      *career_name;
@property (nonatomic, copy)   NSString                      *parent_id;
@property (nonatomic, strong) NSArray<TJProfessionModel *>  *child;

@end
