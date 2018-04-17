//
//  TJThemeView.h
//  TongParty
//
//  Created by tojoin on 2018/4/11.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJBaseView.h"
#import "TJThemeModel.h"

typedef void (^ThemeName)(NSString *);

@interface TJThemeView : TJBaseView


@property (nonatomic, copy)   ThemeName               themeNameBlock;
@property (nonatomic, strong) NSArray<TJThemeModel *> *themeModelArr;

- (void)updateData:(NSArray *)arr;

@end
