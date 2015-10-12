//
//  MyVideoViewController.m
//  LoveCook
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 WJMing. All rights reserved.
//

#import "MyVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define kURL @"http://tv.ecook.cn/s/3227110.mp4"//

@interface MyVideoViewController ()
{
    MPMoviePlayerViewController *_mpVC;
}
@end

@implementation MyVideoViewController

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
        //_mpVC.moviePlayer.shouldAutoplay=YES;
        [self presentViewController:_mpVC animated:YES completion:nil];
    }
    
   // [_mpVC.moviePlayer play];
    
    
    
}
-(void)playVideoBack:(NSNotification *)nf{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [_mpVC.moviePlayer stop];
    [_mpVC dismissViewControllerAnimated:YES completion:nil];
    if (_mpVC) {
        _mpVC=nil;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end























