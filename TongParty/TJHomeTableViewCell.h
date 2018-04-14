//
//  TJHomeTableViewCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) YYLabel *nickname;
@property (nonatomic, strong) YYLabel *event;
@property (nonatomic, strong) YYLabel *addr;
@property (nonatomic, strong) YYLabel *distance;
@property (nonatomic, strong) YYLabel *num;

@end
