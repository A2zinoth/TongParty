
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

@interface TJEventAddrController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,
UISearchControllerDelegate,AMapLocationManagerDelegate,MAMapViewDelegate,AMapSearchDelegate> {
    CGFloat _oldY;
    CLLocationCoordinate2D oldCoordinate;
}
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) MAMapView     *mapView;
@property (nonatomic, strong) CLLocation    *currentLocation;
@property (nonatomic, strong) UIView        *view_searchBar;
@property (nonatomic, strong) UIButton      *btn_backLocal;
@property (nonatomic, strong) UIImageView   *iv_mapMark;

@property (nonatomic, strong) TJEventAddrView         *eventAddrView;
@property (nonatomic, assign) NSUInteger              index;

@property (nonatomic, strong) UISearchController        *searchController;
@property (nonatomic, strong) TJSearchResultController  *searchResultController;
@property (nonatomic, strong) NSArray                   *dataArray;
//@property (nonatomic, strong) NSArray                   *searchArry;
@property (nonatomic, strong) UITableView               *searchBarTable;


@end

@implementation TJEventAddrController

- (void)createUI {
    self.title = @"活动地址";
    
    UIButton *_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.frame = CGRectMake(0, 0, 38, 28);
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithCustomView:_cancelBtn];
    self.navigationItem.leftBarButtonItems = @[leftBBI];
    
    UIButton*_okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_okBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
    _okBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    _okBtn.frame = CGRectMake(0, 0, 38, 28);
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithCustomView:_okBtn];
    self.navigationItem.rightBarButtonItems = @[rightBBI];
    
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultController];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = _searchResultController;
    _searchController.searchBar.barTintColor = kBgWhiteGrayColor;
    _searchController.searchBar.placeholder = @"搜索地点";
    [_searchController.searchBar setContentMode:UIViewContentModeCenter];
    // 背景变暗
    _searchController.dimsBackgroundDuringPresentation  = false;
    // 背景模糊
    self.searchController.obscuresBackgroundDuringPresentation = true;
    // 隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = true;
    _searchController.searchBar.frame = CGRectMake(0, 0, _searchController.searchBar.frame.size.width, 44.0);

    _searchBarTable = [[UITableView alloc] init];
    if ([[UIDevice currentDevice].systemVersion floatValue]<11) {
//        self.extendedLayoutIncludesOpaqueBars = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    } else {
            self.definesPresentationContext = true;
    }

    [self.view addSubview:_searchBarTable];
    _searchBarTable.tableHeaderView = _searchController.searchBar;
    [_searchBarTable mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    //地图
    [self.view addSubview:self.mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(50);
        } else {
            make.top.mas_equalTo(self.view).offset(50);
        }
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(253);
    }];

    [self.view addSubview:self.iv_mapMark];
    [_iv_mapMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_mapView).offset(100);
    }];
    // 回归当前位置按钮
    _btn_backLocal = [UIButton new];
    [self.mapView addSubview:_btn_backLocal];
    [_btn_backLocal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(DDFitHeight(35.f));
        make.bottom.equalTo(_mapView).offset(-DDFitHeight(10.f));
        make.right.equalTo(_mapView).offset(-DDFitHeight(10.f));
    }];
    [_btn_backLocal setBackgroundImage:kImage(@"back_userLocation") forState:UIControlStateNormal];
    [_btn_backLocal addTarget:self action:@selector(backLocal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.view_searchBar];


    [self.view addSubview:self.tableView];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.tableHeaderView = _searchController.searchBar;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (@available(ios 11.0,*)) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
//            make.bottom.mas_equalTo(self.mapView.mas_safeAreaLayoutGuideBottom);;
//        } else {
//            make.top.mas_equalTo(self.view).offset(64);
//            make.bottom.mas_equalTo(self.view);
//        }
//        make.left.mas_equalTo(self.view);
//        make.right.mas_equalTo(self.view);

        if (@available(ios 11.0,*)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view).offset(49);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mapView.mas_bottom);
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = false;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJSuggestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJEventAddrID"];
    if (!cell) {
        cell = [[TJSuggestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJEventAddrID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == self.index) {
        cell.titleLabel.hidden = true;
        cell.addrLabel.hidden = true;
        cell.circleMark.hidden = false;
        cell.selectedMark.hidden = false;
        cell.selectedLabel.hidden = false;
    } else {
        cell.titleLabel.hidden = false;
        cell.addrLabel.hidden = false;
        cell.circleMark.hidden = true;
        cell.selectedMark.hidden = true;
        cell.selectedLabel.hidden = true;
    }
    
    if ([_dataArray[indexPath.row] isKindOfClass:[AMapPOI class]]) {
        AMapPOI *poi = _dataArray[indexPath.row];
        cell.selectedLabel.text = poi.name;
        cell.titleLabel.text = poi.name;
        cell.addrLabel.text = [NSString stringWithFormat:@"%@%@%@%@",poi.province,poi.city,poi.district,poi.address];
    } else {
        AMapTip *tip = _dataArray[indexPath.row];
        cell.selectedLabel.text = tip.name;
        cell.titleLabel.text = tip.name;
        cell.addrLabel.text = [NSString stringWithFormat:@"%@%@",tip.district, tip.address];
    }

    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

//点击回调
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row  != self.index) {
        // 取消原来点击
        NSIndexPath *oldIndex = [NSIndexPath indexPathForRow:self.index inSection:0];
        TJSuggestTableViewCell * oldCell = [tableView cellForRowAtIndexPath:oldIndex];
        oldCell.titleLabel.hidden = false;
        oldCell.addrLabel.hidden = false;
        oldCell.circleMark.hidden = true;
        oldCell.selectedMark.hidden = true;
        oldCell.selectedLabel.hidden = true;
        //增加现在点击
        
        TJSuggestTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.titleLabel.hidden = true;
        cell.addrLabel.hidden = true;
        cell.circleMark.hidden = false;
        cell.selectedMark.hidden = false;
        cell.selectedLabel.hidden = false;
        self.index = indexPath.row;
        
        CLLocationCoordinate2D coordinate;
        if([_dataArray[indexPath.row] isKindOfClass:[AMapPOI class]]) {
            AMapPOI *poi = _dataArray[indexPath.row];
            coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
        } else {
            AMapTip *tip = _dataArray[indexPath.row];
            coordinate = CLLocationCoordinate2DMake(tip.location.latitude, tip.location.longitude);
        }
        
        [self.mapView convertCoordinate:coordinate toPointToView:self.mapView];
    }
}


#pragma mark - UISearchControllerDelegate

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
}

#pragma mark - MAMapViewDelegate
//实时获得用户的经纬度
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    _currentLocation = [userLocation.location copy];
    // 初次获取位置 执行一次即可
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self searchPOIWith:CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude)];
    });
}


- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {
    if (response.tips.count == 0) {
        return;
    } else {
        self.dataArray = response.tips;
        [self.tableView reloadData];
    }
}

// POI search
- (void)searchPOIWith:(CLLocationCoordinate2D)coordinate {
    oldCoordinate = coordinate;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    //request.keywords        = @"电影院";
    //request.types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = true;
    [MBProgressHUD showLoading:nil toView:self.tableView];
    [self.search AMapPOIAroundSearch:request];
}
/** POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response.pois.count == 0) return;
    NSLog(@"%zd", response.pois.count);
    //解析response获取POI信息，具体解析见 Demo
    self.dataArray = [NSArray arrayWithArray:response.pois];
    [MBProgressHUD hideAllHUDsInView:self.tableView];
    // 周边搜索完成后，刷新tableview
    [self.tableView reloadData];
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // 根据屏幕位置转换地图坐标经纬度
    CLLocationCoordinate2D markCoordinate = [self.mapView convertPoint:_iv_mapMark.frame.origin toCoordinateFromView:self.mapView];
    double distance = [self distanceBetweenOrderBy:markCoordinate.latitude :oldCoordinate.latitude :markCoordinate.longitude :oldCoordinate.longitude];
    if (distance > 100) {
        [self searchPOIWith:markCoordinate];
    }
}

//当点击定位annotion时进行逆地理编程进行编码查询
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self initAction];
    }
}

//发起逆地理编码请求
- (void)initAction{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
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

- (UIImageView *)iv_mapMark {
    if (!_iv_mapMark) {
        _iv_mapMark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(15.f), DDFitHeight(30.f))];
//        //        _iv_mapMark.center = self.mapView.center;
//        _iv_mapMark.center = CGPointMake(kScreenWidth/2, 126);
        _iv_mapMark.image = kImage(@"TJLocationHere");
    }
    return _iv_mapMark;
}


- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

- (TJSearchResultController *)searchResultController {
    if (!_searchResultController) {
        kWeakSelf
        _searchResultController = [[TJSearchResultController alloc] init];
        _searchResultController.suggestionResultBlock = ^(AMapTip *tip) {
            AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
            tips.keywords = tip.name;
            // 设置搜索范围的关键地名
            tips.city = curUser.city ? curUser.city : @"北京市";
            tips.location = [NSString stringWithFormat:@"%@,%@", curUser.longitude, curUser.latitude];
            [weakSelf.search AMapInputTipsSearch:tips];
            weakSelf.searchController.active = false;
        };
    }
    return _searchResultController;
}

// 计算两坐标点之间的距离
-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    //地球半径
    int R = 6378137;
    //将角度转为弧度
    float radLat1 = [self radians:lat1];
    float radLat2 = [self radians:lat2];
    float radLng1 = [self radians:lng1];
    float radLng2 = [self radians:lng2];
    //结果
    float s = acos(cos(radLat1)*cos(radLat2)*cos(radLng1-radLng2)+sin(radLat1)*sin(radLat2))*R;
    //精度
    s = round(s* 10000)/10000;
    return  round(s);
}
- (float)radians:(float)degrees{
    return (degrees*M_PI)/180.0;
}

- (void)backLocal:(UIButton *)sender {
    [self.mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
}

- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)okAction {
    if (_locationAddressSelectBlcok) {
        _locationAddressSelectBlcok(_dataArray[_index]);
    }
    [self pop];
}


@end
