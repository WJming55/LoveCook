//
//  FoodMenueLIstController.h
//  LoveCook
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "BaseViewController.h"

@interface FoodMenueLIstController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,copy)NSString *targid;
@property(nonatomic,copy)NSString *listId;
@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *URLString;

@end
