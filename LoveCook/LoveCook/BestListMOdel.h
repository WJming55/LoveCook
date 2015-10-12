//
//  BestListMOdel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "BestModel1.h"

@interface BestListMOdel : JSONModel

@property(nonatomic,copy)NSArray<BestModel1> *list;

@end
