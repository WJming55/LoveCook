//
//  FoodListModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "FoodModel.h"

@interface FoodListModel : JSONModel

@property(nonatomic,strong)NSArray<FoodModel> *list;

@end
