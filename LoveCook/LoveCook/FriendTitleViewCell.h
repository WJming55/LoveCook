//
//  FriendTitleViewCell.h
//  LoveCook
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendTitleViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *phoneBUtton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UIButton *fanCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *guanCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *guanButton;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end
