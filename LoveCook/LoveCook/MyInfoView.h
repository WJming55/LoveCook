//
//  MyInfoView.h
//  LoveCook
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLOCK) (void);

@interface MyInfoView : UIView
@property(nonatomic,copy)BLOCK myblock;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *addlabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
