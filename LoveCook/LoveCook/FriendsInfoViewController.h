//
//  FriendsInfoViewController.h
//  LoveCook
//
//  Created by qianfeng on 15/9/20.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "BaseViewController.h"

@interface FriendsInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,copy)NSString *urlStr;

@end
