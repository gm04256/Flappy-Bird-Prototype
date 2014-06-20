//
//  BGMBird.h
//  Flappy Bird Prototype
//
//  Created by 馬 岩 on 14-6-20.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGMBird : NSObject

@property float speedX, speedY;
@property float acceleration;
@property CGRect frame;

- (instancetype)initWithSpeedX:(float)speedX speedY:(float)speedY positionX:(float)x positionY:(float)y;

- (void)drawBirdInContext:(CGContextRef)context cameraX:(float)cameraX;

@end
