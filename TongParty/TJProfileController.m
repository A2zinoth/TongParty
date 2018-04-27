//
//  TJProfileController.m
//  TongParty
//
//  Created by tojoin on 2018/4/10.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJProfileController.h"
#import "TJProfileView.h"
#import "TJProfileCell.h"
#import "GKPhotosView.h"
#import "TJEditProfileController.h"
#import "TJFollowController.h"
#import "TJFollowerController.h"
#import "TJFriendController.h"
#import "DDSettingVc.h"
#import "GKPhotoBrowser.h"
#import "TJNoticeController.h"
#import "TJTableController.h"

@interface TJProfileController ()<GKPhotosViewDelegate,GKPhotoBrowserDelegate>


@property (nonatomic, strong) TJProfileView *profileView;

@end

@implementation TJProfileController
- (void)createUI {
    
    if (_act) {
        _profileView = [[TJProfileView alloc] initWithAct:_act];
    } else {
        _profileView = [[TJProfileView alloc] init];
    }
    [self.view addSubview:_profileView];
    [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [_profileView.cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_profileView.addFollowBtn addTarget:self action:@selector(addFollowAction:) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.editBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.followBtn addTarget:self action:@selector(followAction) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.followerBtn addTarget:self action:@selector(followerAction) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.friendBtn addTarget:self action:@selector(friendAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.tableView];
    if(_act)
        self.dataSource = @[@"他的桌子", @"桌子历史", @"他的相册"];
    else
        self.dataSource = @[@"我的桌子", @"桌子历史", @"我的相册"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    CGFloat bottom = 0;
    if (!_act) bottom = -kTabBarHeigthOrigin;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(297);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(bottom);
        } else {
            make.top.mas_equalTo(317);
            make.bottom.mas_equalTo(bottom);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
}


- (void)imgClick:(id)sneder {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = true;
    if (_act) {
        [self requestDataWithUid:_act];
    } else
        [self requestData];
    [_profileView.headImage sd_setImageWithURL:[NSURL URLWithString:curUser.image]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJProfileCellID"];
    if (!cell) {
        cell = [[TJProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJProfileCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cell updateData:self.dataSource[indexPath.row]];
    if (indexPath.row == 2) {
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < 3)return 67;
    else return 171+8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TJTableController *table = [[TJTableController alloc] init];
        if (_act)
            table.act = _act;
        [self.navigationController pushViewController:table animated:true];
    }
}

#pragma mark - GKPhotosViewDelegate
- (void)photoTapped:(UIImageView *)imgView {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    for (NSInteger i = 0; i < 6; i ++) {
        [arr addObject:[NSString stringWithFormat:@"Image-%ld",(long)i]];
    }
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:arr currentIndex:imgView.tag];
    browser.showStyle           = GKPhotoBrowserShowStyleZoom;
    browser.hideStyle           = GKPhotoBrowserHideStyleZoomScale;
    browser.loadStyle           = GKPhotoBrowserLoadStyleIndeterminateMask;
    //        browser.isResumePhotoZoom   = YES;
//    [browser setupCoverViews:@[self.pageControl] layoutBlock:^(GKPhotoBrowser *photoBrowser, CGRect superFrame) {
//    
//        self.pageControl.center = CGPointMake(superFrame.size.width * 0.5, superFrame.size.height - 30);
//    }];
    browser.delegate = self;
    
    [browser showFromVC:self];
}



- (void)addFollowAction:(UIButton *)btn {
    if (!btn.selected) {// 关注
        [DDResponseBaseHttp getWithAction:kTJFollowUser params:@{@"token":curUser.token, @"oid":_act} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            [MBProgressHUD showMessage:result.msg_cn];
            if ([result.status isEqualToString:@"success"]) {
                btn.backgroundColor = [UIColor hx_colorWithHexString:@"#E6E5EB"];
                btn.selected = true;
            }
        } failure:^{
        }];
    } else { // 未关注
        [DDResponseBaseHttp getWithAction:kTJCancelFollow params:@{@"token":curUser.token, @"oid":_act} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
            [MBProgressHUD showMessage:result.msg_cn];
            if ([result.status isEqualToString:@"success"]) {
                btn.backgroundColor = kBtnEnable;
                btn.selected = false;
            }
        } failure:^{
        }];
    }
}

- (void)friendAction {
//    [self.navigationController pushViewController:[TJFriendController new] animated:true];
}

- (void)followerAction {
//    [self.navigationController pushViewController:[TJFollowerController new] animated:true];
}

- (void)followAction {
//    [self.navigationController pushViewController:[TJFollowController new] animated:true];
}

- (void)editAction {
    TJEditProfileController *editProfile = [[TJEditProfileController alloc] init];
    if (_act) {
        editProfile.act = _act;
    }
    [self.navigationController pushViewController:editProfile animated:true];
}

- (void)closeAction {
    // 消息
    if (!_act) {
        [self.navigationController pushViewController:[TJNoticeController new] animated:true];
    } else
        [self.navigationController popViewControllerAnimated:true];
}

- (void)okAction {
    // 设置
    DDSettingVc *settingVC =[[DDSettingVc alloc]init];
//    settingVC.userModel = _model;
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)requestDataWithUid:(NSString *)uid {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJProfile params:@{@"token":curUser.token, @"act":@"others", @"uid":uid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            [weakSelf.profileView updateWithDic:result.data];
            [weakSelf setupFootView:result.data[@"album"]];
        }
    } failure:^{
        
    }];
}

- (void)requestData {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJProfile params:@{@"token":curUser.token, @"act":@"my"} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            [weakSelf.profileView updateWithDic:result.data];
            [weakSelf setupFootView:result.data[@"album"]];
        }
    } failure:^{
        
    }];
}

- (void)setupFootView:(NSArray *)arr {
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 171)];
    CGFloat width = (kScreenWidth -24*2-3*2)/3;
    for (NSInteger i = 0; i < arr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(24+i%3*(3+width), i/3*(84+3), width, 84);
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [background addSubview:imgView];
        
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:arr[i][@"image"]]];
    }
    if (arr.count<4) {
        self.tableView.tableFooterView.height = 86;
    } else {
        self.tableView.tableFooterView.height = 171;
    }
    self.tableView.tableFooterView = background;
}


@end
