//
//  FirstTableViewCell.h
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopRecommendsModel.h"

@interface FirstTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property(nonatomic,strong) TopRecommendsModel *topModel;
@property(nonatomic,strong)NSMutableArray *ary;

-(void)shouDataWithModel:(NSArray *)array;

@end
