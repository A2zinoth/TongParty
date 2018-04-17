//
//  TJPeopleNum.h
//  TongParty
//
//  Created by tojoin on 2018/4/12.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"
#import "TJSlider.h"

//typedef void (^Complete)(NSString *);

@interface TJPeopleNum : TJBaseView
@property (nonatomic, strong) UIView        *maskView;
@property (nonatomic, strong) TJSlider      *slider;
@property (nonatomic, strong) UILabel       *peopleNum;

@end
