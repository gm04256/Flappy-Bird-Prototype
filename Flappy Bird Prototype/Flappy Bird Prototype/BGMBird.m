//
//  BGMBird.m
//  Flappy Bird Prototype
//
//  Created by 馬 岩 on 14-6-20.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMBird.h"

#import "BGMConstants.h"

@implementation BGMBird

- (instancetype)initWithSpeedX:(float)speedX speedY:(float)speedY positionX:(float)x positionY:(float)y
{
	if(self = [super init])
	{
		// initialize the bird
		self.speedX = speedX;
		self.speedY = speedY;
		self.frame = CGRectMake(x, y, BIRD_WIDTH, BIRD_HEIGHT);
		self.acceleration = GRAVITY_ACCELERATION;
	}
	
	return self;
}

- (void)drawBirdInContext:(CGContextRef)context cameraX:(float)cameraX
{
	// save status
	CGContextSaveGState(context);
	
	// set pen
	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetLineWidth(context, 2);
	
	// calculate angle
	float currentAngle = atan2f(self.speedY, self.speedX);
	
	CGContextTranslateCTM(context, self.frame.origin.x - cameraX + self.frame.size.width / 2, self.frame.origin.y + self.frame.size.height / 2);
	CGContextRotateCTM(context, currentAngle);
	
	// add bird
	CGContextAddRect(context, CGRectMake(-BIRD_WIDTH / 2, -BIRD_HEIGHT / 2, BIRD_WIDTH, BIRD_HEIGHT));
	
	// draw
	CGContextStrokePath(context);
	
	// restore status
	CGContextRestoreGState(context);
}

@end
