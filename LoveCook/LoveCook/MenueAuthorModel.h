//
//  MenueAuthorModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol MenueAuthorModel <NSObject>


@end

@interface MenueAuthorModel : JSONModel
@property(nonatomic,copy)NSString *author;

@property(nonatomic,copy)NSString *contentid;

@property(nonatomic,copy)NSString *id;
@end

/*
 "author": "你若不惜我亦不爱",
 "contentid": "7437554",
 "editname": "",
 "id": "7437555",
 "title": "腊肉炒蒜苗",
 "url": "http://www.ecook.cn/ecook/viewContent.shtml?id=7437554",
 "version": "1"
 */