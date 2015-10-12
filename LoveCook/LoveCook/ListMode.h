//
//  ListMode.h
//  LoveCook
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "TopRecommendsModel.h"

@interface ListMode : JSONModel

@property(nonatomic,strong)NSArray<TopRecommendsModel> *list;

@end
