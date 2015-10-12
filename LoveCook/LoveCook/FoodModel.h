//
//  FoodModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "MaterialListModel.h"

@protocol FoodModel <NSObject>


@end

@interface FoodModel : JSONModel

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *authorname;

@property(nonatomic,copy)NSString *imageid;

@property(nonatomic,copy)NSArray<MaterialListModel> *materialList;

@property(nonatomic,copy)NSArray *stepList;

@property(nonatomic,copy)NSArray *tipsList;

@end
/*
 "addtime": "2015-09-16 12:18:19",
 "authorid": "1526394",
 "authorname": "猪猪_qq_645430",
 "content": "材料：巧克力酱80克低筋面粉
 
 "contenthtml": "",
 "edittime": "2015-09-16 12:18:19",
 "flower": 0,
 "id": "11840026",
 "imageid": "11839960",
 "info": "",
 "isOfficial": 0,
 
 "materialList":
 
 
 "name": "巧克力蛋黄月饼",
 "start": 0,
 "state": 1,
 "stepList": [
 
 "tipsList":
 
 */
