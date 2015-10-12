//
//  ListViewController.h
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property(nonatomic,copy)NSString *classStr;
@property(nonatomic,copy)NSString *urlStr;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,assign)BOOL isSeven;
@property(nonatomic,assign)int flag;

-(id)initWithCellClass:(NSString *)classStr URLString:(NSString *)urlstr title:(NSString *)titleStr;

@end
