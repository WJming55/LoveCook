//
//  MenueListInfoModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "MenueAuthorModel.h"

@protocol MenueListInfoModel <NSObject>

@end

@interface MenueListInfoModel : JSONModel

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *contenthtml;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *imageid;

@property(nonatomic,copy)NSString *id;//、、、、、、、、、、、、、、、、、

@property(nonatomic,strong)MenueAuthorModel<Optional> *referencePo;

@end
/*
 
 "content": "材料：低筋面粉100克（材料）
 contenthtml
 "name": "金枪鱼沙拉泡芙",
 "qqChinaPo": null,
 "referencePo": null,
 "sortCommonPo": null,
 imageid
 */