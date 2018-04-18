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

@interface TJDeskInfoView : TJBaseView

@property (nonatomic, strong) UIButton      *contactBtn;
@property (nonatomic, strong) UIButton      *nextButton;
@property (nonatomic, strong) NoticeLock    noticeLock;

- (void)updateWithModel:(TJDeskInfoModel *)model;

@end
