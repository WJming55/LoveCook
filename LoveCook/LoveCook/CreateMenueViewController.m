//
//  CreateMenueViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "CreateMenueViewController.h"
#import "CreateTitleCell.h"
#import "CreateCell1.h"
#import "CreateCell2.h"
#import "CreateCell3.h"

typedef void(^BLOOCK) (void);

@interface CreateMenueViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int one;
    int two;
    int three;
    BLOOCK _delelteBlock;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataAry1;
@property(nonatomic,strong)NSMutableArray *dataAry2;
@property(nonatomic,strong)NSMutableArray *dataAry3;
@end

@implementation CreateMenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"创建菜谱";
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CreateTitleCell" bundle:nil] forCellReuseIdentifier:@"CreateTitleCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CreateCell1" bundle:nil] forCellReuseIdentifier:@"CreateCell1"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CreateCell2" bundle:nil] forCellReuseIdentifier:@"CreateCell2"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CreateCell3" bundle:nil] forCellReuseIdentifier:@"CreateCell3"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    one=2;
    two=2;
    three=2;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return one;
    }
    if (section==2) {
        return two;
    }
    if (section==3) {
        return three;
    }
    return 1;
}
//该行是否可以进行编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   return YES;
}
//提交编辑状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    one=one-1;
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     __weak typeof(self) weakSelf=self;
    if (indexPath.section==0) {
        CreateTitleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CreateTitleCell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section==1) {
            CreateCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"CreateCell1" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.deleteButton.tag=indexPath.row;
            cell.myBlock1=^void{
               // [weakSelf.tableView reloadData];
               // weakSelf.tableView.editing=YES;
                if (one>1) {
                    one=one-1;
                    [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [weakSelf.tableView reloadData];
                }
                
            };
            return cell;
    }
    if (indexPath.section==2) {
        CreateCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"CreateCell2" forIndexPath:indexPath];
        cell.myBlock2=^void{
//            two=two-1;
//            [weakSelf.tableView reloadData];
            if (two>1) {
                two=two-1;
                [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [weakSelf.tableView reloadData];
            }

        };

        return cell;
    }
    if (indexPath.section==3) {
        CreateCell3 *cell=[tableView dequeueReusableCellWithIdentifier:@"CreateCell3" forIndexPath:indexPath];
        cell.myBlock3=^void{
//            three=three-1;
//            [weakSelf.tableView reloadData];
            if (three>1) {
                three=three-1;
                [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [weakSelf.tableView reloadData];
            }

        };
        return cell;
    }
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"999999999999999");
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==1) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        label.text=@"  材料 :";
        return label;
    }
    if (section==2) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        label.text=@"  做法 :";
        return label;
    }
    if (section==3) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        label.text=@"  小贴士 :";
        return label;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==1) {
        UIButton *button=[Factory createButtonWithTitle:@"添加一行材料" frame:CGRectMake(0, 0, 50, 30) target:self selector:@selector(ToAdd:)];
        button.backgroundColor=[UIColor orangeColor];
        button.tag=1;
        return button;
    }
    if (section==2) {
        UIButton *button=[Factory createButtonWithTitle:@"添加一行做法" frame:CGRectMake(0, 0, 50, 30) target:self selector:@selector(ToAdd:)];
        button.backgroundColor=[UIColor orangeColor];
        button.tag=2;
        return button;
    }

    if (section==3) {
        UIButton *button=[Factory createButtonWithTitle:@"添加一行贴士" frame:CGRectMake(0, 0, 50, 30) target:self selector:@selector(ToAdd:)];
        button.backgroundColor=[UIColor orangeColor];
        button.tag=3;
        return button;
    }
    return nil;
}
-(void)ToAdd:(UIButton *)button{
    switch (button.tag) {
        case 1:
        {
            one=one+1;
            [self.tableView reloadData];
        }
            break;
        case 2:
        {
            two++;
            [self.tableView reloadData];
        }
            break;
        case 3:
        {
            three++;
            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 150;
    }
    if (indexPath.section==2) {
        return 80;
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end




































