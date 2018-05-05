//
//  TJContactController.m
//  TongParty
//
//  Created by tojoin on 2018/4/29.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJContactController.h"
#import <Contacts/Contacts.h>
#import "TJContactCell.h"

@interface TJContactController ()

@property (nonatomic, strong) NSArray *headTitleArr;

@end

@implementation TJContactController

- (void)createData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey]];
        NSMutableArray *contactArr = [NSMutableArray array];
        NSMutableArray *phoneArr = [NSMutableArray array];
        NSError *error;
        [contactStore enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [contactArr addObject:contact];
            if (contact.phoneNumbers.count) {
                [phoneArr addObject:[self clean:contact.phoneNumbers[0].value.stringValue]];
            }
        }];
        
        self.dataSource = [self sortObjectsAccordingToInitialWith:contactArr];
        [self.tableView reloadData];
        
        if(kiPhoen)
            [self requestData:@[@"15210030317", @"18519269520"]];
        else {
            [self requestData:phoneArr];
        }
        
    });
}

- (void)createUI {
    UIButton *_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
            make.top.mas_equalTo(23);
        }
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(48, 38));
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"添加好友";
    titleLabel.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(12);
        } else {
            make.top.mas_equalTo(32);
        }
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(58, 20));
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
    
    
    UIImageView *_headImage1 = [[UIImageView alloc] init];
    _headImage1.image = kImage(@"Image-0");
    _headImage1.layerCornerRadius = 24;
    [self.view addSubview:_headImage1];
    [_headImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+15);
        } else {
            make.top.mas_equalTo(64+15);
        }
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    UILabel *_titleL1 = [[UILabel alloc] init];
    _titleL1.text = @"丽萨";
    _titleL1.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _titleL1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_titleL1];
    [_titleL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+14);
        } else {
            make.top.mas_equalTo(64+14);
        }
        make.left.mas_equalTo(88);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *_contentL1 = [[UILabel alloc] init];
    _contentL1.text = @"通讯录好友张家家";
    _contentL1.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _contentL1.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_contentL1];
    [_contentL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+47);
        } else {
            make.top.mas_equalTo(64+47);
        }
        make.left.mas_equalTo(88);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(19);
    }];
    
    UIButton *_actionBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionBtn1 setTitle:@"已关注" forState:UIControlStateNormal];
    [_actionBtn1 setTitle:@"+ 关注" forState:UIControlStateSelected];
    _actionBtn1.titleLabel.font = [UIFont systemFontOfSize:10];
    [_actionBtn1 setBackgroundImage:kImage(@"TJButtonSelect") forState:UIControlStateNormal];
    [_actionBtn1 setBackgroundImage:kImage(@"TJButtonNormal1") forState:UIControlStateSelected];
    _actionBtn1.layerCornerRadius = 15;
    [self.view addSubview:_actionBtn1];
    [_actionBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+24);
        } else {
            make.top.mas_equalTo(64+24);
        }
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(62, 30));
    }];
    
    
    UIView *line2 = [[UIView alloc] init];
    [self.view addSubview:line2];
    line2.backgroundColor = kSeparateLine;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+78);
        } else {
            make.top.mas_equalTo(64+78);
        }
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *_headImage2 = [[UIImageView alloc] init];
    _headImage2.image = kImage(@"Image-1");
    _headImage2.layerCornerRadius = 24;
    [self.view addSubview:_headImage2];
    [_headImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+15+78);
        } else {
            make.top.mas_equalTo(64+15+78);
        }
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    UILabel *_titleL2 = [[UILabel alloc] init];
    _titleL2.text = @"丽萨";
    _titleL2.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    _titleL2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_titleL2];
    [_titleL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+14+78);
        } else {
            make.top.mas_equalTo(64+14+78);
        }
        make.left.mas_equalTo(88);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *_contentL2 = [[UILabel alloc] init];
    _contentL2.text = @"通讯录好友张家家";
    _contentL2.textColor = [UIColor hx_colorWithHexString:@"#738CA5"];
    _contentL2.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_contentL2];
    [_contentL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+47+78);
        } else {
            make.top.mas_equalTo(64+47+78);
        }
        make.left.mas_equalTo(88);
        make.right.mas_equalTo(-108);
        make.height.mas_equalTo(19);
    }];
    
    UIButton *_actionBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionBtn2 setTitle:@"已关注" forState:UIControlStateNormal];
    [_actionBtn2 setTitle:@"+ 关注" forState:UIControlStateSelected];
    _actionBtn2.titleLabel.font = [UIFont systemFontOfSize:10];
    [_actionBtn2 setBackgroundImage:kImage(@"TJButtonSelect") forState:UIControlStateNormal];
    [_actionBtn2 setBackgroundImage:kImage(@"TJButtonNormal1") forState:UIControlStateSelected];
    _actionBtn2.layerCornerRadius = 15;
    [self.view addSubview:_actionBtn2];
    [_actionBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44+24+78);
        } else {
            make.top.mas_equalTo(64+24+78);
        }
        
        make.right.mas_equalTo(-24);
        make.size.mas_equalTo(CGSizeMake(62, 30));
    }];
    
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 68;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.sectionIndexColor = [UIColor hx_colorWithHexString:@"#9092A5"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(229);
        } else {
            make.top.mas_equalTo(249);
        }
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJContactCellID"];
    if (!cell) {
        cell = [[TJContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TJContactCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CNContact *contact = self.dataSource[indexPath.section][indexPath.row];
    cell.titleL.text = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
    if (contact.phoneNumbers.count) {
        cell.contentL.text = [self clean:contact.phoneNumbers[0].value.stringValue];
    }
    return cell;
}

- (NSString *)clean:(NSString *)phoneNum {
    NSString *phone = [phoneNum copy];
    phone = [[phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    if (phone.length>11) {
        phone = [phone substringWithRange:NSMakeRange(phone.length-11, 11)];
    }
    return phone;
}

#pragma mark - UITableViewDelegate
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return self.headTitleArr[section];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 26)];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, kScreenWidth, 26)];
    title.text = self.headTitleArr[section];
    [view addSubview:title];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 26;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.headTitleArr;
}

// 按首字母分组排序数组
-(NSMutableArray *)sortObjectsAccordingToInitialWith:(NSArray *)arr {
    
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *indexArr = [NSMutableArray arrayWithArray:[collation sectionIndexTitles]];
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    //初始化一个数组newSectionsArray用来存放最终的数据，我们最终要得到的数据模型应该形如@[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //初始化27个空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    // 将每个名字分到某个section下
    for (CNContact *contact in arr) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        
        NSInteger sectionNumber = [collation sectionForObject:contact collationStringSelector:@selector(familyName)];
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:contact];
    }
    
    // 对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(familyName)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    // 删除空的数组
    NSMutableArray *finalArr = [NSMutableArray new];
    NSMutableArray *headTitleArr = [NSMutableArray new];
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        if (((NSMutableArray *)(newSectionsArray[index])).count != 0) {
            [finalArr addObject:newSectionsArray[index]];
            [headTitleArr addObject:indexArr[index]];
        }
    }
    self.headTitleArr = [headTitleArr copy];
    return finalArr;
}


- (void)requestData:(NSArray *)mobiles {
    [DDResponseBaseHttp getWithAction:kTJPhoneList params:@{@"token":curUser.token,@"mobiles":mobiles} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
    } failure:^{
        
    }];
}
- (void)closeAction {
    [self.navigationController popViewControllerAnimated:true];
}

@end
