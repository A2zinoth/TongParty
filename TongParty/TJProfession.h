//
//  TJProfession.h
//  TongParty
//
//  Created by tojoin on 2018/4/23.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"
#import "TJProfessionModel.h"

typedef void (^SelectedContent)(NSString *);

@interface TJProfession : TJBaseView

@property (nonatomic, strong) UIView                        *maskView;
@property (nonatomic, copy)   NSString                      *selectedContent;
@property (nonatomic, copy)   SelectedContent               selectedBlock;
@property (nonatomic, strong) NSArray<TJProfessionModel *>  *dataArr;


- (void)updateData:(NSArray *)arr;

@end
