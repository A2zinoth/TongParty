//
//  TJHomeModel.h
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJHomeModel : NSObject

@property (nonatomic, copy) NSString *activity_name;
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *current_num;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *head_image;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *person_num;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *table_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uid;

- (void)requestTableList:(void(^)(id))success failure:(void(^)())failure;


@end
