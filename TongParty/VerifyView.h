//
//  VerifyView.h
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Resend)(void);

@interface VerifyView : UIView
{
    NSTimer *_timer;
    NSInteger _i;
}

@property (nonatomic, copy)   NSString    *phone;
@property (nonatomic, strong) UIButton    *closeBtn;
@property (nonatomic, strong) UIButton    *signupBtn;
@property (nonatomic, strong) UILabel     *phoneNum;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) YYLabel     *resetBtn;
@property (nonatomic, copy)   Resend      resend;

@end
