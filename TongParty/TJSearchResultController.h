//
//  TJSearchResultController.h
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "BaseViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>


@interface TJSearchResultController : BaseViewController<UISearchResultsUpdating>


@property (nonatomic, copy) void(^suggestionResultBlock)(AMapTip *tip);

@end
