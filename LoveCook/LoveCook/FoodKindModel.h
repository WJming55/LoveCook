//
//  FoodKindModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "FoodKinfInfoModel.h"
#import "TypeModel.h"

@protocol FoodKindModel <NSObject>


@end


@interface FoodKindModel : JSONModel

@property(nonatomic,strong)NSArray<FoodKinfInfoModel> *list;

@property(nonatomic,copy)NSDictionary *tagspo;

@end
