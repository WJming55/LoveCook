//
//  FriendTitleViewCell.m
//  LoveCook
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "FriendTitleViewCell.h"

@implementation FriendTitleViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.guanButton.layer.cornerRadius=10;
    self.guanButton.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
