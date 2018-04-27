//
//  TJFollowCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJFollowCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *contentL;
@property (nonatomic, strong) UIButton *actionBtn;

- (void)updateMasterNotice;

- (void)updateMasterNoticeWith:(NSDictionary *)dic;

- (void)updateBtnTag:(NSInteger)index;

@end
