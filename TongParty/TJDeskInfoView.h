//
//  TJDeskInfoView.h
//  TongParty
//
//  Created by tojoin on 2018/4/16.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"

@class TJDeskInfoModel;

typedef void (^NoticeLock)(NSString*);
typedef void (^MemberSelected)(NSInteger);
//typedef void (^MyIndex)(NSInteger);

@interface TJDeskInfoView : TJBaseView

@property (nonatomic, strong) UIButton       *contactBtn;
@property (nonatomic, strong) UIButton       *nextButton;
@property (nonatomic, copy)   NoticeLock     noticeLock;
@property (nonatomic, copy)   MemberSelected memberSelected;
//@property (nonatomic, copy)   MyIndex        myIndex;

- (void)updateWithModel:(TJDeskInfoModel *)model;

@end
