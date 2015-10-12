//
//  FoodKinfInfoModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol FoodKinfInfoModel <NSObject>


@end

@interface FoodKinfInfoModel : JSONModel

//@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *tagid;

//@property(nonatomic,copy)NSString *typename;

//@property(nonatomic,copy)NSString *typeid;

@end
/*
 
 "id": "1176",
 "name": "蛋糕",
 "ord": 30,
 "tagid": "571",
 "typeid": "571",
 "typename": "蛋糕"
 */