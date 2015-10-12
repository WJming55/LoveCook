//
//  ListViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "ListViewController.h"
#import "FriendsInfoViewController.h"
#import "BestViewController.h"

#import "UIView+Addition.h"
#import "NetFaceFile.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "CommenTableViewCell.h"

#import "ListMode.h"
#import "TopRecommendsModel.h"

@class CommenTableViewCell;

@interface ListViewController ()
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSMutableArray *dataAry;
@property(nonatomic,strong)ListMode *listModel;
@end

@implementation ListViewController

-(id)initWithCellClass:(NSString *)classStr URLString:(NSString *)urlstr title:(NSString *)titleStr{
    if (self=[super init]) {
        self.classStr=classStr;
        self.urlStr=urlstr;
        self.titleStr=titleStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.titleStr;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:self.classStr bundle:nil] forCellReuseIdentifier:@"CellId"];
    [self getNetData];
    
}
-(void)getNetData{
    self.dataAry=[[NSMutableArray alloc] init];
    
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.manager POST:[NSString stringWithFormat:@"%@%@%@",KMoreInfo,self.urlStr,@"&version=11.1.1"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ListMode *listModel=[[ListMode alloc] initWithData:responseObject error:nil];
        [self.dataAry removeAllObjects];
        [self.dataAry addObjectsFromArray:listModel.list];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.classStr isEqualToString:@"CommenTableViewCell"]) {
        
        CommenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
        TopRecommendsModel *model=self.dataAry[indexPath.row];
        cell.titleLabel.text=model.title;
        cell.nameLabel.text=model.author;
        cell.timeLabel.text=[model.uptime substringToIndex:10];
        NSString *urlString1=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!m2"];
         NSString *urlString2=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",model.imageid,@".jpg!s3"];
        if (self.isSeven==NO) {
            [cell.phoneView1 sd_setImageWithURL:[NSURL URLWithString:urlString1]];
        }else{
             [cell.phoneView1 sd_setImageWithURL:[NSURL URLWithString:urlString2]];
        }
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.flag==7) {//厨友推荐
        FriendsInfoViewController *fvc=[[FriendsInfoViewController alloc] init];
        TopRecommendsModel *model=self.dataAry[indexPath.row];
        
        NSString *urlStr=[model.uri substringFromIndex:16];
        fvc.urlStr=urlStr;
        [self.navigationController pushViewController:fvc animated:YES];
    }if (self.flag==3) {
        BestViewController *bvc=[[BestViewController alloc] init];
        TopRecommendsModel *model=self.dataAry[indexPath.row];
        NSString *urlStr=[model.uri substringFromIndex:22];
        bvc.urlStr=urlStr;
        [self.navigationController pushViewController:bvc animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
























