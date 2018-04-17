//
//  TJDeskNoticeController.m
//  TongParty
//
//  Created by tojoin on 2018/4/15.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJDeskNoticeController.h"
#import "TJDeskNoticeView.h"

@interface TJDeskNoticeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) float  keyboardHeight;
@property (nonatomic, strong) TJDeskNoticeView *noticeBottomView;
@property (nonatomic, strong) UITableView *shortcutTableView;

@end

@implementation TJDeskNoticeController
- (void)createData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}
- (void)createUI {
    
    _noticeBottomView = [[TJDeskNoticeView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kNavigationBarHeight-57-60-HOME_INDICATOR_HEIGHT, kScreenWidth, 57)];
    [self.view addSubview:_noticeBottomView];
    
    [_noticeBottomView.keyboardBtn addTarget:self action:@selector(keyboardAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)keyboardAction:(UIButton *)btn {
    if (btn.selected) {
        
    } else { // 未选中
        
    }
    btn.selected = !btn.selected;
    [self.view addSubview:self.shortcutTableView];
    _shortcutTableView.frame = CGRectMake(0, kScreenHeight-kNavigationBarHeight-60-HOME_INDICATOR_HEIGHT-216, kScreenWidth, 216);
    _noticeBottomView.frame = CGRectMake(0, kScreenHeight-kNavigationBarHeight-57-60-HOME_INDICATOR_HEIGHT-216, kScreenWidth, 57);
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    /* 获取键盘的高度 */
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = aValue.CGRectValue;
    self.keyboardHeight = keyboardRect.size.height;
    NSLog(@"%f", _keyboardHeight);
    
    /* 输入框上移 */
    CGFloat padding = 20;
//    CGRect frame = self.registerButton.frame;
//    CGFloat height = kScreenHeight - frame.origin.y - frame.size.height;
//    if (height < keyboardRect.size.height + padding) {
    
        [UIView animateWithDuration:0.3 animations:^ {
            
            CGRect frame = self.view.frame;
//            frame.origin.y = -(keyboardRect.size.height - height + padding);
            self.view.frame = frame;
        }];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TJShortcutCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TJShortcutCellID"];
    }
    
    cell.textLabel.text = @"你好，请大家准时到活动地点";
    return cell;
}

- (UITableView *)shortcutTableView {
    if (!_shortcutTableView) {
        _shortcutTableView = [[UITableView alloc] init];
        _shortcutTableView.tableFooterView = [[UIView alloc] init];
        _shortcutTableView.delegate = self;
        _shortcutTableView.dataSource = self;
    }
    return _shortcutTableView;
}
@end
