//
//  HomeViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "HomeViewController.h"
#import "ListViewController.h"
#import "HotViewController.h"
#import "WebViewController.h"
#import "BestViewController.h"
#import "LZXViewController.h"
#import "AVideoViewController.h"
#import "MyVideoViewController.h"
#import "KLLoopImageView.h"

#import "HomeModel.h"
#import "ListRecommendsModel.h"
#import "TopRecommendsModel.h"
#import "ListMode.h"

#import "MoreModel.h"//更多

#import "FirstTableViewCell.h"
#import "TodarFoodTableViewCell.h"
#import "CommenTableViewCell.h"
#import "MyFriendTableViewCell.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataAry;
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)HomeModel *homeModel;

@property(nonatomic,strong)ListMode *lisyModel1;//每日菜单
@property(nonatomic,strong)ListMode *lisyModel2;//热门活动
@property(nonatomic,strong)ListMode *lisyModel3;//精选专辑
@property(nonatomic,strong)ListMode *lisyModel4;//达人菜谱
@property(nonatomic,strong)ListMode *lisyModel5;//大家都在聊
@property(nonatomic,strong)ListMode *lisyModel6;//视频菜谱
@property(nonatomic,strong)ListMode *lisyModel7;//厨友推荐

@property(nonatomic,strong)MoreModel *moreModel2;//得到messag参数
@property(nonatomic,strong)MoreModel *moreModel3;//得到messag参数
@property(nonatomic,strong)MoreModel *moreModel4;//得到messag参数
@property(nonatomic,strong)MoreModel *moreModel5;//得到messag参数
@property(nonatomic,strong)MoreModel *moreModel6;//得到messag参数
@property(nonatomic,strong)MoreModel *moreModel7;//得到messag参数
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    self.dataAry=[[NSMutableArray alloc] init];
    [self GetNetData];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"ADCellId"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TodarFoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"TodayCellId"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommenTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommenId"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"MyFriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyFriendId"];
}

-(void)GetNetData{
    
    __weak typeof(self) weakSelf=self;
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
[self.manager POST:HomeURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        self.homeModel=[[HomeModel alloc] initWithData:responseObject error:nil];
        
// 每日菜单///////////
        ListRecommendsModel *model=weakSelf.homeModel.listRecommends[0];
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kTodayFoodURL,model.contentIds,@"&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.lisyModel1=[[ListMode alloc] initWithData:responseObject error:nil];
            //[self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
//////////////////////////////////////////////////////////
    
//热门活动请求////////////////////////
        ListRecommendsModel *model1=weakSelf.homeModel.listRecommends[1];
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",HotActivty1,model1.contentIds,@"&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.lisyModel2=[[ListMode alloc] initWithData:responseObject error:nil];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    //更多/////////得到message参数
        [self.manager POST:[NSString stringWithFormat:@"%@%@",KMoreURL,model1.type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.moreModel2=[[MoreModel alloc] initWithData:responseObject error:nil];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
//////////////////////////////////////////////////
    
// 精选专辑///////////
        ListRecommendsModel *model2=weakSelf.homeModel.listRecommends[2];
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kTodayFoodURL,model2.contentIds,@"&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.lisyModel3=[[ListMode alloc] initWithData:responseObject error:nil];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    //更多/////////得到message参数
    [self.manager POST:[NSString stringWithFormat:@"%@%@",KMoreURL,model2.type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.moreModel3=[[MoreModel alloc] initWithData:responseObject error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

//////////////////////////////////////////////////////////////////
    
    
// 达人菜谱///////////
        ListRecommendsModel *model3=weakSelf.homeModel.listRecommends[3];
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kTodayFoodURL,model3.contentIds,@"&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.lisyModel4=[[ListMode alloc] initWithData:responseObject error:nil];
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    //更多/////////得到message参数
    [self.manager POST:[NSString stringWithFormat:@"%@%@",KMoreURL,model3.type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.moreModel4=[[MoreModel alloc] initWithData:responseObject error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
//////////////////////////////////////////////////////////////////
    
    
// 大家都在聊///////////
        ListRecommendsModel *model4=weakSelf.homeModel.listRecommends[4];
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kTodayFoodURL,model4.contentIds,@"&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.lisyModel5=[[ListMode alloc] initWithData:responseObject error:nil];
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    //更多/////////得到message参数
    [self.manager POST:[NSString stringWithFormat:@"%@%@",KMoreURL,model4.type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.moreModel5=[[MoreModel alloc] initWithData:responseObject error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    [self.tableView reloadData];
//////////////////////////////////////////////////////////////////
    
// 视频菜谱///////////
        ListRecommendsModel *model5=weakSelf.homeModel.listRecommends[5];
    
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kTodayFoodURL,model5.contentIds,@"&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
          //  NSLog(@"mmmmmmm  %@",operation.response.URL);
            self.lisyModel6=[[ListMode alloc] initWithData:responseObject error:nil];
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    //更多/////////得到message参数
    [self.manager POST:[NSString stringWithFormat:@"%@%@",KMoreURL,model5.type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.moreModel6=[[MoreModel alloc] initWithData:responseObject error:nil];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
//////////////////////////////////////////////////////////////////
    
    
// 厨有推荐///////////
        ListRecommendsModel *model6=weakSelf.homeModel.listRecommends[6];
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",kTodayFoodURL,model6.contentIds,@"&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.lisyModel7=[[ListMode alloc] initWithData:responseObject error:nil];
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    //更多/////////得到message参数
    [self.manager POST:[NSString stringWithFormat:@"%@%@",KMoreURL,model6.type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.moreModel7=[[MoreModel alloc] initWithData:responseObject error:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

//////////////////////////////////////////////////////////////////

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
//////////////////////////////////////
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0||section==1||section==7) {
        return 1;
    }else if (section==3||section==4||section==5||section==6){
        return 4;
    }
    return 3;
}
//////////////////////

#pragma mark -UITableViewCell *
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {//广告
        FirstTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ADCellId" forIndexPath:indexPath];
        NSArray *ary=[[NSArray alloc] initWithArray:self.homeModel.topRecommends];
        if (ary.count>0) {
            NSMutableArray *mAry=[[NSMutableArray alloc] init];
            for (TopRecommendsModel *model in ary) {
               NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!m2"];
                [mAry addObject:urlString];
            }
        KLLoopImageView *view=[[KLLoopImageView alloc] initWithFrame:cell.bounds images:mAry];
        [cell addSubview:view];
        //[cell shouDataWithModel:ary];
        }
        return cell;
    }
    if (indexPath.section==1) {//每日菜单
        TodarFoodTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TodayCellId" forIndexPath:indexPath];
        NSArray *ary=[[NSArray alloc] initWithArray:self.lisyModel1.list];
        if (ary) {
            [cell shouDataWithModel:ary];
        }
        return cell;
    }
    if (indexPath.section==2) {//热门活动
        CommenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommenId" forIndexPath:indexPath];
        
//        TopRecommendsModel *model=[self.lisyModel2.list objectAtIndex:indexPath.row];
//        [cell showDataWithMOdel:model];
        return cell;
    }
    
    if (indexPath.section==3) {//精选专辑
        CommenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommenId" forIndexPath:indexPath];
        
        TopRecommendsModel *model=[self.lisyModel3.list objectAtIndex:indexPath.row];
        [cell showDataWithMOdel:model];
        return cell;
    }
    if (indexPath.section==4) {//达人菜谱
        CommenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommenId" forIndexPath:indexPath];
        
        TopRecommendsModel *model=[self.lisyModel4.list objectAtIndex:indexPath.row];
        [cell showDataWithMOdel:model];
        return cell;
    }
    if (indexPath.section==5) {//大家都在聊
        CommenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommenId" forIndexPath:indexPath];
        
        TopRecommendsModel *model=[self.lisyModel5.list objectAtIndex:indexPath.row];
        [cell showDataWithMOdel:model];
        return cell;
    }
    if (indexPath.section==6) {//视频菜谱
        CommenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CommenId" forIndexPath:indexPath];
        
        TopRecommendsModel *model=[self.lisyModel6.list objectAtIndex:indexPath.row];
        [cell showDataWithMOdel:model];
        
        
        return cell;
    }

    MyFriendTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyFriendId" forIndexPath:indexPath];
    NSArray *ary=[[NSArray alloc] initWithArray:self.lisyModel7.list];
    if (ary) {
        [cell showImageWith:ary];
    }
    return cell;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }
    return  [self creatHeadView:section];;
}
-(UIView *)creatHeadView:(NSInteger)section{
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, self.view.width)];
    
    UIButton *button=[Factory createButtonWithTitle:@"更多>>" frame:CGRectMake(self.view.width-80, 0, 100, 30) target:self  selector:@selector(btnClick:)];
    button.backgroundColor=[UIColor clearColor];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    if (section==1) {
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    button.tag=section;
    
    NSArray *ary=@[@"",@"每日菜单",@"热门活动",@"精选专辑",@"达人菜谱",@"大家都在聊",@"视频菜谱",@"厨友推荐"];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text=ary[section];
    label.textAlignment=NSTextAlignmentLeft;
    [view addSubview:button];
    [view addSubview:label];
    return view;
}

-(void)btnClick:(UIButton *)button{
    switch (button.tag) {
        case 2:
            {
                ListViewController *hvc=[[ListViewController alloc] initWithCellClass:@"CommenTableViewCell" URLString:self.moreModel2.message title:@"热门活动"];
                hvc.isSeven=NO;
                hvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:hvc animated:YES];
            }
            break;
        case 3:
        {
            ListViewController *hvc=[[ListViewController alloc] initWithCellClass:@"CommenTableViewCell" URLString:self.moreModel3.message title:@"精选专辑"];
            hvc.isSeven=NO;
            hvc.flag=3;
            hvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        case 4:
        {
            ListViewController *hvc=[[ListViewController alloc] initWithCellClass:@"CommenTableViewCell" URLString:self.moreModel4.message title:@"达人菜谱"];
            hvc.isSeven=NO;
            hvc.flag=4;
            hvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        case 5:
        {
            ListViewController *hvc=[[ListViewController alloc] initWithCellClass:@"CommenTableViewCell" URLString:self.moreModel5.message title:@"大家都在聊"];
            hvc.isSeven=NO;
            hvc.flag=5;
            hvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        case 6:
        {
            ListViewController *hvc=[[ListViewController alloc] initWithCellClass:@"CommenTableViewCell" URLString:self.moreModel6.message title:@"视频菜谱"];
            hvc.isSeven=NO;
            hvc.flag=6;
            hvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        case 7:
        {
            ListViewController *hvc=[[ListViewController alloc] initWithCellClass:@"CommenTableViewCell" URLString:self.moreModel7.message title:@"厨友推荐"];
            hvc.isSeven=YES;
            hvc.flag=7;
            hvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 120;
    }
    return 90.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1f;
    }
    return 30.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    WebViewController *web=[[WebViewController alloc] init];
    
    if (indexPath.section==2) {
     TopRecommendsModel *model=[self.lisyModel2.list objectAtIndex:indexPath.row];
        web.urlStr=model.uri;
        [self.navigationController pushViewController:web animated:YES];
        return;
    }
    if (indexPath.section==3) {
        BestViewController *bvc=[[BestViewController alloc] init];
        
        TopRecommendsModel *model=[self.lisyModel3.list objectAtIndex:indexPath.row];
        NSString *urlStr=[model.uri substringFromIndex:22];
        bvc.urlStr=urlStr;
        [self.navigationController pushViewController:bvc animated:YES];
        return;
    }
    if (indexPath.section==6) {
        TopRecommendsModel *model=[self.lisyModel6.list objectAtIndex:indexPath.row];
        LZXViewController *lvc=[[LZXViewController alloc] init];
        lvc.uriStr=[model.uri substringFromIndex:47];
        lvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:lvc animated:YES];
        
//        AVideoViewController *avc=[[AVideoViewController alloc] init];
//        avc.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:avc animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end




















