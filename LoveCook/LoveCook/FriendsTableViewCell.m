//
//  FriendsTableViewCell.m
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "FriendsTableViewCell.h"

#import "MyTabBarViewController.h"

#import "ListViewController.h"
#import "NewstViewController.h"

#import "CHTumblrMenuView.h"//弹出视图


@implementation FriendsTableViewCell

- (IBAction)DarenButtonClick:(id)sender {
    
    NewstViewController *rvc=[[NewstViewController alloc] init];
    
    UIWindow *widown=[[UIApplication sharedApplication] keyWindow];
    MyTabBarViewController *mvc=(MyTabBarViewController *)widown.rootViewController;
    NSArray *ary=[mvc viewControllers];
    UINavigationController *nvc=ary[2];

    //[nvc.topViewController.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)ToMore:(id)sender {
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    menuView.backgroundColor=[UIColor grayColor];
    [menuView addMenuItemWithTitle:@"健康养生" andIcon:[UIImage imageNamed:@"icon_topic_health.png"] andSelectedBlock:^{
        NSLog(@"Text selected");
    }];
    
    [menuView addMenuItemWithTitle:@"厨房技巧" andIcon:[UIImage imageNamed:@"icon_topic_cook.png"] andSelectedBlock:^{
        NSLog(@"Photo selected");
    }];
    
    [menuView addMenuItemWithTitle:@"家庭生活" andIcon:[UIImage imageNamed:@"icon_topic_familylife.png"] andSelectedBlock:^{
        NSLog(@"Quote selected");
        
    }];
    
    [menuView addMenuItemWithTitle:@"美容瘦身" andIcon:[UIImage imageNamed:@"icon_topic_beautyslimmi.png"] andSelectedBlock:^{
        NSLog(@"Link selected");
        
    }];
    
    [menuView addMenuItemWithTitle:@"哄陪天地" andIcon:[UIImage imageNamed:@"icon_topic_bake.png"] andSelectedBlock:^{
        NSLog(@"Chat selected");
        
    }];
    
    [menuView addMenuItemWithTitle:@"养儿育女" andIcon:[UIImage imageNamed:@"icon_topic_raise.png"] andSelectedBlock:^{
        NSLog(@"Video selected");
        
    }];
    
    [menuView addMenuItemWithTitle:@"美食游记" andIcon:[UIImage imageNamed:@"icon_topic_tour.png"] andSelectedBlock:^{
        NSLog(@"Video selected");
        
    }];

    [menuView show];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
