
//
//  EventAddrController.m
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJEventAddrController.h"
#import "TJEventAddrView.h"
#import "TJSearchResultController.h"
#import "TJSuggestTableViewCell.h"

#define StatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height

@interface TJEventAddrController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,
UISearchControllerDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) TJEventAddrView           *eventAddrView;

@property (nonatomic, strong) UISearchController        *searchController;
@property (nonatomic, strong) TJSearchResultController  *searchResultController;

//数据源
@property (nonatomic,strong) NSMutableArray *dataListArry;
@property (nonatomic,strong) NSMutableArray *searchListArry;

// 地图
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;


// 需要更换
@property (nonatomic, strong) UIView      *searchView;
@property (nonatomic, strong) UIImageView *sousuoBgView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton    *cancelBtn;
@property (nonatomic, strong) UITableView *searchTableView;

@end

@implementation TJEventAddrController
- (void)createData {
    [self configLocationManager];
}

//取消按钮响应事件
- (void)cancelBtnAction {
    [UIView animateWithDuration:.27 animations:^{
        CGRect sousuoR = _sousuoBgView.frame;
        sousuoR.origin.x = 38;
        sousuoR.origin.y = 72+5;
        _sousuoBgView.frame = sousuoR;
        
        CGRect quxiaoR = _cancelBtn.frame;
        quxiaoR.origin.y = 72;
        _cancelBtn.frame = quxiaoR;
        
        CGRect tabR = _searchTableView.frame;
        tabR.origin.y = CGRectGetMaxY(_sousuoBgView.frame);
        _searchTableView.frame = tabR;
        
        [self.searchBar resignFirstResponder];
    }completion:^(BOOL finished) {
        self.searchView.hidden = YES;
        _eventAddrView.hidden = false;
        _searchBar.text = @"";
        // _searchTabData = [NSMutableArray array];
        [_searchTableView reloadData];
    }];
}


- (void)searchBtnAction {
    _eventAddrView.hidden = true;
    
    [UIView animateWithDuration:.27 animations:^{
        CGRect sousuoR = _sousuoBgView.frame;
        sousuoR.origin.x = 25;
        sousuoR.origin.y = 6;
        _sousuoBgView.frame = sousuoR;
        
        CGRect quxiaoR = _cancelBtn.frame;
        quxiaoR.origin.y = 12;
        _cancelBtn.frame = quxiaoR;
        
        CGRect tabR = _searchTableView.frame;
        tabR.origin.y = _sousuoBgView.frame.size.height + _sousuoBgView.frame.origin.y + 20;
        _searchTableView.frame = tabR;
        
        self.searchView.hidden = NO;
        [self.searchBar becomeFirstResponder];
    }];
}

- (void)createUI {
    _eventAddrView = [[TJEventAddrView alloc] init];
    [self.view addSubview:_eventAddrView];
    [_eventAddrView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];

    [_eventAddrView.cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_eventAddrView.okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
//    [_eventAddrView.searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    

    [self.view addSubview:self.searchView];
    self.searchView.hidden = YES;

    
    //地图
    [self.view addSubview:self.mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(112);
        } else {
            make.top.mas_equalTo(self.view).offset(112);
        }
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(253);
    }];
    
    
    [self.view addSubview:self.tableView];
    self.dataSource = @[@"", @"", @"", @"", @"", @"", @"", @""];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mapView.mas_bottom);
    }];
}



- (UIView *)searchView {
    if (!_searchView) {
        float top = 0;
        if (iPhoneX) {
            top = 44;
        }
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, top, kScreenWidth, kScreenHeight-216-top)];
        _sousuoBgView = [[UIImageView alloc] initWithFrame:CGRectMake(38, 72, kScreenWidth - 25-62,30)];
//        _sousuoBgView.backgroundColor = [UIColor whiteColor];
//        _sousuoBgView.image =[UIImage imageNamed:@"TJSearchBackground"];
//        _sousuoBgView.layer.cornerRadius = kP6(3);
        [_searchView addSubview:_sousuoBgView];
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, _sousuoBgView.frame.size.width, _sousuoBgView.frame.size.height)];
//        UIImage* searchBarBg = [MLTools GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
        //设置背景图片
//        [_searchBar setBackgroundImage:[UIImage imageNamed:@"TJSearchBackground"]];
        //设置背景色
        [_searchBar setBackgroundColor:[UIColor clearColor]];
        //设置文本框背景
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"TJSearchBackground"] forState:UIControlStateNormal];
        _searchBar.showsCancelButton = NO;
        _searchBar.tintColor = kBtnEnable;
        _searchBar.barTintColor = [UIColor whiteColor];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.translucent = YES;
        _searchBar.placeholder = @"搜索地点";
        _searchBar.delegate = self;
        [_sousuoBgView addSubview:_searchBar];
        
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_sousuoBgView.frame) + 8,  72+5, 28, 19)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_searchView addSubview:_cancelBtn];
        
        _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_sousuoBgView.frame), kScreenWidth, _searchView.frame.size.height - _sousuoBgView.frame.size.height) style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.tag = 100;
        _searchTableView.tableFooterView = [UIView new];
        [_searchView addSubview:_searchTableView];
    }
    return _searchView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = true;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        CLLocationCoordinate2D coordinate=location.coordinate;
        self.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        self.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            self.addrString = regeocode.formattedAddress;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJSuggestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJEventAddrID"];
    if (!cell) {
        cell = [[TJSuggestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJEventAddrID"];
    }
    
    if (indexPath.row == 0) {
        cell.selectedMark.hidden = false;
        cell.circleMark.hidden = false;
        cell.selectedLabel.hidden = false;
        
        cell.titleLabel.hidden = true;
        cell.addrLabel.hidden = true;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

#pragma mark - searchdelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    TJSearchResultController *vc = [[TJSearchResultController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - AMap
- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] init];
        _mapView.showsBuildings = YES;
        _mapView.rotateCameraEnabled = NO;
        _mapView.rotateEnabled = NO;
        _mapView.mapType = MAMapTypeStandard;
        [_mapView setZoomLevel:18.f];
        _mapView.showsScale = NO;
        _mapView.pausesLocationUpdatesAutomatically = NO;
        _mapView.allowsBackgroundLocationUpdates = NO;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
//        _mapView.showsCompass = NO;
        MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
        r.showsAccuracyRing = NO;
        [_mapView updateUserLocationRepresentation:r];
        _mapView.delegate = self;
    }
    return _mapView;
}


- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:10];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:10];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)okAction {
    
}

@end
