//
//  FoodMenueViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "FoodMenueViewController.h"
#import "LeftFoodMenuList.h"
#import "FoodMenueLIstController.h"
#import "RandomViewController.h"
#import "CreateMenueViewController.h"

#import "AFNetworking.h"

#import "KindListModel.h"
#import "FoodKindModel.h"
#import "FoodKinfInfoModel.h"
#import "TypeModel.h"

#import "NewstModel.h"

#import "SmollKindListModel.h"
#import "SmollKindInfoModel.h"


@interface FoodMenueViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

{
    UIView *_view;
    UITableView *_tableView;
    UICollectionView *_collectionView;
    NSString *_smollKindUrlTagId;
}
- (IBAction)DoodMenueButtonClick:(id)sender;
- (IBAction)newstFoodMenueButton:(id)sender;
- (IBAction)BandomBtnClick:(id)sender;

- (IBAction)createMenueButton:(id)sender;



@property(nonatomic,assign)BOOL isBOOL;
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)KindListModel *kindListModel;
@property(nonatomic,strong)SmollKindListModel *smollKindListModel;
@property(nonatomic,strong)NSMutableArray *dataAry;
@property(nonatomic,strong)NewstModel *newstModel;
@end

@implementation FoodMenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"菜   谱";
    self.isBOOL=YES;
    // _view=[[LeftFoodMenuList alloc] initWithFrame:CGRectMake(0, 64, 0, 400)];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, 0, 400) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.userInteractionEnabled=YES;
   // _tableView.backgroundColor=[UIColor clearColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    [self.view addSubview:_tableView];
    [self getNetData];
}

- (IBAction)DoodMenueButtonClick:(id)sender{
    if (self.isBOOL) {
        [UIView animateWithDuration:0.5 animations:^{
            [_tableView setFrame:CGRectMake(0, 64, 150, 400)];
        }];
        self.isBOOL=NO;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [_tableView setFrame:CGRectMake(0, 64, 0, 400)];
            
        }];
     self.isBOOL=YES;
    
    }
}
#pragma mark--最新菜谱
- (IBAction)newstFoodMenueButton:(id)sender {
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [self.manager POST:KNewstMenueListURl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.newstModel=[[NewstModel alloc] initWithData:responseObject error:nil];
        
        NSString *str=[self.newstModel.list componentsJoinedByString:@","];
        FoodMenueLIstController *fvc=[[FoodMenueLIstController alloc] init];
        fvc.URLString=[NSString stringWithFormat:@"%@%@%@",KNewstMenueListInfoURl,str,KManchineVersion];
       // NSLog(@"88888888888  %@",fvc.URLString);
        fvc.title=@"最新菜谱";
        
        [self.navigationController pushViewController:fvc animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}
#pragma mark--摇一摇
- (IBAction)BandomBtnClick:(id)sender {
    RandomViewController *rvc=[[RandomViewController alloc] init];
    rvc.title=@"摇一摇";
    rvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:rvc animated:YES];
}
//创建菜谱
- (IBAction)createMenueButton:(id)sender {
    CreateMenueViewController *cvc=[[CreateMenueViewController alloc] init];
    cvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:cvc animated:YES];
}


#pragma mark--请求数据
- (void)getNetData{
    
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.manager POST:KFoodMenueKindURl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.kindListModel=[[KindListModel alloc] initWithData:responseObject error:nil];
        
       // FoodKindModel *Kindmodel=self.kindListModel.list[0];
       
       // NSDictionary *model=Kindmodel.toDictionary;
        
       // FoodKinfInfoModel *model1=Kindmodel.list[0];
//        
//        NSDictionary *model=Kindmodel.tagspo;
//        
//         NSLog(@"---------%@",model);
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
  return self.kindListModel.list.count;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    FoodKindModel *Kindmodel=self.kindListModel.list[section];
    return Kindmodel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    FoodKindModel *Kindmodel=self.kindListModel.list[indexPath.section];
    FoodKinfInfoModel *model=Kindmodel.list[indexPath.row];
    
    cell.textLabel.text=model.name;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.textColor=[UIColor grayColor];
    cell.userInteractionEnabled=YES;
    cell.textLabel.userInteractionEnabled=YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)]
    UIButton *button1=[Factory createButtonWithTitle:[NSString stringWithFormat:@"%ld",section] frame:CGRectMake(0,0,self.view.width/2,44) target:self selector:@selector(btnClick:)];
    FoodKindModel *Kindmodel=self.kindListModel.list[section];
    NSString *title=Kindmodel.tagspo[@"name"];
    [button1 setTitle:title forState:UIControlStateNormal];
    button1.tag=section;
    return button1;
}
- (void)btnClick:(UIButton *)button{

}
#pragma mark--选中Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodKindModel *Kindmodel=self.kindListModel.list[indexPath.section];
    FoodKinfInfoModel *model=Kindmodel.list[indexPath.row];
    _smollKindUrlTagId=model.tagid;
    [self DoodMenueButtonClick:nil];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self createView];
    
//    UITableViewCell *cell=[[tableView subviews] objectAtIndex:indexPath.row];
//    NSLog(@"222222222222222222%lf",cell.frame.origin.x);
    
}

-(void)createView{
    
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(self.view.width, 100, 0, 200)];
//    view.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:view];
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        [view setFrame:CGRectMake(self.view.width/2, 100, self.view.width, 200)];
//    }];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.itemSize=CGSizeMake(60, 40);
    layout.minimumInteritemSpacing=10;
    layout.minimumLineSpacing=10;
    
    if (_collectionView) {
        [_collectionView removeFromSuperview];
        _collectionView=nil;
    }
    if (!_collectionView) {
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 400) collectionViewLayout:layout];
        
//        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(self.view.width/2, 100, self.view.width/2, 400) collectionViewLayout:layout];
        
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.backgroundColor=[UIColor blackColor];
        
        _collectionView.alpha=0.7;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollId"];
        [self.view addSubview:_collectionView];
    }
    [self getNetData2];
}

-(void)getNetData2{
    
    self.dataAry=[[NSMutableArray alloc] init];
    
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.manager POST:[NSString stringWithFormat:@"%@%@%@",KSmollKindListURl,_smollKindUrlTagId,KManchineVersion] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.smollKindListModel=[[SmollKindListModel alloc] initWithData:responseObject error:nil];
        for (SmollKindInfoModel *model in self.smollKindListModel.list) {
            [self.dataAry addObject:model];
        }
        
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
   
    [_collectionView reloadData];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataAry.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CollId" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    //cell.textInputContextIdentifier=@"微微";
    // cell setTag:<#(NSInteger)#>
    
    UILabel *label=[[UILabel alloc] initWithFrame:cell.bounds];
    
    SmollKindInfoModel *model=self.dataAry[indexPath.row];
    label.backgroundColor=[UIColor whiteColor];
    label.text=model.name;
    //[label sizeToFit];
    label.font=[UIFont systemFontOfSize:12.f];
    //label.textAlignment=NSTextAlignmentCenter;
    [cell addSubview:label];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    FoodMenueLIstController *fvc=[[FoodMenueLIstController alloc] init];
    
    SmollKindInfoModel *model=self.dataAry[indexPath.row];
    
    fvc.URLString=[NSString stringWithFormat:@"%@%@%@",KMenueKindListURl,model.tagid,Kversion];
    NSLog(@"****************  %@",fvc.URLString);
    [_collectionView removeFromSuperview];
    _collectionView=nil;
    fvc.title=model.name;
    [self.navigationController pushViewController:fvc animated:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   // UITouch *myTouch = [touches anyObject];
    //获取当前移动的点
    //CGPoint currentP = [myTouch locationInView:self.view];
   // NSLog(@"3333333333333%lf",currentP.y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




































