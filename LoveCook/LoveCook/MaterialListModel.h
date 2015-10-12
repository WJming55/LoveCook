//
//  MaterialListModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol MaterialListModel <NSObject>


@end

@interface MaterialListModel : JSONModel

@property(nonatomic,copy)NSString *contentid;

@property(nonatomic,copy)NSString *dosage;

@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *mwikipediaid;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *ordernum;

@property(nonatomic,copy)NSString *version;

@end
/*
 
 "contentid": "11840026",
 "dosage": "80克",
 "id": "767690",
 "mwikipediaid": "95645",
 "name": "巧克力酱",
 "ordernum": 1,
 "version": 0
 */