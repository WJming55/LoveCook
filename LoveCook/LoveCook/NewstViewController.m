//
//  NewstViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "NewstViewController.h"
#import "DaRenTableViewCell.h"

@interface NewstViewController ()

@end

@implementation NewstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor whiteColor];
    
    NSLog(@"子页面");
    [self.tableView reloadData];
    
//    self.tableView.delegate=self;
//    self.tableView.dataSource=self;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"DaRenTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellId"];

}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"魏金明山东省地方vsdgvsbvgd");
//
//    return 20;
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
//
//    NSLog(@"魏金明");
//    return cell;
//}
//




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end















