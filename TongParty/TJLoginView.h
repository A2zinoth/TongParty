//
//  TJLoginView.h
//  Tojoin
//
//  Created by tojoin on 2018/4/8.
//  Copyright © 2018年 Beijing Tojoin Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ThirdAction)(NSInteger);

@interface TJLoginView : UIView

@property (nonatomic, strong) UIButton      *closeBtn;
@property (nonatomic, strong) UIButton      *signupBtn;
@property (nonatomic, strong) UITextField   *phoneTF;
@property (nonatomic, strong) UITextField   *passwordTF;
@property (nonatomic, strong) UIButton      *loginBtn;
@property (nonatomic, copy  ) ThirdAction   thirdAction;
@property (nonatomic, strong) UIButton      *forgetBtn;

@end
