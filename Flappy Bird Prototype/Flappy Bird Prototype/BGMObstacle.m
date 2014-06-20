//
//  BGMObstacle.m
//  Flappy Bird Prototype
//
//  Created by 馬 岩 on 14-6-20.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMObstacle.h"

#import "BGMConstants.h"

@implementation BGMObstacle

- (instancetype)initWithPositionX:(float)x screenHeight:(float)screenHeight
{
	if(self = [super init])
	{
		// initialize the obstacle
		// The top post' height is from 50 to (screenHeight - OBSTACLE_GAP_HEIGHT - 100)
		float topFrameHeight = 50 + floorf(((double)arc4random() / ARC4RANDOM_MAX) * (screenHeight - OBSTACLE_GAP_HEIGHT - 50));
		// set the top post
		self.topFrame = CGRectMake(x, 0, OBSTACLE_WIDTH, topFrameHeight);
		// set the bottom post
		self.bottomFrame = CGRectMake(x, topFrameHeight + OBSTACLE_GAP_HEIGHT, OBSTACLE_WIDTH, screenHeight - topFrameHeight - OBSTACLE_GAP_HEIGHT);
	}
	return self;
}

- (void)drawObstacleInContext:(CGContextRef)context cameraX:(float)cameraX
{
	// save status
	CGContextSaveGState(context);
	
	// set pen
	CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
	CGContextSetLineWidth(context, 2);
	
	// add top obstacle
	CGContextAddRect(context, CGRectMake(self.topFrame.origin.x - cameraX, 0, OBSTACLE_WIDTH, self.topFrame.size.height));

	// add bottom obstacle
	CGContextAddRect(context, CGRectMake(self.bottomFrame.origin.x - cameraX, self.bottomFrame.origin.y, OBSTACLE_WIDTH, self.bottomFrame.size.height));
	
	// draw
	CGContextStrokePath(context);

	// restore status
	CGContextRestoreGState(context);
}

@end
