//
//  FirstTableViewCell.m
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Addition.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.collection.width=kScreenSize.width;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(kScreenSize.width, 86);
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    layout.minimumInteritemSpacing=0;
    layout.minimumLineSpacing=0;
    
    
    self.collection.collectionViewLayout=layout;
    
    self.collection.delegate=self;
    self.collection.dataSource=self;
    
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
    
    self.ary=[[NSMutableArray alloc] init];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)shouDataWithModel:(NSArray *)array{
    if (array.count>0) {
        [self.ary addObjectsFromArray:array];
        [self.collection reloadData];
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    if (self.ary.count>0) {
        TopRecommendsModel *model=[self.ary objectAtIndex:indexPath.row];
        UIImageView *view=[[UIImageView alloc] initWithFrame:cell.bounds];
        NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!m2"];
        [view sd_setImageWithURL:[NSURL URLWithString:urlString]];
       // http://pic.ecook.cn/web/11851728.jpg!m2
        [cell addSubview:view];
    }
    return cell;
}


@end











