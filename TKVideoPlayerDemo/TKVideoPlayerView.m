//
//  TKVideoPlayerView.m
//  TKVideoPlayerDemo
//
//  Created by 同乐 on 16/3/9.
//  Copyright © 2016年 tKyle. All rights reserved.
//

#import "TKVideoPlayerView.h"
#import "TKVideoPlayerSection.h"
#import "TKVideoPlayerStatusBarSection.h"
#import <Masonry/Masonry.h>

@interface TKVideoPlayerView()

@property (strong , nonatomic) TKVideoPlayerView *playerView;

@property (strong , nonatomic) TKVideoPlayerStatusBarSection *playerStateBarView;

@end

@implementation TKVideoPlayerView


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
    _playerView = [[TKVideoPlayerView alloc] init];
    _playerView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(VideoPlayerTapAction)];
    [_playerView addGestureRecognizer:tap];
    [self addSubview:_playerView];
    
    _playerStateBarView = [[TKVideoPlayerStatusBarSection alloc] init];
    _playerStateBarView.backgroundColor = [UIColor greenColor];
    [self addSubview:_playerStateBarView];
    
    [self UpdateConstraints:NO];
}

-(void) UpdateConstraints:(BOOL)isHidden
{
    if (!isHidden)
    {
        [_playerView mas_updateConstraints:^(MASConstraintMaker *make)
         {
             make.top.left.right.mas_equalTo(self);
             make.bottom.mas_equalTo(_playerStateBarView.mas_top).offset(-40);
         }];
        
        [_playerStateBarView mas_updateConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(_playerView.mas_bottom);
             make.left.right.bottom.mas_equalTo(self);
         }];
    }
    else
    {
        [_playerView mas_updateConstraints:^(MASConstraintMaker *make)
        {
            make.top.left.right.bottom.mas_equalTo(self);
        }];
        
        [_playerStateBarView removeConstraints:_playerStateBarView.constraints];
    }
    
}

-(void) VideoPlayerTapAction
{
    if (_playerStateBarView.hidden)
    {
        [self UpdateConstraints:NO];
        _playerStateBarView.hidden = NO;
    }
    else
    {
        [self UpdateConstraints:YES];
        _playerStateBarView.hidden = YES;
    }
}

@end
