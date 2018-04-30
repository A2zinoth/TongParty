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

@property (nonatomic, assign) NSInteger   i;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, copy)   NSString    *phone;
@property (nonatomic, strong) NSTimer     *timer;
@property (nonatomic, strong) UIButton    *closeBtn;
@property (nonatomic, strong) UIButton    *signupBtn;
@property (nonatomic, strong) UILabel     *phoneNum;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) YYLabel     *resetBtn;
@property (nonatomic, copy)   Resend      resend;
@property (nonatomic, strong) UIButton    *nextButton;

@end
