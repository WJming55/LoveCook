//
//  WebViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWebView];
    [self initData];
    
}
-(void)creatWebView{
    _webView=[[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate=self;
    [self.view addSubview:_webView];
}
-(void)initData{
    
    NSString *url=[NSString stringWithFormat:@"%@",self.urlStr];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



























