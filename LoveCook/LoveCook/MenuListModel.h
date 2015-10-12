//
//  MenuListModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "MenueListInfoModel.h"

@interface MenuListModel : JSONModel
@property(nonatomic,strong)NSArray<MenueListInfoModel> *list;
@end
