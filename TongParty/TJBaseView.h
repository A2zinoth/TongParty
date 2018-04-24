//
//  BaseView.h
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Complete)(NSString *);
typedef void (^Cancel) ();

@interface TJBaseView : UIView

@property (nonatomic, copy) Complete complete;
@property (nonatomic, copy) Cancel   cancel;

- (void)createUI;
@end
