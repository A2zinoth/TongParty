//
//  TJDeskNoticeCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/17.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJDeskNoticeCell : UITableViewCell

@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *time;

- (void)updateWithDataArr:(NSArray *)arr;

@end
