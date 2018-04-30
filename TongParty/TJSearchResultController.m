//
//  TJSearchResultController.m
//  TongParty
//
//  Created by tojoin on 2018/4/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJSearchResultController.h"
#import "LSDateSortCell.h"


@interface TJSearchResultController ()<AMapSearchDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation TJSearchResultController

- (void)createUI {
    [self.view addSubview:self.tableView];
    self.tableView.hidden = false;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(-44, 0, -44, 0));
    }];
    [self.tableView  registerNib:[UINib nibWithNibName:@"LSDateSortCell" bundle:nil] forCellReuseIdentifier:@"LSDateSortCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSDateSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LSDateSortCell"];
    if (!cell) {
        cell = [[LSDateSortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LSDateSortCell"];
    }

    AMapTip *tip = self.dataSource[indexPath.row];
    cell.lbl_week.text = tip.name;
    cell.lbl_date.text = [NSString stringWithFormat:@"%@%@",tip.district,tip.address];
    cell.lbl_week.font = [UIFont systemFontOfSize:15];
    cell.lbl_date.font = [UIFont systemFontOfSize:11];
    cell.lbl_week.textAlignment = NSTextAlignmentLeft;
    cell.lbl_date.textAlignment = NSTextAlignmentLeft;
    cell.lbl_week.textColor = [UIColor hx_colorWithHexString:@"#262626"];
    cell.lbl_date.textColor = [UIColor hx_colorWithHexString:@"#617B94"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AMapTip *tip = self.dataSource[indexPath.row];
    if (_suggestionResultBlock) {
        _suggestionResultBlock(tip);
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchStr = searchController.searchBar.text;
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = searchStr;
    // 设置搜索范围的关键地名
    tips.city = !curUser.city ? @"北京市" : curUser.city;
    tips.location = [NSString stringWithFormat:@"%@,%@", curUser.longitude, curUser.latitude];
    [self.search AMapInputTipsSearch:tips];
}




- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {
    if (response.tips.count == 0) {
        return;
    } else {
        self.dataSource = response.tips;
        [self.tableView reloadData];
    }
}

- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}


@end
