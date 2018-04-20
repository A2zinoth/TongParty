//
//  TJAnimation.h
//  TongParty
//
//  Created by tojoin on 2018/4/19.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJAnimation : NSObject

+ (CALayer *)replicatorLayer_Circle;
+ (CALayer *)replicatorLayer_Wave;
+ (CALayer *)replicatorLayer_Triangle;
+ (CALayer *)replicatorLayer_Grid;

+ (CABasicAnimation *)alphaAnimation;
+ (CABasicAnimation *)scaleAnimation;

@end
