//
//  DDUsercenterVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//


#import "DDUsercenterVc.h"
#import "DDCustomActionSheet.h"         //底部弹窗
#import "DDUsercenterTableViewCell.h"   //cell
#import "DDSettingVc.h"                 //设置页
#import "DDTongCoinVC.h"                //铜币页
#import "DDFriendsViewController.h"     //好友、关注、被关注页
#import "DDAlbumViewController.h"       //相册页
#import "DDDeskShowViewController.h"    //桌子页
#import "DDLoginViewController.h"       //登录页
#import "DDRegisterViewController.h"    //注册页
#import "DDStretchableTableHeaderView.h"//果冻下拉
#import "DDUsercenterHeaderView.h"      //头部信息
#import "DDUserInfoModel.h"             //用户详情model
#import "DDScanAvatarViewController.h"  //查看大头像
#import "DDHisHerViewController.h"
#import "LSAlbumEtity.h"
#import "DDMessageViewController.h"

#define kAvatarWidth   50
#define kMarginGapWidth 18
#define kActivityItemWidth (kScreenWidth - kMarginGapWidth*6)/5

//不支持横屏的情况下
#define kTopViewHeight(SCREEN_MAX_LENGTH) \
({\
float height = 0;\
if (SCREEN_MAX_LENGTH==568)\
height=170;\
else if (SCREEN_MAX_LENGTH==667)\
height=235;\
else if(SCREEN_MAX_LENGTH==736)\
height=250;\
else if(SCREEN_MAX_LENGTH==812)\
height=305;\
(height);\
})\

@interface DDUsercenterVc ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (nonatomic, strong) DDUserInfoModel *model;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) DDLoginManager *loginManager;
@property (nonatomic, strong) DDUsercenterHeaderView *headerView;
@property (nonatomic, strong) DDStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic, strong) DDFriendsViewController *friendVC;
@property (nonatomic, strong) DDAlbumViewController *photo;
@property (nonatomic ,strong) UIImageView *heagderImageV;
@end

@implementation DDUsercenterVc

#pragma mark -  懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+ 10) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        //内边距
        self.tableView.contentInset = UIEdgeInsetsMake(kTopViewHeight(SCREEN_MAX_LENGTH)*1.1f, 0, 0, 0);
        [self.tableView addSubview:self.headerView];
    }
    return _tableView;
}

//- (UIImageView *)heagderImageV{
//    if (!_heagderImageV) {
//        self.heagderImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopViewHeight(SCREEN_MAX_LENGTH)*0.9f)];
//        _heagderImageV.image = [UIImage imageNamed:@"person_bg_newimage"];
//        _heagderImageV.contentMode = UIViewContentModeScaleAspectFill;
//        _heagderImageV.userInteractionEnabled = YES;
//        [_heagderImageV addSubview:self.headerView];
//        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(_heagderImageV);
//        }];
//        //        [_heagderImageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBgClick:)]];
//    }
//    return _heagderImageV;
//}

-(DDUsercenterHeaderView *)headerView {
    if(!_headerView) {
        _headerView = [[DDUsercenterHeaderView alloc]initWithFrame:CGRectMake(0, -kTopViewHeight(SCREEN_MAX_LENGTH), kScreenWidth, kTopViewHeight(SCREEN_MAX_LENGTH)*1.2f)];
        WeakSelf(weakSelf)
        _headerView.userInteractionEnabled = YES;
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        _headerView.loginRegisterClickBlcok = ^(NSInteger index) {
            if (index == 0) {
                [weakSelf enterLoginVC];
            }else if (index == 1){
                [weakSelf enterRegisterVC];
            }else{}
        };
        _headerView.scanBigAvatarBlcok = ^{
            //查看头像大图
            [weakSelf pushBigAvatarVC];
        };
    }
    return _headerView;
}

-(DDLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[DDLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    [kNotificationCenter addObserver:self selector:@selector(updateUserInfo) name:kUpdateUserInfoNotification object:nil];
    //左边消息按钮
    dispatch_queue_t queue= dispatch_queue_create("messageNum", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [DDTJHttpRequest getMessageNumWithToken:[DDUserDefault objectForKey:@"token"] block:^(NSDictionary *dict) {
            NSLog(@"未读消息数量%@",dict);
            //主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^(){
                if ([dict[@"num"] intValue] > 0) {
                    //左边消息按钮
                    self.navigationItem.leftBarButtonItem = [self customButtonForNavigationBarWithAction:@selector(messagesAction) imageNamed:@"usercenter_message" isRedPoint:YES pointValue:[dict[@"num"] stringValue] CGSizeMake:CGSizeMake(21, 16)];
                } else {
                    self.navigationItem.leftBarButtonItem = [self customButtonForNavigationBarWithAction:@selector(messagesAction) imageNamed:@"usercenter_message" isRedPoint:NO pointValue:@"" CGSizeMake:CGSizeMake(21, 16)];
                }
            });
        } failure:^{
            self.navigationItem.leftBarButtonItem = [self customButtonForNavigationBarWithAction:@selector(messagesAction) imageNamed:@"usercenter_message" isRedPoint:NO pointValue:@"" CGSizeMake:CGSizeMake(21, 16)];
        }];
    });
}

-(void)dealloc {
    [kNotificationCenter removeObserver:self name:kUpdateUserInfoNotification object:nil];
}

- (void)updateUserInfo{
    [self getUserdetailInfo];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavi];
    [self.view addSubview:self.tableView];
    if ([DDUserDefault objectForKey:@"token"]){
        [self getUserdetailInfo];
    }
    //[self initStretchHeader];
}
//获取用户详情
- (void)getUserdetailInfo{
    //开启异步并行线程请求用户详情数据
    dispatch_queue_t queue= dispatch_queue_create("userDetailinfo", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
        [DDTJHttpRequest getUserDetailInfoWithToken:[DDUserSingleton shareInstance].token block:^(NSDictionary *dict) {
            _model = [DDUserInfoModel mj_objectWithKeyValues:dict];
            _model.photo = [LSAlbumEtity mj_objectArrayWithKeyValuesArray:_model.photo];
            //主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^(){
                [_headerView updateUserInfoWith:_model];
                [self.tableView reloadData];
            });
            
        } failure:^{
            //
        }];
    });
}
- (void)initStretchHeader {
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kTopViewHeight(SCREEN_MAX_LENGTH)*1.2f)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.userInteractionEnabled = YES;
    bgImageView.image = kImage(@"person_bg_newimage");
    [bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBgClick:)]];
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    [contentView addSubview:self.headerView];
    
    self.stretchHeaderView = [DDStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:bgImageView subViews:contentView];
    
    //    [self.headerView updateUserInfoWith:_model];
}
-(void)customNavi{

    //右边设置按钮
    UIBarButtonItem *rightBtn = [self customButtonForNavigationBarWithAction:@selector(settingAction) imageNamed:@"usercenter_setting" isRedPoint:NO pointValue:nil CGSizeMake:CGSizeMake(22, 22)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight)];
    barView.tag = 120;
    barView.backgroundColor = kBgBlueColor;
    [self.navigationController.view insertSubview:barView belowSubview:self.navigationController.navigationBar];
    barView.alpha = 0;
}

#pragma mark - UITableViewDelegate\UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headView.backgroundColor = kBgWhiteGrayColor;
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.001)];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //未登录
    if (![DDUserDefault objectForKey:@"token"]){
        return 60;
    }else{
        if (indexPath.section == 2) {
            if (_model && _model.photo && _model.photo.count > 0) {
                return 130;
            }else{
                return 60;
            }
            //相册

        }else if (indexPath.section == 3){
            //活动历史
            if (!_model.table || _model.table.count == 0) {
                return 60;
            }else{
                return 60+kActivityItemWidth+20;
            }
        }else{
            //数字cell和打赏cell
            return 60;
        }}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    DDUsercenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DDUsercenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.variousNumberClickBlcok = ^(NSInteger index) {
        if (index == 0) {
            //桐币
            [self pushTongCoinVC];
        }
        if (index == 1) {
            //关注
            NSLog(@"1");
            [self pushFriendsVCWithStyle:DDFriendsStyleCare];
        }
        if (index == 2) {
            //被关注
            [self pushFriendsVCWithStyle:DDFriendsStyleCared];
            NSLog(@"2");
        }
        if (index == 3) {
            //好友
            [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
                self.friendVC.style = DDFriendsStyleNormal;
                [self.navigationController pushViewController:self.friendVC animated:YES];
            }];
        }
    };
    cell.activityHistoryClickBlcok = ^(NSInteger index) {
        [self pushDeskVC];
    };
    switch (indexPath.section) {
        case 0:{
            cell.style = DDUserCellStyleVariousNumbers;
        }
            break;
        case 1:{
            cell.style = DDUserCellStyleTongCoin;
        }
            break;
        case 2: {
            if (indexPath.row == 0) {
            cell.style = DDUserCellStyleAlbum;
            }
        }
            break;
        case 3:{
            cell.style = DDUserCellStyleActivities;
        }
            break;
        default:
            break;
    }
    [cell updateWithModel:_model];
    //    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld行",indexPath.row];
    //单元格内容动画
    static CGFloat initialDelay = 0.2f;
    static CGFloat stutter = 0.06f;
    cell.contentView.transform =  CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
    [UIView animateWithDuration:1. delay:initialDelay + ((indexPath.row) * stutter) usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        cell.contentView.transform = CGAffineTransformIdentity;
    } completion:NULL];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {}break;
        case 1:{
            //打赏明细
            [self pushFriendsVCWithStyle:DDFriendsStyleReward];
        }break;
        case 2:
        {
            //我的相册
            [self pushAlbumVC];
        }break;
        case 3:
        {}break;
        default:
            break;
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIView *barView = [self.navigationController.view viewWithTag:120];
    CGFloat offsetY = scrollView.contentOffset.y+200;
    if (offsetY < 0) {
        barView.alpha = 0;
    }else{
        if (offsetY < 64) {
            barView.alpha = offsetY/64;
        }else{
            barView.alpha = 1;
        }
    }
    
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%f",point.y);
    if (point.y + 64 <=  - 200) {
        CGRect rect = self.headerView.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y - 50.f;
        self.headerView.frame = rect;
    }
}

- (void)viewDidLayoutSubviews {
  //  [self.stretchHeaderView resizeView];
}


#pragma mark - UI
//背景图切换
-(void)changeBgClick:(UITapGestureRecognizer *)tap{
    DDCustomActionSheet *actionSheet = [DDCustomActionSheet actionSheetWithCancelTitle:@"取消" alertTitle:@"选择个人中心背景图" SubTitles:@"相机",@"相册", nil];
    [actionSheet show];
    //    WeakSelf(weakSelf);
    [actionSheet setCustomActionSheetItemClickHandle:^(DDCustomActionSheet *actionSheet, NSInteger currentIndex, NSString *title) {
        if (currentIndex == 0) {
            NSLog(@"相机");
        }
    }];
}
/**标签上下浮动**/
//- (void)ImageSpringWithLabel:(DDLabelView *)label{
//    [UIView animateWithDuration:1.5 animations:^{
//        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y+10, label.frame.size.width, label.frame.size.height);
//    }];
//    [UIView animateWithDuration:1.5 delay:1.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y-10, label.frame.size.width, label.frame.size.height);
//    } completion:^(BOOL finished) {
//        [self ImageSpringWithLabel:label];
//    }];
//}

#pragma mark - push
-(void)pushDeskVC{
    DDDeskShowViewController *deskVC = [[DDDeskShowViewController alloc] init];
    [self.navigationController pushViewController:deskVC animated:YES];
}

-(void)settingAction{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDSettingVc *settingVC =[[DDSettingVc alloc]init];
        settingVC.userModel = _model;
        [self.navigationController pushViewController:settingVC animated:YES];
    }];
}

-(void)pushTongCoinVC{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDTongCoinVC *tcoinVC = [[DDTongCoinVC alloc] init];
        [self.navigationController pushViewController:tcoinVC animated:YES];
    }];
}
-(void)pushFriendsVCWithStyle:(DDFriendsStyle)style{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDFriendsViewController *vc = [[DDFriendsViewController alloc] init];
        vc.style = style;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


- (void)pushBigAvatarVC{
    DDScanAvatarViewController *scanAvatarVC = [[DDScanAvatarViewController alloc] init];
    [self.navigationController pushViewController:scanAvatarVC animated:YES];
}


-(DDFriendsViewController *)friendVC {
    if (!_friendVC) {
        _friendVC = [[DDFriendsViewController alloc] init];
    }
    return _friendVC;
}


// 建议使用懒加载，避免每次进入加载图片
-(void)pushAlbumVC{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        [self.navigationController pushViewController:self.photo animated:YES];
    }];
}

-(DDAlbumViewController *)photo {
    if(!_photo){
        _photo = [[DDAlbumViewController alloc]init];
    }
    return _photo;
}

-(void)messagesAction{
    DDMessageViewController *messageVC = [[DDMessageViewController  alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}
-(void)enterLoginVC{
    DDLoginViewController *loginVC = [[DDLoginViewController alloc] init];
    [self.navigationController  pushViewController:loginVC animated:YES];
}
-(void)enterRegisterVC{
    DDRegisterViewController *registerVC = [[DDRegisterViewController alloc] init];
    [self.navigationController  pushViewController:registerVC animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end












