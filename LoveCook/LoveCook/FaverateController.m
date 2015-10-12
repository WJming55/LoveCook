//
//  FaverateController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "FaverateController.h"

#import "FoodListTableViewCell.h"

#import "MenuListModel.h"
#import "MenueListInfoModel.h"

#import "FaverateModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "CoreData+MagicalRecord.h"

@interface FaverateController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSArray *ary;

@property(nonatomic,strong)MenuListModel *menuListModel;

@end

@implementation FaverateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的收藏";
    self.ary =[[NSArray alloc] initWithArray:[FaverateModel MR_findAll]];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FoodListTableViewCell" bundle:nil] forCellReuseIdentifier:@"FoodListTableViewCell"];
    [self getNetData];
}

-(void)getNetData{
    if (self.ary.count) {
        
        NSMutableArray *mAry=[[NSMutableArray alloc] init];
        for (FaverateModel *model in self.ary) {
            [mAry addObject:model.id];
        }
        NSString *str=[mAry componentsJoinedByString:@","];
        self.manager=[AFHTTPRequestOperationManager manager];//title
        self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        [self.manager POST:[NSString stringWithFormat:@"%@%@%@",KFaverateURL,str,KManchineVersion] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.menuListModel=[[MenuListModel alloc] initWithData:responseObject error:nil];
           
            [self.tableView reloadData]; 
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.menuListModel.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FoodListTableViewCell" forIndexPath:indexPath];
    MenueListInfoModel *model=self.menuListModel.list[indexPath.row];
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!m2"];
    [cell.image1 sd_setImageWithURL:[NSURL URLWithString:urlString]];
    cell.titleLabel.text=model.name;
    cell.contentLabel.text=model.content;
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end




















