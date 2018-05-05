//
//  TJFollowCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseTableViewCell.h"

@interface TJFollowCell : TJBaseTableViewCell

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *contentL;
@property (nonatomic, strong) UIButton *actionBtn;


// 桌主审核
- (void)updateMasterNotice;
- (void)updateMasterNoticeWith:(NSDictionary *)dic;
- (void)updateBtnTag:(NSInteger)index;

// 我的粉丝
- (void)updateFollowerStatus:(NSString *)isFollow;
// 添加好友
- (void)updateAddFriend:(NSString *)isAdd;
// 我的关注
- (void)updateStatus:(NSString *)isFollow;
// 消息-我的关注
- (void)updateAttentionNotice;
// 消息-新的好友
- (void)updateFriendReq;



@end
