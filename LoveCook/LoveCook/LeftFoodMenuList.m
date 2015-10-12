//
//  LeftFoodMenuList.m
//  LoveCook
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "LeftFoodMenuList.h"

@implementation LeftFoodMenuList


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self creatView];
    
}
-(void)creatView{
    NSLog(@"wwwwwwwwwww");
    self.tableView=[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self addSubview:self.tableView];

}


@end
