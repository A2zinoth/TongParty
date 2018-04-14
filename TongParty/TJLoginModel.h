//
//  TJLoginModel.h
//  Tojoin
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 Beijing Tojoin Network Technology Co., Ltd. All rights reserved.
//

#import "DDLoginManager.h"


@interface TJLoginModel : NSObject

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) DDLoginManager *loginManager;

- (void)login:(void (^)(void))success;
- (void)thirdLogin:(NSInteger)sender;

@end
