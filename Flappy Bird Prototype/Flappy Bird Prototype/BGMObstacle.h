//
//  BGMObstacle.h
//  Flappy Bird Prototype
//
//  Created by 馬 岩 on 14-6-20.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGMObstacle : NSObject

@property CGRect topFrame, bottomFrame;

- (instancetype)initWithPositionX:(float)x screenHeight:(float)screenHeight;

- (void)drawObstacleInContext:(CGContextRef)context cameraX:(float)cameraX;

@end
