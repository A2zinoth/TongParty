//
//  TJTableCollectionViewCell.h
//  TongParty
//
//  Created by tojoin on 2018/4/26.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJTableCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel     *titleL;
@property (nonatomic, strong) UILabel     *timeL;


@property (nonatomic, strong) UIImageView *beginImage;
@property (nonatomic, strong) UILabel     *status;

- (void)updateTime:(NSString *)beginTime serviceTime:(NSString*)serviceTime;
- (void)updateMaster:(NSString *)bMaster;
- (void)showBeginImage:(BOOL)b;
- (void)updateMember:(NSArray *)arr;

@end
