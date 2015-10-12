//
//  SmollKindListModel.h
//  LoveCook
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "SmollKindInfoModel.h"

@interface SmollKindListModel : JSONModel
@property(nonatomic,strong)NSArray<SmollKindInfoModel> *list;
@end
