//
//  BestViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "BestViewController.h"
#import "BestTableViewCell.h"
#import "FoodListTableViewCell.h"
#import "WebViewController.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "BestListMOdel.h"
#import "BestModel1.h"
#import "BestTitleInfoModel.h"

#import "BestALLListModel.h"
#import "BestListFoodModel.h"

@interface BestViewController ()

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)BestListMOdel *bestListMOdel;
@property(nonatomic,strong)BestTitleInfoModel *bestTitleInfoModel;
@property(nonatomic,strong)BestALLListModel *bestAllModel;

@end

@implementation BestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"精选专辑";
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BestTableViewCell" bundle:nil] forCellReuseIdentifier:@"BestTableViewCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"FoodListTableViewCell" bundle:nil] forCellReuseIdentifier:@"FoodListTableViewCell"];
    
    [self getNetData];

}
-(void)getNetData{
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];//title
    [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kBestTitleURL,self.urlStr,@"&machine=a7d0944355064401e754578fea7b6779&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.bestListMOdel=[[BestListMOdel alloc] initWithData:responseObject error:nil];
        BestModel1 *model=self.bestListMOdel.list[0];
  ////////////////////
            [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kBestTitleInfoURL,model.wid,@"&machine=a7d0944355064401e754578fea7b6779&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                self.bestTitleInfoModel=[[BestTitleInfoModel alloc] initWithData:responseObject error:nil];
                [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            }];
///////////////////////////
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kBestFoodListURL,model.recipeididlist,@"&machine=a7d0944355064401e754578fea7b6779&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.bestAllModel=[[BestALLListModel alloc] initWithData:responseObject error:nil];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
////////////////////////////
        
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
    return self.bestAllModel.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)                                                                    indexPath{
    if (indexPath.section==0) {
     BestTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BestTableViewCell" forIndexPath:indexPath];
        
        cell.fromLabel.text=[NSString stringWithFormat:@"来自:%@",self.bestTitleInfoModel.nickname];
        cell.contentLabel.text=self.bestTitleInfoModel.weibo;
        NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",self.bestTitleInfoModel.pic,@".jpg!s3"];
        cell.photoButton.layer.cornerRadius=25;
        cell.photoButton.layer.masksToBounds=YES;
        [cell.photoButton sd_setBackgroundImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal];
        
        return cell;
    }
    FoodListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FoodListTableViewCell" forIndexPath:indexPath];
    BestListFoodModel *model=self.bestAllModel.list[indexPath.row];
    cell.contentLabel.text=model.content;
    cell.titleLabel.text=model.name;
     NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!m2"];
    [cell.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]];
    return cell;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return nil;
    }
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, self.view.width)];
    
    UIButton *button1=[Factory createButtonWithTitle:@"我去发表评论" frame:CGRectMake(0,0,self.view.width,30) target:self selector:@selector(btnClick:)];
    button1.tag=101;
   
    [backView addSubview:button1];
    return backView;
}

-(void)btnClick:(UIButton *)button{

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0.1f;
    }
    return 30.f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 280.f;
    }
    return 150.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WebViewController *web=[[WebViewController alloc] init];
    
    BestListFoodModel *model=self.bestAllModel.list[indexPath.row];
    web.urlStr=model.contenthtml;
    [self.navigationController pushViewController:web animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end






















