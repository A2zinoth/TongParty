//
//  TJButton.m
//  TongParty
//
//  Created by tojoin on 2018/4/12.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "TJButton.h"

@implementation TJButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, self.size.width, self.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
