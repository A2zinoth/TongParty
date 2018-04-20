//
//  TJShortCutCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJShortCutCell : UITableViewCell

@property (nonatomic, strong) UILabel *content;

- (void)updateWithContent:(NSDictionary *)dic;

@end
