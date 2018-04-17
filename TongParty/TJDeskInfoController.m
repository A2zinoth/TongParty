//
//  TJDeskInfoController.m
//  TongParty
//
//  Created by tojoin on 2018/4/15.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskInfoController.h"
#import "TJDeskInfoView.h"
#import "TJDeskInfoModel.h"

@interface TJDeskInfoController ()

@property (nonatomic, strong) TJDeskInfoView  *infoView;
@property (nonatomic, strong) TJDeskInfoModel *infoModel;

@end

@implementation TJDeskInfoController

- (TJDeskInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[TJDeskInfoView alloc] init];
    }
    return _infoView;
}

- (void)createUI {
    
    [self.view addSubview:self.infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    kWeakSelf
    _infoView.noticeLock = ^(NSString *bLock) {
        weakSelf.noticeLock(bLock);
    };
    
    _infoModel = [[TJDeskInfoModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDictionary *dic = @{
                          @"token":[DDUserDefault objectForKey:@"token"],
                          @"tid":self.tid,
                          @"latitude":[DDUserSingleton shareInstance].latitude,
                          @"longitude":[DDUserSingleton shareInstance].longitude
                          };
    
    WeakSelf(weakSelf);
    [_infoModel getTableInfoWithPara:dic success:^(NSObject *data) {
        [weakSelf.infoView updateWithModel:(TJDeskInfoModel*)data];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
