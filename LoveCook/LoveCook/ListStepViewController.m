//
//  ListStepViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "ListStepViewController.h"
#import "AFNetworking.h"
#import "MenueListInfoModel.h"
#import "MenueAuthorModel.h"
#import "FaverateModel.h"//Coredata

#import "BestTableViewCell.h"
#import "StepTableViewCell.h"

#import "CoreData+MagicalRecord.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "UMSocial.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ListStepViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UMSocialUIDelegate>
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)MenueListInfoModel *menueListInfoMode;
@end

@implementation ListStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenSize.width , kScreenSize.height) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.estimatedRowHeight = 120;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyCellID"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BestTableViewCell" bundle:nil] forCellReuseIdentifier:@"BestTableViewCell"];
    
    [self.view addSubview:self.tableView];
    [self getNetData];
    
}
-(void)creatButton{
    NSArray *ary=@[@"分享",@"上传作品",@"加入清单",@"收藏"];
    for (int i=0; i<4; i++) {
        UIButton *button=[Factory createButtonWithTitle:ary[i] frame:CGRectMake(i*self.view.width/4, self.view.height-30,self.view.width/4, 30) target:self selector:@selector(btnClick:)];
        button.alpha=0.8;
        button.tag=101+i;
        [self.view addSubview:button];
    }
}
-(void)btnClick:(UIButton *)button{
    switch (button.tag) {
        case 101://分享
        {
            [self UMshare];
        
        }
            break;
        case 102://上传我做的
        {
            
        }
            break;
        case 103://加入清单
        {
            
        }
            break;
        case 104://添加收藏
        {
            [self toFaverateFood];
            
        }
            break;
        default:
            break;
    }
}
//有盟分享
-(void)UMshare{
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
    NSString *str=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",self.menueListInfoMode.imageid,@".jpg!m2"];
    
    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5605094de0f55a0989000f25" shareText:@"这里有好吃的哦" shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms, nil] delegate:self];
}
//收藏
- (void)toFaverateFood{
    NSArray *ary =[FaverateModel MR_findByAttribute:@"id" withValue:self.menueListInfoMode.id];
    if (ary.count) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"已经收藏过" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController: alert animated:YES completion:nil];
        return;
    }
    FaverateModel *model=[FaverateModel MR_createEntity];
    model.id=self.menueListInfoMode.id;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    UIButton *button=(UIButton *)[self.view viewWithTag:104];
    [button setTitle:@"已收藏" forState:UIControlStateNormal];
}

- (void)getNetData{
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.manager POST:KRandomURl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.menueListInfoMode=[[MenueListInfoModel alloc] initWithData:responseObject error:nil];
//        NSLog(@"ffffff %@",operation.response.URL);
//        NSLog(@"ggggggg %@",self.menueListInfoMode);
        self.title=self.menueListInfoMode.name;
        [self creatWebView];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
         BestTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BestTableViewCell" forIndexPath:indexPath];
        NSString *urlString=[NSString stringWithFormat:@"%@%@%@",@"http://pic.ecook.cn/web/",self.menueListInfoMode.imageid,@".jpg!m2"];
        MenueAuthorModel *model1=self.menueListInfoMode.referencePo;
        [cell.backImage sd_setImageWithURL:[NSURL URLWithString:urlString]];
        cell.fromLabel.text=model1.author;
        return cell;
    }
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyCellID" forIndexPath:indexPath];
    return cell;
}

-(void)creatWebView{

    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.webView.delegate=self;
    [self.webView loadHTMLString:self.menueListInfoMode.contenthtml baseURL:nil];
    self.tableView.tableFooterView=self.webView;
  //  [self.view addSubview:self.webView];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
   
    CGFloat height=self.webView.scrollView.contentSize.height;
    [self.webView.scrollView setHeight:height+20];
     self.webView=nil;
    UIWebView *web=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, height+20)];
    [web loadHTMLString:self.menueListInfoMode.contenthtml baseURL:nil];
    self.tableView.tableFooterView=web;
    [self creatButton];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
         return 250;
    }
   
    return 120;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
















