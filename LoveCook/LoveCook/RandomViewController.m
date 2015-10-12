//
//  RandomViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "RandomViewController.h"
#import "StepListViewController.h"
#import "ListStepViewController.h"


#import <AVFoundation/AVFoundation.h>


@interface RandomViewController ()

@end

@implementation RandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self playSound];
}
-(void)playSound{

    //拿到音频文件所在的目录或者沙盒路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"音效" ofType:@"caf"];
    //将资源文件放入内存，转化成NSData的数据格式
    NSData *music = [NSData dataWithContentsOfFile:path];
    //接收播放中出现的问题
    NSError *error = nil;
    //声明一个播放组件
    //initWithData中的data是播放的资源或者需要解读的数据
    //&error指的是上面声明的error的地址
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:music error:&error];
    [player play];//播放声音
    NSLog(@"yyyyyyyy");
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    //StepListViewController *svc=[[StepListViewController alloc] init];
    ListStepViewController *svc=[[ListStepViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];

}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
































