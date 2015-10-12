//
//  HomeModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "ListRecommendsModel.h"
#import "TopRecommendsModel.h"

@interface HomeModel : JSONModel

//@property(nonatomic,strong)NSArray *adList;

@property(nonatomic,strong)NSArray<ListRecommendsModel> *listRecommends;

@property(nonatomic,strong)NSArray<TopRecommendsModel> *topRecommends;

@end
