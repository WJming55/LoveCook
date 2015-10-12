//
//  TypeModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol TypeModel <NSObject>


@end

@interface TypeModel : JSONModel
@property(nonatomic,copy)NSString *name;

//@property(nonatomic,copy)NSString *id;

//@property(nonatomic,copy)NSString *tagid;
@end
/*
 "id": "570",
 "name": "烘培",
 "ord": 0,
 "tagid": "",
 "typeid": "",
 "typename": ""
 */