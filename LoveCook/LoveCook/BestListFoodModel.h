//
//  BestListFoodModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol BestListFoodModel <NSObject>



@end

@interface BestListFoodModel : JSONModel

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *contenthtml;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *imageid;


@end
/*
 
 "category": "",
 "collectNum": 0,
 "collectid": "",
 "commentNum": 0,
 "content": "材料：鸡蛋2个、芝士2片、
 
 contenthtml
 
 "ctype": "",
 "discussionPoList": [],
 "editid": "",
 "editname": "",
 "enjoyNum": 0,
 "name": "芝心鸡蛋卷",
 "qqChinaPo": null,
 "evaluationPo": null,
 "flower": 0,
 "gettime": {
 
 "author": "居然",
 "contentid": "117998",
 "editname": "",
 "id": "7866192",
 "title": "芝心鸡蛋卷",
 "imageid": "685117",
 "imageidList": [],
 "isrec": "",
 
 
 */






