//
//  TJThemeModel.h
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJThemeModel : TJBaseModel

@property (nonatomic, copy) NSString *activity_id;
@property (nonatomic, copy) NSString *activity_name;
@property (nonatomic, copy) NSString *activiy_image;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *is_hot;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, strong) NSArray<TJThemeModel *> *child;


@end
