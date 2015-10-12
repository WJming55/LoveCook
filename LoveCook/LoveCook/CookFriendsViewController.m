//
//  CookFriendsViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "CookFriendsViewController.h"
#import "MMProgressHUD.h"
#import "FriendsTableViewCell.h"
#import "PersenTableViewCell.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "FriendListModel.h"
#import "FriendTieZiModel.h"

@interface CookFriendsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *dataAry;
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)FriendListModel *friendListModel;
@end

@implementation CookFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PersenTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersenCellId"];
    [self getNetdata];
}

-(void)getNetdata{
    self.manager=[AFHTTPRequestOperationManager manager];//title
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"下载数据" status:@"加载中......"];
    
    [self.manager POST:KFriendsNumberURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSArray *ary=[str componentsSeparatedByString:@", "];
        NSString *urlStr=[ary componentsJoinedByString:@","];
        
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",KFriendsTieZiURL,urlStr,@"&machine=a7d0944355064401e754578fea7b6779&version=11.1.3"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

            self.friendListModel=[[FriendListModel alloc] initWithData:responseObject error:nil];
            
            [self.tableView reloadData];
            //下载完成 之后 要把 特效 取消 否则 不会自动取消
            [MMProgressHUD dismissWithSuccess:@"下载数据" title:@"OK"];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MMProgressHUD dismissWithError:@"下载数据" title:@"失败"];
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendListModel.list.count+1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellId"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    PersenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PersenCellId"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    FriendTieZiModel *model=self.friendListModel.list[indexPath.row-1];
     NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.pic,@".jpg!s3"];
    [cell.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]];
   
    NSString *urlString1=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.picid,@".jpg!s3"];
    [cell.image2 sd_setImageWithURL:[NSURL URLWithString:urlString1]];
    cell.nameLabel.text=model.nickname;
    cell.contentLabel.text=model.title;
    cell.enjoyLabel.text=[NSString stringWithFormat:@"%d",model.enjoy];
    cell.commentLabel.text=[NSString stringWithFormat:@"%d",model.comment];
    cell.timtLabel.text=model.addtime;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 90;
    }
    FriendTieZiModel *model=self.friendListModel.list[indexPath.row-1];
    if ([model.picid isEqualToString:@""]) {
        return 90;
    }
    return 150.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end





















