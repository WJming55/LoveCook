//
//  SmollKindInfoModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol SmollKindInfoModel <NSObject>


@end

@interface SmollKindInfoModel : JSONModel
@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *tagid;

@property(nonatomic,copy)NSString *typeid;
@end
/*
 
 "id": "1211",
 "name": "泡芙",
 "ord": 24,
 "tagid": "607",
 "typeid": "24",
 "typename": "甜品"
 */