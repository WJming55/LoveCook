//
//  StepListViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "StepListViewController.h"
#import "AFNetworking.h"
#import "MenueListInfoModel.h"

@interface StepListViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)MenueListInfoModel *menueListInfoMode;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)UIWebView *webView2;

@end

@implementation StepListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate=self;
    
    [self getNetData];
    
    
}

-(void)getNetData{
    self.manager=[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [self.manager POST:KRandomURl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.menueListInfoMode=[[MenueListInfoModel alloc] initWithData:responseObject error:nil];
       // NSLog(@"ssssssssss  %@",self.menueListInfoMode);
        self.title=self.menueListInfoMode.name;
        
       // NSData *data=[NSData dataWithContentsOfFile:self.menueListInfoMode.contenthtml];
        
       // NSLog(@"bbbbbbbbb %lf",self.webView.scrollView.contentSize.height);
//        NSLog(@"aaaaaaaaaa %lf",self.webView.height);
//        NSLog(@"aaaaaaaaaa %lf",self.webView.scrollView.height);
        
        
        [self.webView loadHTMLString:self.menueListInfoMode.contenthtml baseURL:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.webView sizeToFit];
    
    NSLog(@"aaaaaaaaaa %lf",self.webView.scrollView.contentSize.height);
    
    CGFloat height=self.webView.scrollView.contentSize.height;
    
    [self.webView.scrollView setHeight:height+1];
    
    [self.webView setHeight:height];
    
    NSLog(@"bbbbbbbbbb %lf",self.webView.height);
    
    [self creatLael];
}
-(void)creatLael{
    UILabel *label=[[UILabel alloc] init];
   
    label.numberOfLines=5;
    label.text=self.menueListInfoMode.contenthtml;
    
     [label sizeToFit];
    
    label.backgroundColor=[UIColor greenColor];
    [self.webView.scrollView addSubview:label];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end















