//
//  MyCollectionViewCell.m
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    
}

-(void)shouDataWithModel:(TopRecommendsModel *)model{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!m2"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];

}

@end
