//
//  TJEditProfileController.m
//  TongParty
//
//  Created by tojoin on 2018/4/21.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJEditProfileController.h"
#import "TJEditProfileCell.h"
#import "TJEditNicknameView.h"
#import "TJSexView.h"
#import "TJPickerDate.h"
#import "TJAddrPicker.h"
#import "TJProfession.h"
#import "TJEditProfileModel.h"
#import "TJProfessionModel.h"
#import <TZImagePickerController/TZImagePickerController.h>


@interface TJEditProfileController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}

@property (nonatomic, strong) NSArray               *keyIndexArr;
@property (nonatomic, strong) TJEditNicknameView    *editNicknameView;
@property (nonatomic, strong) TJSexView             *sexView;
@property (nonatomic, strong) TJPickerDate          *pickerDate;
@property (nonatomic, strong) TJAddrPicker          *addrPicker;
@property (nonatomic, strong) TJProfession          *profession;

@property (nonatomic, strong) TJEditProfileModel    *profileModel;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@end

@implementation TJEditProfileController

- (void)createData {
    _keyIndexArr = @[@"nickname", @"sex", @"birthday", @"city", @"school", @"occupation"];

    // 头像相关
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
}
- (void)createUI {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
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
        make.left.mas_equalTo(self.view).offset(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    YYLabel *titleLabel = [[YYLabel alloc] init];
    [self.view addSubview:titleLabel];
    if (_act) {
        titleLabel.text = @"个人资料";
    } else
        titleLabel.text = @"编辑个人资料";
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
    
    if (!_act) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_okBtn setTitleColor:kBtnEnable forState:UIControlStateNormal];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _okBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [self.view addSubview:_okBtn];
        [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0,*)) {
                make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(3);
            } else {
                make.top.mas_equalTo(self.view).offset(23);
            }
            make. trailing.mas_equalTo(self.view).offset(-14);
            make.size.mas_equalTo(CGSizeMake(48, 38));
        }];
    }
    
    
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kSeparateLine;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [_cancelBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [_okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    if (!_act)
        [headImage sd_setImageWithURL:[NSURL URLWithString:curUser.image]];
    headImage.tag = 1823;
    headImage.layerCornerRadius = 31;
    [self.view addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(68);
        } else {
            make.top.mas_equalTo(88);
        }
        make.left.mas_equalTo(24);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    if (!_act) {
        UIButton *editHeadImageBtn = [[UIButton alloc] init];
        [editHeadImageBtn setTitle:@"更换头像" forState:UIControlStateNormal];
        editHeadImageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        editHeadImageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [editHeadImageBtn setTitleColor:[UIColor hx_colorWithHexString:@"#262626"] forState:UIControlStateNormal];
        [editHeadImageBtn addTarget:self action:@selector(editHeadImageAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:editHeadImageBtn];
        [editHeadImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headImage);
            make.left.mas_equalTo(headImage.mas_right).offset(24);
            make.right.mas_equalTo(-24);
            make.height.mas_equalTo(22);
        }];
        
        UIButton *_moreBtn = [[UIButton alloc] init];
        [_moreBtn setImage:[UIImage imageNamed:@"TJMoreBtn"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(editHeadImageAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_moreBtn];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headImage);
            make.trailing.mas_equalTo(-24);
            make.size.mas_equalTo(CGSizeMake(9, 15));
        }];
    }
    
    self.dataSource = @[@"昵称", @"性别", @"生日", @"城市", @"学校", @"职业"];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 67;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(159);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-kTabBarHeigthOrigin);
        } else {
            make.top.mas_equalTo(179);
            make.bottom.mas_equalTo(-kTabBarHeight);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_act) {
        [self requestDataWithUid:_act];
    } else
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
    TJEditProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJEditProfileCellID"];
    if (!cell) {
        cell = [[TJEditProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJEditProfileCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.bCouldEdit = false;
    [cell updateData:self.dataSource[indexPath.row]];
    if (indexPath.row == 0){
        [cell updateValue:_profileModel.nickname];
        [cell updateMoreBtn];
    } else if (indexPath.row == 1) {// 性别
        NSString *sex = _profileModel.sex;
        if ([sex isEqualToString:@"0"]) {
            sex = @"保密";
        } else if ([sex isEqualToString:@"1"]) {
            sex = @"男";
        } else if ([sex isEqualToString:@"2"]) {
            sex = @"女";
        }
        [cell updateValue:sex];
        
    } else if (indexPath.row == 2) {
        [cell updateValue:_profileModel.birthday];
    } else if (indexPath.row == 3) {
        NSString *city = [NSString stringWithFormat:@"%@%@",_profileModel.city, _profileModel.district];
        [cell updateValue:city];
    } else if (indexPath.row == 4) {
        cell.bCouldEdit = true;
        kWeakSelf
        cell.endEdit = ^(NSString *school) {
            weakSelf.profileModel.school = school;
        };
        [cell updateValue:_profileModel.school];
        [cell updateMoreBtn];
    } else if (indexPath.row == 5) {
        if (_profileModel.profession) {
            [cell updateValue:_profileModel.profession];
        } else {
            [cell updateValue:_profileModel.occupation];
        }
    }
    
        
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_act) return;
    kWeakSelf
    if (indexPath.row == 0) {
        [self.view addSubview:self.editNicknameView];
        [_editNicknameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
        }];
        _editNicknameView.complete = ^(NSString *input) {
            if (input.length) {
                weakSelf.profileModel.nickname = input;
                [weakSelf.tableView reloadData];
            }
        };
        [_editNicknameView.inputTF becomeFirstResponder];
    } else if (indexPath.row == 1) {
        [self.view addSubview:self.sexView];
        [_sexView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0,*)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(170);
        }];
        _sexView.complete = ^(NSString *sex) {
            weakSelf.profileModel.sex = sex;
            [weakSelf.tableView reloadData];
        };
    } else if (indexPath.row == 2) {
        [self.view addSubview:self.pickerDate];
        [_pickerDate mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0,*)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(275);
        }];
        
        _pickerDate.complete = ^(NSString *birthday) {
            weakSelf.profileModel.birthday = birthday;
            [weakSelf.tableView reloadData];
        };
        
    } else if (indexPath.row == 3) {
        [self.view addSubview:self.addrPicker];
        [_addrPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0,*)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(216);
        }];
        
        _addrPicker.complete = ^(NSString *city) {
            weakSelf.profileModel.city = city;
        };
        
        _addrPicker.districtBlock = ^(NSString *district) {
            weakSelf.profileModel.district = district;
            [weakSelf.tableView reloadData];
        };
    } else if (indexPath.row == 4) {
        
    } else if (indexPath.row == 5) {
        [self.view addSubview:self.profession];
        [_profession mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(ios 11.0,*)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(449);
        }];
        
        _profession.complete = ^(NSString *career) {
            weakSelf.profileModel.occupation = career;
            [weakSelf.tableView reloadData];
        };
        
        [self requestProfession:^{
            
        }];
    }
}


- (void)requestProfession:(void (^)())success {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJCareerList params:@{@"token":curUser.token} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        NSArray *array = [TJProfessionModel mj_objectArrayWithKeyValuesArray:result.data];
        [weakSelf.profession updateData:array];
    } failure:^{
        
    }];
}


- (TJProfession *)profession {
    if (!_profession) {
        _profession = [[TJProfession alloc] init];
    }
    return _profession;
}

- (TJAddrPicker *)addrPicker {
    if (!_addrPicker) {
        _addrPicker = [[TJAddrPicker alloc] init];
    }
    return _addrPicker;
}

- (TJPickerDate *)pickerDate {
    if (!_pickerDate) {
        _pickerDate = [[TJPickerDate alloc] init];
    }
    return _pickerDate;
}

- (TJSexView *)sexView {
    if (!_sexView) {
        _sexView = [[TJSexView alloc] init];
    }
    return _sexView;
}

- (TJEditNicknameView *)editNicknameView {
    if (!_editNicknameView) {
        _editNicknameView = [[TJEditNicknameView alloc] init];
    }
    return  _editNicknameView;
}


- (void)editHeadImageAction {
    NSLog(@"更换头像");
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [self takePhoto];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheet addAction:deleteAction];
    [sheet addAction:photoAction];
    [sheet addAction:cancelAction];
    
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)closeAction {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否放弃修改" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [self.navigationController popViewControllerAnimated:true];
    }];
    
    [ac addAction:cancel];
    [ac addAction:ok];
    
    [self presentViewController:ac animated:true completion:nil];
    
   
}

- (void)okAction {
    // 完成
    [DDResponseBaseHttp getWithAction:kTJReplenishInfo params:[_profileModel mj_keyValues] type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            [MBProgressHUD showMessage:result.msg_cn];
            [self.navigationController popViewControllerAnimated:true];
        }
    } failure:^{
        
    }];
}

- (void)requestDataWithUid:(NSString *)uid {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJUserInfo params:@{@"token":curUser.token, @"act":@"others", @"uid":uid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            NSDictionary *data = result.data;
            weakSelf.profileModel = [TJEditProfileModel mj_objectWithKeyValues:data];
            [weakSelf.tableView reloadData];
            UIImageView *iv = [weakSelf.view viewWithTag:1823];
            [iv sd_setImageWithURL:[NSURL URLWithString:result.data[@"head_image"]]];
        }
    } failure:^{
        
    }];
}

- (void)requestData {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJUserInfo params:@{@"token":curUser.token, @"act":@"my"} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            NSDictionary *data = result.data;
            weakSelf.profileModel = [TJEditProfileModel mj_objectWithKeyValues:data];
            weakSelf.profileModel.token = curUser.token;
            [weakSelf.tableView reloadData];
        }
    } failure:^{
        
    }];
}


- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        if (@available(ios 7.0, *)) {
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        
        if (@available(ios 9.0, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        [self alertWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" style:UIAlertControllerStyleAlert cancel:^{
            
        } ok:^{
            if (@available(ios 8.0, *)) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            }
        }];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (@available(ios 7.0, *)) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        
        [self alertWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" style:UIAlertControllerStyleAlert cancel:^{
            
        } ok:^{
            if (@available(ios 8.0, *)) {

                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            }
        }];
        
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(void (^)())cancel ok:(void (^)())ok {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancel();
    }];
    [ac addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ok();
    }];
    [ac addAction:okAction];
}


// 调用相机
- (void)pushImagePickerController {
    // 提前定位
//    __weak typeof(self) weakSelf = self;
//    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = [locations firstObject];
//    } failureBlock:^(NSError *error) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = nil;
//    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(@available(ios 8.0, *)) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = false;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        [self uploadHeadImage:image];
        

        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(NSError *error){
//            if (error) {
//                [tzImagePickerVc hideProgressHUD];
//                NSLog(@"图片保存失败 %@",error);
//            } else {
//                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
//                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
//                        TZAssetModel *assetModel = [models firstObject];
//                        if (tzImagePickerVc.sortAscendingByModificationDate) {
//                            assetModel = [models lastObject];
//                        }

//                        if (self.allowCropSwitch.isOn) { // 允许裁剪,去裁剪
//                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
//                                [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
//                            }];
//                            imagePicker.needCircleCrop = self.needCircleCropSwitch.isOn;
//                            imagePicker.circleCropRadius = 100;
//                            [self presentViewController:imagePicker animated:YES completion:nil];
//                        } else {
//                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
//                        }
//                    }];
//                }];
//            }
        }];
    }
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {

    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = false;
    
//    if (self.maxCountTF.text.integerValue > 1) {
//        // 1.设置目前已经选中的图片数组
//        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
//    }
    imagePickerVc.allowTakePicture = true; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = false;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // if (iOS7Later) {
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // }
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = false;
    imagePickerVc.allowPickingImage = true;
    imagePickerVc.allowPickingOriginalPhoto = false;
    imagePickerVc.allowPickingGif = false;
    imagePickerVc.allowPickingMultipleVideo = false; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = true;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = true;
    imagePickerVc.needCircleCrop = false;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 5;
    NSInteger widthHeight = self.view.width -2 * left;
    NSInteger top = (self.view.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
         cropView.layer.borderColor = kBtnEnable.CGColor;
         cropView.layer.borderWidth = 2.0;
     }];
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleDefault;
    [imagePickerVc setNaviBgColor:[UIColor whiteColor]];
    [imagePickerVc setNaviTitleColor:kBtnEnable];
    [imagePickerVc setBarItemTextColor:kBtnEnable];
    
    // 设置首选语言 / Set preferred language
    // imagePickerVc.preferredLanguage = @"zh-Hans";
    
    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self uploadHeadImage:[photos firstObject]];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)uploadHeadImage:(UIImage *)image {
    [DDResponseBaseHttp uploadImageWithAction:kTJChangeHeadPicture params:@{@"token":curUser.token} image:image success:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            UIImageView *iv = [self.view viewWithTag:1823];
            iv.image = image;
            curUser.image = result.data[@"head_image"];
            [userManager saveUserInfo];
        }
    } fail:^{
    }];
}

@end
