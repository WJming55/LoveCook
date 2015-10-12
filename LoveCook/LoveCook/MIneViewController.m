//
//  MIneViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "MIneViewController.h"

#import "FaverateController.h"
#import "GoBuyViewController.h"

#import "MyInfoView.h"
#import "EditViewController.h"
#import "UMSocial.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"



@interface MIneViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIButton *_loginButton;
    UIButton *_registerButton;
    MyInfoView *_view;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,copy)NSString *token;
@end

@implementation MIneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
   
}

-(void)viewWillAppear:(BOOL)animated{
    
     AppDelegate *applction=[UIApplication sharedApplication].delegate;
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    __weak typeof(self) weakSelf=self;
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        // NSLog(@"SnsInformation is %@",response.data);
       // NSLog(@"%@",response.data[@"access_token"]);
        applction.token=response.data[@"access_token"];
        if (applction.token) {
            _view=[[[NSBundle mainBundle] loadNibNamed:@"MyInfoView" owner:nil options:nil] lastObject];
            
            _view.myblock=^void{
                EditViewController *evc=[[EditViewController alloc] init];
                evc.hidesBottomBarWhenPushed=YES;
                evc.name=response.data[@"screen_name"];
                evc.add=response.data[@"location"];
                evc.sex=@"男";
                evc.imageUrl=response.data[@"profile_image_url"];
                [weakSelf.navigationController pushViewController:evc animated:YES];
                
            };
            
            [_view setFrame:CGRectMake(0, 64, self.view.width, 150)];
            _view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mine_background.png"]];
            _view.nameLabel.text=response.data[@"screen_name"];
            _view.sexLabel.text=@"男";
            _view.addlabel.text=response.data[@"location"];
            [_view.imageView sd_setImageWithURL:[NSURL URLWithString:response.data[@"profile_image_url"]]];
            [self.view addSubview:_view];
        }else{
            [self createButton];
        }
    }];
}
-(void)createButton{
    _loginButton=[Factory createButtonWithTitle:@"登  录" frame:CGRectMake(30, 70,self.view.width-60, 30) target:self selector:@selector(toLogin)];
    [self.view addSubview:_loginButton];
    _registerButton=[Factory createButtonWithTitle:@"注  册" frame:CGRectMake(30, 120,self.view.width-60, 30) target:self selector:@selector(toLogin)];
    [self.view addSubview:_registerButton];
}
-(void)viewDidDisappear:(BOOL)animated{
    [_loginButton removeFromSuperview];
    [_registerButton removeFromSuperview];
    [_view removeFromSuperview];
}

-(void)toLogin{
    AppDelegate *applction=[UIApplication sharedApplication].delegate;
    if (!applction.token) {
        UMSocialSnsPlatform *snsPlatform=[UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            //获取微博用户名，uid,token等
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                applction.token=snsAccount.accessToken;
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            }
        });
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    NSArray *ary=@[@"我  的",@"收藏夹",@"购物清单",@"找朋友",@"关于我们",@"清除缓存"];
    UILabel *label=[[UILabel alloc] initWithFrame:cell.bounds];
    label.textColor=[UIColor grayColor];
    label.text=ary[indexPath.row];
    label.textAlignment=NSTextAlignmentCenter;
    [cell addSubview:label];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        FaverateController *fvc=[[FaverateController alloc] init];
        
        [self.navigationController pushViewController:fvc animated:YES];
    }
    if (indexPath.row==2) {
        GoBuyViewController *gvc=[[GoBuyViewController alloc] init];
        gvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:gvc animated:YES];
    }
    if (indexPath.row==5) {
        //缓存 一般 都是一些 缓存图片 或者 是自己缓存的一些数据
        //SDWebImage  下载图片 会做缓存--->()
        //NSLog(@"%@",NSHomeDirectory());
        //
        NSUInteger fileSize = [[SDImageCache sharedImageCache] getSize];
        //换算成 M
        CGFloat size = fileSize/1024.0/1024.0;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否要删除缓存" message:[NSString stringWithFormat:@"缓存大小 %.6fM",size] preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            //删除的时候回调这个block
            //删除 sd 的缓存
            [[SDImageCache sharedImageCache] clearMemory];
            [[SDImageCache sharedImageCache] clearDisk];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end























