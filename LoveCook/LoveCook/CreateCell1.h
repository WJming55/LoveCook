//
//  CreateCell1.h
//  LoveCook
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^BOOCK)(void);

@interface CreateCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property(nonatomic,copy)BOOCK myBlock1;
- (IBAction)deleteClick:(id)sender;

@end
