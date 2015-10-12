//
//  MyCollectionViewCell.h
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopRecommendsModel.h"

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)shouDataWithModel:(TopRecommendsModel *)model;

@end
