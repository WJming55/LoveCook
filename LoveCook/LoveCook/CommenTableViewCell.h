//
//  CommenTableViewCell.h
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopRecommendsModel.h"

@interface CommenTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *phoneView1;
@property (weak, nonatomic) IBOutlet UIImageView *phoneView2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void)showDataWithMOdel:(TopRecommendsModel *)model;

@end
