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
        NSError *error;
        [contactStore enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [contactArr addObject:contact];
        }];

//        NSLog(@"error%@", error);
//
//        for (NSInteger i = 0; i < contactArr.count; i++) {
//            CNContact *contact = contactArr[i];
//            NSLog(@"%@%@=%@", contact.givenName, contact.familyName, contact.phoneNumbers);
//        }
        
        self.dataSource = [self sortObjectsAccordingToInitialWith:contactArr];
        [self.tableView reloadData];
    });
}

- (void)createUI {
    
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 68;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.sectionIndexColor = [UIColor hx_colorWithHexString:@"#9092A5"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(ios 11.0,*)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0);
        } else {
            make.top.mas_equalTo(0);
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
        cell.contentL.text = contact.phoneNumbers[0].value.stringValue;
    }
    return cell;
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
    
    //将每个名字分到某个section下
    for (CNContact *contact in arr) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        
        NSInteger sectionNumber = [collation sectionForObject:contact collationStringSelector:@selector(familyName)];
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:contact];
    }
    
    //对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(familyName)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    //删除空的数组
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
    
//    return newSectionsArray;
}


@end
