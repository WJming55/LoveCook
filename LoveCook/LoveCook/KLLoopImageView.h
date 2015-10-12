//
//  KLLoopImageView.h
//  KL图片轮播
//
//  Created by KellenYang on 15/9/7.
//  Copyright (c) 2015年 KellenYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLLoopImageView : UIView

@property (assign, nonatomic) int bannerCount;   // 多少个Imgae循环滚动，默认为2
@property (strong, nonatomic) NSArray *images;   // 滚动图片的数组

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;
- (void)steup;

@end
