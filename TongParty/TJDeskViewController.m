//
//  TJDeskViewController.m
//  TongParty
//
//  Created by tojoin on 2018/4/15.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskViewController.h"
#import "TJDeskInfoController.h"
#import "TJDeskNoticeController.h"

@interface TJDeskViewController ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *okBtn;

@property (nonatomic, strong) UIScrollView           *scrollView;
@property (nonatomic, strong) TJDeskInfoController   *deskInfoVC;
@property (nonatomic, strong) TJDeskNoticeController *deskNoticeVC;
@property (nonatomic, strong) UIButton               *infoBtn;
@property (nonatomic, strong) UIButton               *noticeBtn;
@property (nonatomic, strong) UILabel                *selectedLabel;
@property (nonatomic, strong) UIImageView            *noticeLock;

@end

@implementation TJDeskViewController

- (void)createData {
    kWeakSelf
    self.deskInfoVC.noticeLock = ^(NSString *bLock) {
        if ([bLock isEqualToString:@"1"]) {
//            [weakSelf.noticeBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
            weakSelf.noticeBtn.enabled = true;
            weakSelf.noticeLock.hidden = true;
            weakSelf.scrollView.contentSize = CGSizeMake(kScreenWidth*2, kScreenHeight - kNavigationBarHeight-60);
        } else {
            [weakSelf.noticeBtn setTitleColor:kBtnDisable forState:UIControlStateNormal];
            weakSelf.noticeBtn.enabled = false;
            weakSelf.noticeLock.hidden = false;
            weakSelf.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight - kNavigationBarHeight-60);
        }
    };
}


- (void)createUI {
    
    [self createHeadView];
    [self createScrollView];
}

- (void)createHeadView {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
        } else {
            make.top.mas_equalTo(self.view).offset(23);
        }
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
   
    
    
    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_okBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_okBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _okBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _okBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:_okBtn];
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
        } else {
            make.top.mas_equalTo(23);
        }
        make.trailing.mas_equalTo(-14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    _infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_infoBtn setTitle:@"桌子详情" forState:UIControlStateNormal];
    [_infoBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _infoBtn.backgroundColor = [UIColor clearColor];
    _infoBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _infoBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_infoBtn  addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    _infoBtn.tag = 10063;
    [self.view addSubview:_infoBtn];
    CGFloat left = kScreenWidth/3-27/2-5;
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(64);
        } else {
            make.top.mas_equalTo(self.view).offset(84);
        }
        make.left.mas_equalTo(left);
        make.size.mas_equalTo(CGSizeMake(56, 27));
    }];
    
    _selectedLabel = [[UILabel alloc] init];
    _selectedLabel.backgroundColor = kBtnEnable;
    [self.view addSubview:_selectedLabel];
    [_selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(100);
        } else {
            make.top.mas_equalTo(self.view).offset(120);
        }
        make.left.mas_equalTo(left);
        make.size.mas_equalTo(CGSizeMake(56, 2));
    }];
    
    _noticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_noticeBtn setTitle:@"公告" forState:UIControlStateNormal];
//    [_noticeBtn setImage:[UIImage imageNamed:@"TJNoticeLock"] forState:UIControlStateNormal];
//    _noticeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _noticeBtn.backgroundColor = [UIColor clearColor];
    [_noticeBtn setTitleColor:kBtnDisable forState:UIControlStateNormal];
    _noticeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _noticeBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_noticeBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    _noticeBtn.tag = 10064;
    [self.view addSubview:_noticeBtn];
    left = kScreenWidth*2/3-27/2+5;
    [_noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(64);
        } else {
            make.top.mas_equalTo(self.view).offset(84);
        }
        make.left.mas_equalTo(left);
        make.size.mas_equalTo(CGSizeMake(56, 27));
    }];
    

    
    kWeakSelf
    _noticeLock = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"TJDeskNoticeLock"]];
    [self.view addSubview:_noticeLock];
    [_noticeLock mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(72);
        } else {
            make.top.mas_equalTo(self.view).offset(92);
        }
        make.left.mas_equalTo(weakSelf.noticeBtn).offset(42);
        make.size.mas_equalTo(CGSizeMake(9, 10));
    }];
    
   
    
    UILabel *separateLine = [[UILabel alloc] init];
    separateLine.backgroundColor = [UIColor hx_colorWithHexString:@"#DFE3E2"];
    [self.view addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(102);
        } else {
            make.top.mas_equalTo(self.view).offset(122);
        }
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];

}

- (void)createScrollView {
    [self.view addSubview:self.scrollView];
    _scrollView.backgroundColor = [UIColor redColor];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(104);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.mas_equalTo(124);
            make.bottom.mas_equalTo(0);
        }
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [self addChildViewController:self.deskInfoVC];
    [self addChildViewController:self.deskNoticeVC];
    [self.scrollView addSubview:self.deskInfoVC.view];
    [self.scrollView addSubview:self.deskNoticeVC.view];

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.deskInfoVC.tid = _tid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (TJDeskNoticeController *)deskNoticeVC {
    if (!_deskNoticeVC) {
        _deskNoticeVC = [[TJDeskNoticeController alloc] init];
        _deskNoticeVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kNavigationBarHeight-60);
    }
    return _deskNoticeVC;
}

- (TJDeskInfoController *)deskInfoVC {
    if (!_deskInfoVC) {
        _deskInfoVC = [[TJDeskInfoController alloc] init];
        _deskInfoVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kNavigationBarHeight-60);
    }
    return _deskInfoVC;
}

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView  = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator  = NO;
        _scrollView.showsVerticalScrollIndicator    = NO;
        _scrollView.contentSize     = CGSizeMake(kScreenWidth , kScreenHeight - kNavigationBarHeight-60);
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = false;
        _scrollView.scrollEnabled   = YES;
    }
    return _scrollView;
}

#pragma mark - UIScrollViewDelegate
// 结束减速
- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == kScreenWidth) {
        CGFloat left = kScreenWidth*2/3-27/2+5;
        [_infoBtn setTitleColor:kBtnDisable forState:UIControlStateNormal];
        [_noticeBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
        [_selectedLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
        }];
    } else {
        CGFloat left = kScreenWidth/3-27/2-5;
        [_infoBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
        [_noticeBtn setTitleColor:kBtnDisable forState:UIControlStateNormal];
        [_selectedLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
        }];
    }
}

- (void)switchAction:(UIButton *)btn {
    if (btn.tag == 10063) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [btn setTitleColor:kBtnEnable forState:UIControlStateNormal];
        UIButton *right = [self.view viewWithTag:10064];
        [right setTitleColor:kBtnDisable forState:UIControlStateNormal];
        CGFloat left = kScreenWidth/3-27/2-5;
        [_selectedLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
        }];
    } else if (btn.tag == 10064){
        [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
        [btn setTitleColor:kBtnEnable forState:UIControlStateNormal];
        UIButton *leftBtn = [self.view viewWithTag:10063];
        [leftBtn setTitleColor:kBtnDisable forState:UIControlStateNormal];
        CGFloat left = kScreenWidth*2/3-27/2+5;
        [_selectedLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
        }];
    }
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)okAction {
    // 分享
}
@end
