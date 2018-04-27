//
//  TJNoticeController.m
//  TongParty
//
//  Created by tojoin on 2018/4/26.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJNoticeController.h"
#import "TJNoticeCell.h"
#import "TJMasterController.h"

#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])

@interface TJNoticeController ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) NSArray  *data;

@end

@implementation TJNoticeController
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
    titleLabel.text = @"消息通知";
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
    
    [self.view addSubview:self.tableView];
    self.dataSource = @[@"系统通知", @"我的关注", @"申请回复", @"邀请我加入的", @"好友申请"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 111;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(45);
        } else {
            make.top.mas_equalTo(65);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(0);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataSource.count;
    } else
        return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJNoticeCellID"];
    if (!cell) {
        cell = [[TJNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJNoticeCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.headImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"TJNotice-%zd",indexPath.row]];
        cell.titleL.text = self.dataSource[indexPath.row];
        cell.contentL.text = @"桐聚新版本上线啦～";
        cell.timeL.text = @"10分钟";
        [cell updateSystemControl];
//        [cell updateWidget];
    } else {
        if ([self.data[indexPath.row][@"is_master"] isEqualToString:@"1"]) {
            cell.headImage.image = kImage(@"TJMaster");
            cell.status.text = @"桌主";
        } else {
            cell.headImage.image = kImage(@"TJPlayer");
            cell.status.text = @"玩家";
        }
        cell.titleL.text = self.data[indexPath.row][@"title"];
        NSArray *messageArr = self.data[indexPath.row][@"message"];
        [cell updateTime:messageArr[0][@"uptime"]];
        if (messageArr.count<2) {
            cell.contentL.text = [NSString stringWithFormat:@"%@申请加入您的桌子", messageArr[0][@"nickname"]];
        } else {
            cell.contentL.text = [NSString stringWithFormat:@"%@等%zd人申请加入您的桌子", messageArr[0][@"nickname"], messageArr.count];
        }
        [cell updateRemainL:self.data[indexPath.row][@"begin_time"]];
        
        [cell updateCustomControl];
    }
    
    return cell;
}
//18612404155
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self.navigationController pushViewController:[TJMasterController new] animated:true];
    }
}

- (void)requestData {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJMessageList params:@{@"token":curUser.token} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            NSArray *arr = result.data;
            if (arr.count) {
                if ((result.data[@"table"])) {
                    weakSelf.data = result.data[@"table"];
                    [weakSelf.tableView reloadData];
                }
            }
        }
    } failure:^{
        
    }];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
