//
//  TJRegisterModel.m
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJRegisterModel.h"

@implementation TJRegisterModel


- (void)uniquenes:(NSString *)mobile success:(void (^)(id))success {
    [DDTJHttpRequest uniquenessWithPhone:mobile success:^(NSString *status) {
        success(status);
    }];
}

@end
