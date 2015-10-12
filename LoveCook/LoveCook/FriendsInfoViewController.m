//
//  FriendsInfoViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "FriendsInfoViewController.h"
#import "FriendTitleViewCell.h"
#import "PersenTableViewCell.h"//回复cell
#import "FoodListTableViewCell.h"


#import "Factory.h"
#import "UIView+Addition.h"
#import "NetFaceFile.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "FriendTitleModel.h"
#import "TopicListModel.h"
#import "TopicModel.h"

#import "FoodListModel.h"
#import "MaterialListModel.h"
#import "FoodModel.h"


@interface FriendsInfoViewController ()

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,assign)BOOL isBOOL;

@property(nonatomic,strong)FriendTitleModel *friendTitleModel;
@property(nonatomic,strong)TopicListModel *topicListModel;
@property(nonatomic,strong)FoodListModel *foodListModel;
@property(nonatomic,strong)MaterialListModel *materialListModel;

@end

@implementation FriendsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人主页";
    self.isBOOL=YES;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTitleViewCell" bundle:nil] forCellReuseIdentifier:@"FriendTitleViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PersenTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersenTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FoodListTableViewCell" bundle:nil] forCellReuseIdentifier:@"FoodListTableViewCell"];
    [self getNetData];
    
}

- (void)getNetData{
    self.manager=[AFHTTPRequestOperationManager manager];//title
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.manager POST:[NSString stringWithFormat:@"%@%@%@",KFriedsTitleURL,self.urlStr,@"&machine=a7d0944355064401e754578fea7b6779&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.friendTitleModel=[[FriendTitleModel alloc] initWithData:responseObject error:nil];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
////话题
[self.manager POST:[NSString stringWithFormat:@"%@%@%@",KFriedsTopicURL,self.urlStr,@"&machine=a7d0944355064401e754578fea7b6779&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        self.topicListModel=[[TopicListModel alloc] initWithData:responseObject error:nil];
    
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
-(void)getFoodListData{
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.manager POST:[NSString stringWithFormat:@"%@%@",KFoodListURL,self.urlStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.foodListModel=[[FoodListModel alloc] initWithData:responseObject error:nil];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    if (self.isBOOL) {
        return self.topicListModel.list.count;
    }
    
    return self.foodListModel.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)                                                                    indexPath{
    if (indexPath.section==0) {
        
        FriendTitleViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FriendTitleViewCell" forIndexPath:indexPath];
        cell.nameLabel.text=self.friendTitleModel.title;
        cell.sexLabel.text=[self.friendTitleModel.sex intValue]?@"男":@"女";
        [cell.fanCountLabel setTitle:[NSString stringWithFormat:@"%d",self.friendTitleModel.fans]  forState:UIControlStateNormal];
        [cell.guanCountLabel setTitle:[NSString stringWithFormat:@"%d",self.friendTitleModel.follow] forState:UIControlStateNormal];
        
        NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",self.friendTitleModel.pic,@".jpg!s3"];//头像
        cell.phoneBUtton.layer.cornerRadius=10;
        cell.phoneBUtton.layer.masksToBounds=YES;
        
        [cell.phoneBUtton sd_setBackgroundImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal];
        
        return cell;
    }
    if (!self.isBOOL) {//菜单列表////////////////////////////////
        FoodListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FoodListTableViewCell" forIndexPath:indexPath];
        FoodModel *model=self.foodListModel.list[indexPath.row];
        
        NSArray *ary=model.materialList;
        
        NSMutableArray *mAry=[[NSMutableArray alloc] init];
        for (MaterialListModel *model1 in ary) {
            [mAry addObject:model1.name];
        }
        
        NSString *str=[mAry componentsJoinedByString:@","];
        
        cell.contentLabel.text=str;
        cell.titleLabel.text=model.name;
        NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!m2"];
        [cell.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]];
        cell.nameLabel.text=model.authorname;
        return cell;
    }
        //话题///////////////////////////////
    PersenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PersenTableViewCell" forIndexPath:indexPath];
    TopicModel *model=self.topicListModel.list[indexPath.row];
    cell.nameLabel.text=model.nickname;
    cell.timtLabel.text=[NSString stringWithFormat:@"发表: %@",model.addtime];
    cell.contentLabel.text=model.title;
    cell.enjoyLabel.text=[NSString stringWithFormat:@"%d",model.enjoy];
    cell.commentLabel.text=[NSString stringWithFormat:@"%d",model.comment];
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.pic,@".jpg!s3"];
    cell.image1.layer.cornerRadius=25;
    cell.image1.layer.masksToBounds=YES;
    [cell.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]];
    NSString *urlString1=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.picid,@".jpg!m2"];
    [cell.image2 sd_setImageWithURL:[NSURL URLWithString:urlString1]];
    
    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return nil;
    }
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, self.view.width)];
    
    UIButton *button1=[Factory createButtonWithTitle:@"话题" frame:CGRectMake(0,0,self.view.width/2,30) target:self selector:@selector(btnClick:)];
    button1.tag=101;
    UIButton *button2=[Factory createButtonWithTitle:@"菜谱" frame:CGRectMake(self.view.width/2, 0, self.view.width/2, 30) target:self selector:@selector(btnClick:)];
    button2.tag=102;
    [backView addSubview:button1];
    [backView addSubview:button2];
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section==0) {
        return 0.1f;
    }
    return 30.f;
}

-(void)btnClick:(UIButton *)button{
    switch (button.tag) {
        case 101:
        {
            self.isBOOL=YES;
            [self.tableView reloadData];
        }
            break;
        case 102:
        {
            self.isBOOL=NO;
            [self getFoodListData];
            [self.tableView reloadData];
            
        }
            break;
        default:
            break;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 280.f;
    }
    return 150.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end


















































