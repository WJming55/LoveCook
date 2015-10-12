//
//  TodarFoodTableViewCell.m
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//
#import "MyTabBarViewController.h"
#import "TodarFoodTableViewCell.h"
#import "MyCollectionViewCell.h"
#import "WebViewController.h"

@interface TodarFoodTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation TodarFoodTableViewCell

- (void)awakeFromNib {
   
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"TodarCellId"];
    
}

-(void)shouDataWithModel:(NSArray *)array{
    if (array.count>0) {
        self.ary=[[NSMutableArray alloc] initWithArray:array];
        //[self.ary addObjectsFromArray:array];
        NSLog(@"1111111111111");
        [self.collectionView reloadData];
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.ary.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TodarCellId" forIndexPath:indexPath];
    if (self.ary.count>0) {
        TopRecommendsModel *model=[self.ary objectAtIndex:indexPath.row];
        [cell shouDataWithModel:model];
    }
    return  cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    TopRecommendsModel *model=[self.ary objectAtIndex:indexPath.row];
    WebViewController *web=[[WebViewController alloc] init];
    web.urlStr=model.uri;
    
    UIWindow *widown=[[UIApplication sharedApplication] keyWindow];
    MyTabBarViewController *mvc=(MyTabBarViewController *)widown.rootViewController;
    NSArray *ary=[mvc viewControllers];
    UINavigationController *nvc=ary[0];
    
    [nvc.topViewController.navigationController pushViewController:web animated:YES];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



















