//
//  CreateCell2.h
//  LoveCook
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^BOOCK)(void);
@interface CreateCell2 : UITableViewCell
@property(nonatomic,copy)BOOCK myBlock2;
- (IBAction)deleteClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
