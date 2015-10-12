//
//  MyTabBarViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "MyTabBarViewController.h"

#import "HomeViewController.h"
#import "FoodMenueViewController.h"
#import "CookFriendsViewController.h"
#import "MIneViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *v1=[[HomeViewController alloc] init];
    UINavigationController *n1=[[UINavigationController alloc] initWithRootViewController:v1];
    n1.title=@"首页";
    n1.tabBarItem.image=[UIImage imageNamed:@"tabbar_recommend.png"];
    
    FoodMenueViewController *v2=[[FoodMenueViewController alloc] init];
    UINavigationController *n2=[[UINavigationController alloc] initWithRootViewController:v2];
    n2.title=@"菜谱";
    n2.tabBarItem.image=[UIImage imageNamed:@"tabbar_recipes.png"];
    
    CookFriendsViewController *v3=[[CookFriendsViewController alloc] init];
    UINavigationController *n3=[[UINavigationController alloc] initWithRootViewController:v3];
    n3.title=@"厨友汇";
    n3.tabBarItem.image=[UIImage imageNamed:@"tabbar_community.png"];
    
    MIneViewController *v4=[[MIneViewController alloc] init];
    UINavigationController *n4=[[UINavigationController alloc] initWithRootViewController:v4];
    n4.title=@"我的";
    n4.tabBarItem.image=[UIImage imageNamed:@"tabbar_mine.png"];
    
    
    self.viewControllers=@[n1,n2,n3,n4];
    self.tabBar.tintColor=[UIColor orangeColor];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

















