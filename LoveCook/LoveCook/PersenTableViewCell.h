//
//  PersenTableViewCell.h
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersenTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image1;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rebacklabel;
@property (weak, nonatomic) IBOutlet UILabel *timtLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UILabel *enjoyLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
