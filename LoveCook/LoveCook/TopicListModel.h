//
//  TopicListModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "TopicModel.h"

@interface TopicListModel : JSONModel

@property(nonatomic,strong)NSArray<TopicModel> *list;

@end
