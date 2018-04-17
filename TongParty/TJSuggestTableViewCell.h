//
//  TJSuggestTableViewCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/14.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJSuggestTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *circleMark;
@property (nonatomic, strong) YYLabel     *selectedLabel;
@property (nonatomic, strong) UIImageView *selectedMark;
@property (nonatomic, strong) YYLabel *titleLabel;
@property (nonatomic, strong) YYLabel *addrLabel;

@end
