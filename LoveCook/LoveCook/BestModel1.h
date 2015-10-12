//
//  BestModel1.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol BestModel1 <NSObject>


@end

@interface BestModel1 : JSONModel

@property(nonatomic,copy)NSString *createtime;

@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *recipeididlist;

@property(nonatomic,copy)NSString *wid;

@property(nonatomic,copy)NSString *uid;


@end
/*
 "createtime": "2015-09-19 17:23:31.0",
 "id": "11859145",
 "name": "15道深夜食堂料理清单",
 "recipeididlist": "117998,6825005,115263,7803464,8964461,7821572,106527,7904432,94772,6851070,3928811,6825152,7816091,7860379,8545452",
 "state": 0,
 "uid": "2889377",
 "wid": "11859146"
 
 */