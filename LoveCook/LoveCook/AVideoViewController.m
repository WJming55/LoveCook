//
//  AVideoViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "AVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define kURL @"http://tv.ecook.cn/s/3227110.mp4"//流媒体格式

@interface AVideoViewController ()
{
    MPMoviePlayerViewController *_mpVC;
}
@end

@implementation AVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createNetVideoWithPath:kURL];
}

-(void)createNetVideoWithPath:(NSString *)path{
    NSURL *url=nil;
    if ([path hasPrefix:@"http://"]||[path hasPrefix:@"https://"]) {
        //网络视频
        url = [NSURL URLWithString:path];//加载网络地址 转化为NSURL
    }else{
        
    }
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    if (!_mpVC) {
        _mpVC=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
        _mpVC.moviePlayer.shouldAutoplay=YES;
    }
    
    [_mpVC.moviePlayer play];
    
    [self presentViewController:_mpVC animated:YES completion:nil];
    
}
-(void)playVideoBack:(NSNotification *)nf{
    if (_mpVC) {
        [_mpVC.moviePlayer stop];
        _mpVC=nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
   [_mpVC dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end




















