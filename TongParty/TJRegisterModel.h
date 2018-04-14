//
//  TJRegisterModel.h
//  TongParty
//
//  Created by tojoin on 2018/4/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJRegisterModel : NSObject

- (void)uniquenes:(NSString *)mobile success:(void (^)(id))success;

@end
