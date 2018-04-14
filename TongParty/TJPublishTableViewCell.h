//
//  TJPublishTableViewCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJPublishTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView    *headImageView;
@property (nonatomic, strong) YYLabel        *titleLabel;

- (void)updateDataWithDic:(NSDictionary *)dic;
- (void)updateDataWithRow:(NSInteger)row model:(NSObject *)model;
@end
