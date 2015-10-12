//
//  FriendListModel.h
//  LoveCook
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"
#import "FriendTieZiModel.h"

@interface FriendListModel : JSONModel
@property(nonatomic,strong)NSArray<FriendTieZiModel> *list;


@end
