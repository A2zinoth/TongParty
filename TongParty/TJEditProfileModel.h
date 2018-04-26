//
//  TJEditProfileModel.h
//  TongParty
//
//  Created by tojoin on 2018/4/23.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJEditProfileModel : TJBaseModel

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *profession;
@property (nonatomic, copy) NSString *head_image;


@end
