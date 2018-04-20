//
//  TJHeartbeatView.h
//  TongParty
//
//  Created by tojoin on 2018/4/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"


typedef void (^ButtonBlock)(NSInteger);

@interface TJHeartbeatView : TJBaseView

@property (nonatomic, copy)   ButtonBlock    buttonBlick;
@property (nonatomic, strong) UIButton       *startBtn;

@property (nonatomic, strong)  CALayer *startLayer;

@end
