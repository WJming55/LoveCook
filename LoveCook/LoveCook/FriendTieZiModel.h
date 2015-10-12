//
//  FriendTieZiModel.h
//  LoveCook
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "JSONModel.h"

@protocol FriendTieZiModel <NSObject>



@end

@interface FriendTieZiModel : JSONModel
@property (nonatomic, copy) NSString *addtimeFull;
@property (nonatomic, assign) int enjoy;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *picid;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, strong) NSNumber *forward;
@property (nonatomic, copy) NSString *terminal;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *list;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *usercontent;
@property (nonatomic, copy) NSString *disabled;
@property (nonatomic, copy) NSString *weibo;
@property (nonatomic, copy) NSString *collectionid;
@property (nonatomic, assign) int comment;
@property (nonatomic, copy) NSString *bannerimageid;
@end
