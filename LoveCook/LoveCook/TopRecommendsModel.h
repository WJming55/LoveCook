//
//  TopRecommendsModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol TopRecommendsModel <NSObject>



@end

@interface TopRecommendsModel : JSONModel

@property(nonatomic,copy)NSString *author;

@property(nonatomic,copy)NSString *displaytime;

@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *imageid;

@property(nonatomic,copy)NSString *ontop;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *uptime;

@property(nonatomic,copy)NSString *uri;



@end

/*
 
 "author": "中纽Nelson",
 "displaytime": "2015-09-18",
 "id": "2444",
 "imageid": "11851728",
 "ontop": "1",
 "status": "1",
 "title": "来自米和面的极简美味banner",
 "type": "image",
 "uptime": "2015-09-18 08:35:46.0",
 "uri": "ecook://collection?id=118
 */












