//
//  TJSearchFriendController.m
//  TongParty
//
//  Created by tojoin on 2018/4/24.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSearchFriendController.h"

@interface TJSearchFriendController ()<UISearchBarDelegate>


@end

@implementation TJSearchFriendController
- (void)createUI {
    UIButton *_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
        } else {
            make.top.mas_equalTo(23);
        }
        make.right.mas_equalTo(-14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:kImage(@"TJSearchBackground")];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundImage];
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(8);
        } else {
            make.top.mas_equalTo(28);
        }
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(_cancelBtn.mas_left).offset(-12);
    }];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索对方手机号码";
    searchBar.barStyle = UISearchBarStyleMinimal;
    searchBar.backgroundImage = [UIImage new];
    searchBar.tintColor = kBtnEnable;
    for (UIView* subview in [[[searchBar.subviews lastObject].subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UIView class]]) {
            [subview removeFromSuperview];
        }
    }
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(1);
        } else {
            make.top.mas_equalTo(21);
        }
        make.left.mas_equalTo(17);
        make.right.mas_equalTo(_cancelBtn.mas_left).offset(-4);
    }];
   
    
    
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44);
        } else {
            make.top.mas_equalTo(64);
        }
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -UISearchBarDelegate


- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
