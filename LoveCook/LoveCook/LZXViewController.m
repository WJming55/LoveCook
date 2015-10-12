//
//  LZXViewController.m
//  CustomMoviePlayer
//
//  Created by LZXuan on 15-1-13.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import "LZXViewController.h"
#import "VideoView.h"
#import "UIView+Addition.h"
#import <CoreMedia/CoreMedia.h>//这个头文件中 包含 一些底层的一些视频参数
#import "BreakPointDownload.h"
#import "NSString+Hashing.h"

//#define kUrl @"http://tv.ecook.cn/s/3227110.mp4"

@interface LZXViewController ()
{
    //创建一个播放视频的界面
    VideoView *_videoView;
    //视频播放器
    AVPlayer *_player;
    //滑块
    UISlider *_slider;
    
    BreakPointDownload *_download;//下载对象地址
    NSTimer *_timer;
    UILabel *_label;
    UIProgressView *progressView;
    NSMutableString *KUrl;
    UIActivityIndicatorView *_myActivity;
}

@property (nonatomic) unsigned long long totalFileSize;
//已经下载的大小
@property (nonatomic) unsigned long long loadedSize;
//前1s之前已经下载的大小
@property (nonatomic) unsigned long long preloadedSize;
//下载速度
@property (nonatomic) double speed;
@end

@implementation LZXViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self showUI];
    
}

- (void)showUI {
    KUrl=[[NSMutableString alloc] initWithFormat:@"%@%@%@",@"http://tv.ecook.cn/s/",self.uriStr,@".mp4"];
    _videoView = [[VideoView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 300)];
    _videoView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_videoView];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(80, _videoView.bottom-30, self.view.width-160, 30)];
    _slider.maximumValue = 1.0;
    _slider.minimumValue = 0.0;
    [_slider addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    NSArray *arr = @[@"播放",@"暂停",@"下载",@"暂停"];
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(50+50*i, _slider.bottom, 60, 50);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = 101+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    _label=[[UILabel alloc] initWithFrame:CGRectMake(10, _slider.bottom+100, 300, 50)];
    _label.numberOfLines=2;
    _label.backgroundColor=[UIColor grayColor];
    [self.view addSubview:_label];
    
    progressView=[[UIProgressView alloc] initWithFrame:CGRectMake(10, _label.bottom+20, 200, 30)];
    [self.view addSubview:progressView];
    
    //先创建下载对象
    _download = [[BreakPointDownload alloc] init];
    //从本地获取 比例
    progressView.progress = [[NSUserDefaults standardUserDefaults] doubleForKey:[KUrl MD5Hash]];
    
   
    
}
#pragma mark - UISlider 
- (void)sliderClick:(UISlider *)slider {
    if (_player) {
    //通过 slider 当前进度 修改 视频的播放进度
    //根据进度 算出当前的时间
    //CMTimeMultiplyByFloat64 根据当前进度值和总时间转换成CMTime 视频时间
    //跳转到指定时间seekToTime
    [_player seekToTime:CMTimeMultiplyByFloat64(_player.currentItem.duration, slider.value)];
    }
}

#pragma mark - button
- (void)btnClick:(UIButton *)button{
    switch (button.tag) {
        case 101:
            [self playVideo];
            break;
        case 102:
            [self pauseVideo];
            break;
        case 103:
        {
            if (!_timer) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateSpeed:) userInfo:nil repeats:YES];
            }
            //typeof(self)  获取 self 的类型
            __weak typeof(self) weakSelf = self;
            
            [_download downloadDataFromUrl:KUrl successBlock:^(BreakPointDownload *download) {
                //下载 过程 中 要一直回调的方法
                weakSelf.totalFileSize = download.totalFileSize;
                weakSelf.loadedSize = download.loadedFileSize;
                //换算成M 1M = 1024KB = 1024*1024*字节
                double fileSize = weakSelf.totalFileSize / 1024.0 / 1024.0;
                //下载比例
                double scale = (double)weakSelf.loadedSize/weakSelf.totalFileSize;
                progressView.progress = scale;
                _label.text = [NSString stringWithFormat:@"%.2f%% 文件总大小%.2fM download speed:%.2fKB/S",scale*100,fileSize,weakSelf.speed];
                //下载 之后 保存到本地 下载进度
                [[NSUserDefaults standardUserDefaults] setDouble:scale forKey:[KUrl MD5Hash]];
                //立即保存到本地
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                if (scale >= 1.0) {
                    //下载完成
                    _label.text=@"下载完成";
                    if ([_timer isValid]) {//是否有效
                        [_timer invalidate];//销毁
                        _timer = nil;
                    }
                }
                
            }];
            
        }
            break;
        case 104:
        {
            //手动停止下载
            [_download stopDownload];
            if ([_timer isValid]) {//是否有效
                [_timer invalidate];//销毁
                _timer = nil;
            }

        }
            break;
        default:
            break;
    }
}

//定时器获取下载速度
- (void)updateSpeed:(NSTimer *)timer {
    //当前 已经下载 - 前1s 已经下载的大小
    self.speed = (self.loadedSize - self.preloadedSize)/1024.0;
    self.preloadedSize = self.loadedSize;
}

#pragma mark - 暂停视频
- (void)pauseVideo {
    if (_player) {
        //暂停
        [_player pause];
    }
}

- (void)playVideo {
    
    _myActivity=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _myActivity.center=_videoView.center;
     _myActivity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [_myActivity startAnimating];
    [_videoView addSubview:_myActivity];
    
    if (_player) {
        [_player play];//如果正在播放 又点击播放 是没有影响的
        return;
    }
    //本地的
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp4"];
//    [self loadVideoFromPath:path];
    //网络视频 m3u8格式
    [self loadVideoFromPath:KUrl];
}

//VLC
- (void)loadVideoFromPath:(NSString *)path {
    if (path.length == 0) {
        NSLog(@"没有视频资源");
        return;
    }
    //区分 网络资源
    NSURL *url = nil;
    if ([path hasPrefix:@"http://"]||[path hasPrefix:@"https://"]) {
        url = [NSURL URLWithString:path];
    }else {
        url = [NSURL fileURLWithPath:path];
    }
    
    //1.AVAsset 里面保存了视频的所有信息
    //[AVAsset assetWithURL:url] 获取 url 对应的视频的信息
    //对视频进行预加载  获取 视频的信息 和视频的参数
    AVAsset *set = [AVAsset assetWithURL:url];
    
    //2.预加载 视频 通过  @"tracks"获取预加载信息

    [set loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{
       
        [_myActivity stopAnimating];
        //1. 通过 @"tracks" 获取当前视频预加载视频的状态
        AVKeyValueStatus status =  [set statusOfValueForKey:@"tracks" error:nil];
        //2.判断是或否预加载完成
        //AVKeyValueStatusLoaded预加载完成
        if (status == AVKeyValueStatusLoaded) {
            //3.AVPlayerItem 视频的一个具体的项目，包括视频的进度 视频的总时间， 视频的类型
            AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:set];
            //4.通过item 创建一个音乐播放器
            //_player通过item 就可以获取 当前视频的信息
            _player = [[AVPlayer  alloc] initWithPlayerItem:item];
            
            //5.把_player放在videoView的layer层
            //专门播放视频的层
            [_videoView setVideoViewWithPlayer:_player];
            //6.播放
            [_player play];
            
            /*
             下面我们要通过视频的播放时间来控制器slider
             1.可以用定时器 来控制 每个一段时间 去修改
             2.用_player自带的 线程进行获取当前时间 去修改slider
             //下面我们采用第二种
             //CMTime 视频的时间结构体 里面保存时间
             CMTimeMake(1.0, 1.0) 产生一个 CMTime结构体
             表示的每隔1s
             两个 1.0表示 帧率 和 帧数   帧数/帧率-->时间
             */
            
            /*
             起一个线程 每隔1s 获取一下当前视频的状态
             用gcd 的全局队列 增加一个异步的任务
             */
            
            __weak AVPlayer *blockPlayer = _player;
            __weak UISlider *blockSlider = _slider;
            //因为 当前对象 强引用了 _player -》player有对 block进行了强引用
            //block 在使用的时候 内部进行copy ，如果出现对self 或者 self 成员变量进行操作 这时会对这些值进行拷贝
            //这样就造成了两个强引用 导致死锁
            //这时为了解决这个问题 arc下 我们可以自 block 外面用__weak 产生一个新的变量 弱引用 self 或者 成员变量 这样block 内部就不会对 self 和他的成员变量进行拷贝操作 一强一弱 不会导致死锁
            
            [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) usingBlock:^(CMTime time) {
                //从视频项目中获取当前时间
                
                CMTime t1 = blockPlayer.currentTime;
                //从视频项目中获取视频总时间
                CMTime t2 = blockPlayer.currentItem.duration;
                //CMTimeGetSeconds 把一个CMTime 转化成秒
                float currentTimer = CMTimeGetSeconds(t1);
                float total = CMTimeGetSeconds(t2);
                //算出 进度
                float progressCur = currentTimer/total;
                //当前这个代码是子线程调用的
                //通知主线程 来刷新 UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    //主线程 刷新UI
                    blockSlider.value = progressCur;
                });

            }];
        }
    }];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
