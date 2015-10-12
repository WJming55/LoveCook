//
//  BestTableViewCell.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;


@end
