//
//  MyFriendTableViewCell.m
//  LoveCook
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//
#import "MyTabBarViewController.h"
#import "MyFriendTableViewCell.h"
#import "TopRecommendsModel.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "FriendsInfoViewController.h"


@implementation MyFriendTableViewCell

- (void)awakeFromNib {
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
    
    self.ary=[[NSMutableArray alloc] init];
    
}
-(void)showImageWith:(NSArray *)array{
    if (array.count>0) {
        [self.ary addObjectsFromArray:array];
       
        
  }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ary.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    if (self.ary.count>0) {
        TopRecommendsModel *model=[self.ary objectAtIndex:indexPath.row];
        UIImageView *view=[[UIImageView alloc] initWithFrame:cell.bounds];
        NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!s3"];
        view.userInteractionEnabled=YES;
        view.layer.cornerRadius=20;
        view.layer.masksToBounds=YES;
        cell.backgroundColor=[UIColor clearColor];
        [view sd_setImageWithURL:[NSURL URLWithString:urlString]];
        
        // http://pic.ecook.cn/web/11851728.jpg!m2
        // http://pic.ecook.cn/web/11623378.jpg!s3头像
        [cell addSubview:view];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TopRecommendsModel *model=[self.ary objectAtIndex:indexPath.row];
    
    FriendsInfoViewController *fvc=[[FriendsInfoViewController alloc] init];
    NSString *urlStr=[model.uri substringFromIndex:16];
    fvc.urlStr=urlStr;
    
    UIWindow *widown=[[UIApplication sharedApplication] keyWindow];
    MyTabBarViewController *mvc=(MyTabBarViewController *)widown.rootViewController;
    NSArray *ary=[mvc viewControllers];
    UINavigationController *nvc=ary[0];
    
    fvc.hidesBottomBarWhenPushed=YES;
    
   // NSLog(@"33333333333   %@",[self.superview.superview.superview.superview class]);
    [nvc.topViewController.navigationController pushViewController:fvc animated:YES];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end





















