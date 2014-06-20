//
//  BGMView.h
//  Flappy Bird Prototype
//
//  Created by 馬 岩 on 14-6-20.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BGMBird.h"

@interface BGMView : UIView

@property NSDate* lastUpdateDate;

@property NSTimer* gameTimer;

// camera's position, start from 0
@property float cameraX;

@property NSMutableArray* obstacles;
@property BGMBird* bird;

@property NSInteger currentCheckPostIndex;

- (void)initialize;

- (void)startTimer;

- (void)stopTimer;

@end
