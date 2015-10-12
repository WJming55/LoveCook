//
//  FriendTitleModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@interface FriendTitleModel : JSONModel

@property(nonatomic,assign)int fans;
@property(nonatomic,assign)int follow;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *sex;

@property(nonatomic,copy)NSString *pic;


@end
/*
 
 "article": 346,
 "collection": 43,
 "enjoyWeibo": 46,
 "fans": 201,
 "follow": 2,
 "id": "147844",
 "pic": "9411225",
 "profile": "",
 "recommend": 0,
 "region": "",
 "sex": "0",
 "title": "猪猪_qq_645430",
 "uid": "1526394",
 "userContent": 24
 */