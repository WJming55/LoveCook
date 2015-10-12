//
//  TodarFoodTableViewCell.h
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodarFoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *ary;

-(void)shouDataWithModel:(NSArray *)array;
@end
