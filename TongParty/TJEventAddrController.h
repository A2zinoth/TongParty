//
//  TJEventAddrController.h
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "BaseViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface TJEventAddrController : BaseViewController

@property (nonatomic, copy) void(^locationAddressSelectBlcok)(AMapTip *Tip);

@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *addrString;

@end
