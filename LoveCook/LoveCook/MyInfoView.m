//
//  MyInfoView.m
//  LoveCook
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "MyInfoView.h"

@implementation MyInfoView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addGestureToView:self];
}
- (void)addGestureToView:(UIView *)view {
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [view addGestureRecognizer:gesture];
}
-(void)tapAction:(UITapGestureRecognizer *)gesture{
    self.myblock();
}


@end
