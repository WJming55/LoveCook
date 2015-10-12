//
//  CreateCell1.m
//  LoveCook
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "CreateCell1.h"

@implementation CreateCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteClick:(id)sender {
    UIButton *button=(UIButton *)sender;
    NSLog(@"%ld",button.tag);
    self.myBlock1();
}
@end
