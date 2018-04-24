//
//  TJProfileCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/20.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJProfileCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

- (void)updateData:(NSString *)data;

@end
