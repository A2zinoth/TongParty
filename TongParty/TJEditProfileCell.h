//
//  TJEditProfileCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/21.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EndEdit)(NSString *);

@interface TJEditProfileCell : UITableViewCell

@property (nonatomic, strong) UILabel     *titleL;
@property (nonatomic, strong) UILabel     *valueL;
@property (nonatomic, strong) UITextField *editTF;
@property (nonatomic, assign) BOOL        bCouldEdit;
@property (nonatomic, copy)   EndEdit     endEdit;

- (void)updateData:(NSString *)data;
- (void)updateValue:(NSString *)value;
- (void)updateMoreBtn;
- (void)hiddenRightAccessory;

@end
