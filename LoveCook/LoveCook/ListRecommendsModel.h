//
//  ListRecommendsModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol ListRecommendsModel <NSObject>


@end

@interface ListRecommendsModel : JSONModel

@property(nonatomic,assign)int contentCount;

@property(nonatomic,copy)NSString *contentIds;

@property(nonatomic,copy)NSString *order;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *type;


@end
/*
 
 
 "contentCount": 10,
 "contentIds": "2410,2408,2407,2395,2394,2393,2392,2378,2377,2376",
 "order": 0,
 "title": "每日菜单",
 "type": "image"
 */
 
