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

@interface TJProfileController ()<GKPhotosViewDelegate>

@property (nonatomic, strong) TJProfileView *profileView;

@end

@implementation TJProfileController
- (void)createUI {
    _profileView = [[TJProfileView alloc] init];
    [self.view addSubview:_profileView];
    [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
        [_profileView.cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [_profileView.okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_profileView.editBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.followBtn addTarget:self action:@selector(followAction) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.followerBtn addTarget:self action:@selector(followerAction) forControlEvents:UIControlEventTouchUpInside];
    [_profileView.friendBtn addTarget:self action:@selector(friendAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.tableView];
    self.dataSource = @[@"我的桌子", @"桌子历史", @"我的相册"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 67;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [self setupFootView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(277);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-kTabBarHeigthOrigin);
        } else {
            make.top.mas_equalTo(297);
            make.bottom.mas_equalTo(-kTabBarHeight);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
}


- (UIView *)setupFootView {
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(24, 0, kScreenWidth, 183+kTabBarHeigthOrigin)];
    
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
    
    [background addSubview:photosView];
    return background;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
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
    return cell;
}


#pragma mark - UITableViewDelegate

#pragma mark - GKPhotosViewDelegate
- (void)photoTapped:(UIImageView *)imgView {
    
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
    [self.navigationController pushViewController:[TJEditProfileController new] animated:true];
}

- (void)closeAction {
    // 消息
}

- (void)okAction {
    // 设置
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
