//
//  TJDeskNoticeController.h
//  TongParty
//
//  Created by tojoin on 2018/4/15.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "BaseViewController.h"

@interface TJDeskNoticeController : BaseViewController


@property (nonatomic, strong) NSString *tid; //桌子 id

- (void)closeKeyBoard;
- (void)requestNotice;
- (void)updateAuthority;

@end
