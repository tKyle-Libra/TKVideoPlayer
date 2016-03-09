//
//  TKVideoPlayerView.m
//  TKVideoPlayerDemo
//
//  Created by 同乐 on 16/3/9.
//  Copyright © 2016年 tKyle. All rights reserved.
//

#import "TKVideoPlayerView.h"
#import <Masonry/Masonry.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>

@interface TKVideoPlayerView()

@property (strong , nonatomic) AVPlayer *player;

/**
 *  视频显示
 */
@property (strong , nonatomic) UIView *playerView;

/**
 *  playView上 满屏播放按钮
 */
@property (strong , nonatomic) UIButton *topPlayerButton;

/**
 *  playView 显示栏
 */
@property (strong , nonatomic) UIView *playerBarView;

/**
 *  视频 播放,暂停 功能键
 */
@property (strong , nonatomic) UIButton *playerStatusButton;

/**
 *  进度控制
 */
@property (strong , nonatomic) UISlider *playerSlider;

/**
 *  缓存
 */
@property (strong , nonatomic) UIProgressView *playerProgress;

/**
 *  时间
 */
@property (strong , nonatomic) UILabel *timeLabe;

@end

@implementation TKVideoPlayerView



-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [self InitControls];
    return  self;
}

-(id) init
{
    if (!self)
    {
        self = [super init];
    }
    [self InitControls];
    return self;
}


-(void) InitControls
{
    _playerView = [[UIView alloc] init];
    _playerView.backgroundColor = [UIColor blackColor];
    [self addSubview:_playerView];
    
    _topPlayerButton = [[UIButton alloc] init];
    [_topPlayerButton setBackgroundColor:[UIColor clearColor]];
    [_topPlayerButton setTitle:@"播放" forState:UIControlStateNormal];
    [_topPlayerButton addTarget:self action:@selector(MediaPlayAction) forControlEvents:UIControlEventTouchUpInside];
    [_playerView addSubview:_topPlayerButton];
    
    _playerBarView = [[UIView alloc] init];
    _playerBarView.backgroundColor = [UIColor blackColor];
    [self addSubview:_playerBarView];
    
    _playerStatusButton = [[UIButton alloc] init];
    [_playerStatusButton setTitle:@"暂停" forState:UIControlStateNormal];
    [_playerStatusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_playerBarView addSubview:_playerStatusButton];
    
    _playerProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [_playerBarView addSubview:_playerProgress];
    
    _playerSlider = [[UISlider alloc] init];
    [_playerBarView addSubview:_playerSlider];

    _timeLabe = [[UILabel alloc] init];
    _timeLabe.text = @"时间";
    _timeLabe.textColor = [UIColor whiteColor];
    [_playerBarView addSubview:_timeLabe];
    
    [self InitConstraints];
}

-(void) InitConstraints
{
    [_playerView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(_playerBarView.mas_top);
    }];
    [_topPlayerButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.right.top.bottom.mas_equalTo(_playerView);
    }];
    
    [_playerBarView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(_playerView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    [_playerStatusButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(_playerBarView.mas_centerY);
        make.left.mas_equalTo(_playerBarView.mas_left).offset(15);
        make.height.mas_equalTo(20);
    }];
    
    [_playerSlider mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(_playerBarView.mas_centerY);
        make.left.mas_equalTo(_playerStatusButton.mas_right).offset(15);
        make.right.mas_equalTo(_timeLabe.mas_left).offset(-15);
    }];
    
    [_playerProgress mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(_playerBarView.mas_centerY);
        make.left.right.mas_equalTo(_playerSlider);
    }];
    
    [_timeLabe mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(_playerBarView.mas_centerY);
        make.left.mas_equalTo(_playerSlider.mas_right).offset(0);
        make.right.mas_equalTo(_playerBarView.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
}

-(void) MediaPlayAction
{
    AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"]];
    _player = [AVPlayer playerWithPlayerItem:playItem];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    layer.frame = _playerView.bounds;
    [_playerView.layer addSublayer:layer];
    
    [_player play];
}



@end
