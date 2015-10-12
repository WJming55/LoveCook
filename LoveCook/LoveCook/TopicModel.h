//
//  TopicModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol TopicModel <NSObject>


@end

@interface TopicModel : JSONModel
@property(nonatomic,assign)int enjoy;
@property(nonatomic,assign)int comment;

@property(nonatomic,copy)NSString *addtime;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *picid;

@property(nonatomic,copy)NSString *pic;


@end
/*
 "addtime": "09-21 08:26",
 "addtimeFull": "2015-09-21 08:26:15",
 "bannerimageid": "",
 "collectionid": "",
 "comment": 8,
 "disabled": "0",
 "enjoy": 2,
 "forward": 0,
 "id": "11867732",
 "list": "",
 "mid": "",
 "nickname": "猪猪_qq_645430",
 "pic": "9411225",
 "picid": "11867730",
 "region": "",
 "terminal": "3",
 "title": "病号饭",
 "total": 0,
 "type": "0",
 "uid": "1526394",
 "updatetime": "2015-09-21 10:17:50.0",
 "usercontent": "",
 "weibo": "一粥一饭当思来之不易，
 
 */