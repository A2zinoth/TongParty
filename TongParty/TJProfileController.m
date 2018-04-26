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
        self.dataSource = @[@"他的桌子", @"桌子历史", @"他的相册", @""];
    else
        self.dataSource = @[@"我的桌子", @"桌子历史", @"我的相册", @""];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    CGFloat bottom = 0;
    if (!_act) {
        bottom = -kTabBarHeigthOrigin;
    }
    
    
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


//- (UIView *)setupFootView {
//
//}

- (void)imgClick:(id)sneder {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
    
//    UIImageView *imgView = [[UIImageView alloc] init];
//    imgView.frame = CGRectMake(0, 0, 100, 100);
//    imgView.contentMode = UIViewContentModeScaleAspectFill;
//    imgView.clipsToBounds = YES;
//    [self.view addSubview:imgView];
//    
//    imgView.userInteractionEnabled = YES;
//    [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)]];
//    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Image-0"]];
    
    CGFloat photoW = kScreenWidth - 24*2;
    GKPhotosView *photosView = [GKPhotosView photosViewWithWidth:photoW andMargin:3];
    photosView.delegate = self;

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    for (NSInteger i = 0; i < 6; i ++) {
        GKTimeLineImage *image = [[GKTimeLineImage alloc] init];
        image.url = [NSString stringWithFormat:@"Image-%ld",(long)i];
        [arr addObject:image];
    }
    photosView.images = arr;
    [self.view addSubview:photosView];
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
    if (indexPath.row < 3) {
        [cell updateData:self.dataSource[indexPath.row]];
    } else {
        
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < 3)return 67;
    else return 171+8;
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
    [self.navigationController pushViewController:[TJFriendController new] animated:true];
}

- (void)followerAction {
    [self.navigationController pushViewController:[TJFollowerController new] animated:true];
}

- (void)followAction {
    [self.navigationController pushViewController:[TJFollowController new] animated:true];
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
        }
    } failure:^{
        
    }];
}

- (void)requestData {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJProfile params:@{@"token":curUser.token, @"act":@"my"} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            [weakSelf.profileView updateWithDic:result.data];
        }
    } failure:^{
        
    }];
}

@end
