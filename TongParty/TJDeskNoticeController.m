//
//  TJDeskNoticeController.m
//  TongParty
//
//  Created by tojoin on 2018/4/15.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskNoticeController.h"
#import "TJDeskNoticeView.h"
#import "TJDeskNoticeCell.h"
#import "TJShortCutCell.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface TJDeskNoticeController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, assign) BOOL   isCloseAll;
@property (nonatomic, assign) float  keyboardHeight;
@property (nonatomic, strong) TJDeskNoticeView *noticeBottomView;
@property (nonatomic, strong) UITableView *shortcutTableView;
@property (nonatomic, strong) NSArray *shortcutArr;

@end

@implementation TJDeskNoticeController
- (void)createData {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    self.keyboardHeight = 258;
    _isCloseAll = false;
}
- (void)createUI {
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 88;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight-57-60-HOME_INDICATOR_HEIGHT);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(dismissKeyboard)];
    [self.tableView addGestureRecognizer:tap];
    
    _noticeBottomView = [[TJDeskNoticeView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kNavigationBarHeight-57-60-HOME_INDICATOR_HEIGHT, kScreenWidth, 57)];
    [self.view addSubview:_noticeBottomView];
    
    [_noticeBottomView.keyboardBtn addTarget:self action:@selector(keyboardAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shortcutTableView];
    
    _shortcutTableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.keyboardHeight);
    _shortcutTableView.backgroundColor = kWhiteColor;
    _noticeBottomView.input.delegate = self;
}

- (void)keyboardAction:(UIButton *)btn {
    if ([self canEdit]) {
        if (btn.selected) {// 键盘
            [_noticeBottomView.input becomeFirstResponder];
            [self closeShortCut];
            btn.selected = false;
        } else { //短语
            [_noticeBottomView.input resignFirstResponder];
            _isCloseAll = false;
            [self openBottomBar];
            [self openShortCut];
            btn.selected = true;
        }
    }
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _noticeBottomView.keyboardBtn.selected = false;
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"点击了发送");
    [_noticeBottomView.input resignFirstResponder];
    [self requestSendNotice];

    return YES;
}


- (void)closeShortCut {
    kWeakSelf
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.shortcutTableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.keyboardHeight);
    }];
}

- (void)openShortCut {
    kWeakSelf
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.shortcutTableView.frame = CGRectMake(0, kScreenHeight-kNavigationBarHeight-60-HOME_INDICATOR_HEIGHT-self.keyboardHeight, kScreenWidth, self.keyboardHeight);
    }];
}

- (void)closeBottomBar {
    kWeakSelf
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.noticeBottomView.frame = CGRectMake(0, kScreenHeight-kNavigationBarHeight-57-60-HOME_INDICATOR_HEIGHT, kScreenWidth, 57);
    }];
}

- (void)openBottomBar {
    kWeakSelf
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight-57-60-HOME_INDICATOR_HEIGHT);
        weakSelf.noticeBottomView.frame = CGRectMake(0, kScreenHeight-kNavigationBarHeight-57-60-self.keyboardHeight, kScreenWidth, 57);
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    [self closeShortCut];
    [self closeBottomBar];
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    /* 获取键盘的高度 */
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = aValue.CGRectValue;
    self.keyboardHeight = keyboardRect.size.height;

    NSLog(@"keyboardH:%f", self.keyboardHeight);
    [self openBottomBar];
}

- (void)closeKeyBoard {
    [_noticeBottomView.input resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)canEdit {
    if ([[DDUserDefault objectForKey:@"is_master"] isEqualToString:@"1"])
        return true;
    else
        return false;
}


- (void)updateAuthority {
    if ([self canEdit]) {
        _noticeBottomView.input.enabled = true;
        _noticeBottomView.input.placeholder = @"请输入内容";
    } else {
        _noticeBottomView.input.enabled = false;
        _noticeBottomView.input.placeholder = @"只有桌主可以发公告";
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = false;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = true;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView)
        return self.dataSource.count;
    else
        return _shortcutArr.count;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        TJDeskNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJNoticeCellID"];
        if (!cell) {
            cell = [[TJDeskNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJNoticeCellID"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell updateWithDataArr:self.dataSource[indexPath.row]];
        return cell;
    } else {
        TJShortCutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJShortcutCellID"];
        if (!cell) {
            cell = [[TJShortCutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJShortcutCellID"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell updateWithContent:_shortcutArr[indexPath.row]];
        return cell;
    }
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _shortcutTableView) {
        _noticeBottomView.input.text = _shortcutArr[indexPath.row][@"notice_text"];
    } else {
        _noticeBottomView.keyboardBtn.selected = false;
        [self closeBottomBar];
        [self closeShortCut];
        [_noticeBottomView.input resignFirstResponder];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        _noticeBottomView.keyboardBtn.selected = false;
        [self closeBottomBar];
        [self closeShortCut];
    }
   
}

- (void)dismissKeyboard {
    _noticeBottomView.keyboardBtn.selected = false;
    [self closeBottomBar];
    [self closeShortCut];
    [_noticeBottomView.input resignFirstResponder];
}

- (UITableView *)shortcutTableView {
    if (!_shortcutTableView) {
        _shortcutTableView = [[UITableView alloc] init];
        _shortcutTableView.tableFooterView = [[UIView alloc] init];
        _shortcutTableView.delegate = self;
        _shortcutTableView.dataSource = self;
        _shortcutTableView.tag = 1620;
    }
    return _shortcutTableView;
}

- (void)requestSendNotice {
    NSString *input = _noticeBottomView.input.text;
    if (!input.length) {
        return;
    }
    
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJSendTableNotice params:@{@"token":[DDUserDefault objectForKey:@"token"], @"tid":self.tid, @"notice":_noticeBottomView.input.text} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if ([result.status isEqualToString:@"success"]) {
            [MBProgressHUD showMessage:result.msg_cn];
            [weakSelf requestNotice];
            weakSelf.noticeBottomView.input.text = @"";
        }
    } failure:^{
        
    }];
}

- (void)requestNotice {
    kWeakSelf
    [DDResponseBaseHttp getWithAction:kTJTableNotice params:@{@"token":[DDUserDefault objectForKey:@"token"], @"tid":self.tid} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        weakSelf.dataSource = result.data;
        [weakSelf.tableView reloadData];
    } failure:^{
        
    }];
    
    
    [DDResponseBaseHttp getWithAction:KTJNoticeList params:@{@"token":[DDUserDefault objectForKey:@"token"]} type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
                if ([result.status isEqualToString:@"success"]) {
                    weakSelf.shortcutArr = result.data;
                    [weakSelf.shortcutTableView reloadData];
                }
    } failure:^{
        
    }];
    

}

@end
