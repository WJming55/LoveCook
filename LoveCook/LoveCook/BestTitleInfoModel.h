//
//  BestTitleInfoModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@interface BestTitleInfoModel : JSONModel

@property(nonatomic,copy)NSString *collectionid;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *weibo;

@property(nonatomic,copy)NSString *pic;


@end
/*
 "addtime": "09-19 17:23",
 "addtimeFull": "2015-09-19 17:23:31",
 "bannerimageid": "",
 "collectionid": "11859145",
 "comment": 0,
 "disabled": "0",
 "enjoy": 98,
 "forward": 0,
 "id": "11859146",
 "list": "",
 "mid": "",
 "nickname": "水淼淼的",
 "pic": "2889390",
 "picid": "",
 "region": "",
 "terminal": "3",
 "title": "15道专属深夜食堂的料理清单",
 "total": 0,
 "type": "0",
 "uid": "2889377",
 "updatetime": "2015-09-19 17:23:31.0",
 "usercontent": "",
 "weibo": "长夜漫漫，一个人吃饭。特殊的时间点，只有食物才能治愈我的身心。"
 */