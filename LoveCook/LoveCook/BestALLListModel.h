//
//  BestALLListModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "BestListFoodModel.h"

@interface BestALLListModel : JSONModel
@property(nonatomic,copy)NSArray<BestListFoodModel> *list;
@end
