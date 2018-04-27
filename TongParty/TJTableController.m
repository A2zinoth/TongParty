//
//  TJTableController.m
//  TongParty
//
//  Created by tojoin on 2018/4/26.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJTableController.h"
#import "TJTableCollectionViewCell.h"
#import "TJDeskViewController.h"

#define TJTableCollectionCellID     @"TJTableCollectionCellID"

@interface TJTableController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)        UICollectionView *collectView;
@property (nonatomic, copy)  __block NSString         *currentTime;


@end

@implementation TJTableController

- (void)createUI {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
        } else {
            make.top.mas_equalTo(self.view).offset(23);
        }
        make.left.mas_equalTo(self.view).offset(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    YYLabel *titleLabel = [[YYLabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"我的桌子";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.mas_equalTo(self.view).offset(32).key(@"titleLabel");
        }
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(1, 27);
    layout.minimumInteritemSpacing = 1.f;
    layout.minimumLineSpacing = 20.f;
    layout.itemSize = CGSizeMake(160, 198);
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.showsVerticalScrollIndicator = false;
    _collectView.dataSource = self;
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
    [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(45);
        } else {
            make.top.mas_equalTo(65);
        }
        make.left.mas_equalTo(19);
        make.right.mas_equalTo(-19);
        make.bottom.mas_equalTo(0);
    }];
    [_collectView registerClass:[TJTableCollectionViewCell class] forCellWithReuseIdentifier:TJTableCollectionCellID];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TJTableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TJTableCollectionCellID forIndexPath:indexPath];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.row][@"head_image"]]];
    cell.titleL.text = self.dataSource[indexPath.row][@"title"];
    [cell updateTime: self.dataSource[indexPath.row][@"begin_time"] serviceTime:self.currentTime];
    [cell updateMaster:self.dataSource[indexPath.row][@"is_master"]];
    if (indexPath.row == 0) {
        [cell showBeginImage:true];
    } else
        [cell showBeginImage:false];
    [cell updateMember:self.dataSource[indexPath.row][@"member"]];
    
    return cell;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TJDeskViewController *deskVC = [[TJDeskViewController alloc] init];
    deskVC.tid = self.dataSource[indexPath.row][@"table_id"];
    deskVC.flag = @"MyTable";
    [self.navigationController pushViewController:deskVC animated:true];
}


- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)requestData {
    kWeakSelf
    
    NSDictionary *dic;
    if (_act) {
        dic = @{@"token":curUser.token, @"act":@"others",@"uid":_act};
    } else {
        dic = @{@"token":curUser.token, @"act":@"my"};
    }
    
    [DDResponseBaseHttp getWithAction:kTJTableMy params:dic type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            weakSelf.dataSource = result.data[@"tables"];
            weakSelf.currentTime = result.data[@"serviceTime"];
            [weakSelf.collectView reloadData];
        } else
            [MBProgressHUD showMessage:result.msg_cn];
    } failure:^{
        
    }];
}

@end
