//
//  CommenTableViewCell.m
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "CommenTableViewCell.h"
#import "UIImageView+WebCache.h"


@implementation CommenTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showDataWithMOdel:(TopRecommendsModel *)model{
    self.titleLabel.text=model.title;
    self.nameLabel.text=model.author;
    NSString *str=[model.uptime substringToIndex:10];
    self.timeLabel.text=str;
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!m2"];
    [self.phoneView1 sd_setImageWithURL:[NSURL URLWithString:urlString]];
    

}


@end
