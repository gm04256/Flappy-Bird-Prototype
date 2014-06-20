//
//  BGMView.m
//  Flappy Bird Prototype
//
//  Created by 馬 岩 on 14-6-20.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMView.h"

#import "BGMObstacle.h"

#import "BGMConstants.h"

@implementation BGMView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initialize
{
	// adjust layout
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	[self setFrame:screenBounds];
	
	// initialize time
	self.lastUpdateDate = [NSDate date];
	
	// reset camera
	self.cameraX = 0;
	
	// initialize bird
	self.bird = [[BGMBird alloc]initWithSpeedX:100 speedY:0 positionX:100 positionY:self.center.y];
	
	// initialize obstacles
	self.obstacles = [NSMutableArray arrayWithCapacity:50];
	
	for (int i = 0; i < 50; i++)
	{
		self.obstacles[i] = [[BGMObstacle alloc]initWithPositionX:(self.frame.size.width + (OBSTACLE_WIDTH + OBSTACLE_SPACING) * i) screenHeight:self.frame.size.height];
	}
	
	self.currentCheckPostIndex = 0;
	
	// check the result of initialization
//	NSLog(@"Bird: %@", NSStringFromCGRect(self.bird.frame));
//	for (BGMObstacle* obstacle in self.obstacles)
//	{
//		NSLog(@"obstacles: %@\n%@", NSStringFromCGRect(obstacle.topFrame), NSStringFromCGRect(obstacle.bottomFrame));
//	}
	
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    // Drawing code
	
	// draw bird
	[self.bird drawBirdInContext:context cameraX:self.cameraX];
	// draw obstacles
	for (BGMObstacle* obstacle in self.obstacles)
	{
		[obstacle drawObstacleInContext:context cameraX:self.cameraX];
	}
}


#pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	self.bird.acceleration = TOUCHED_ACCELERATION;
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(resumeAcceleration) userInfo:nil repeats:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

#pragma mark - Game Timer

- (void)startTimer
{
	if ([self.gameTimer isValid])
	{
		[self stopTimer];
	}
	
	self.lastUpdateDate = [NSDate date];
	self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.017 target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
	[self.gameTimer invalidate];
	self.gameTimer = nil;
}

- (void)timerSchedule
{
	// before update
	NSDate* now = [NSDate date];
	NSTimeInterval interval = [now timeIntervalSinceDate:self.lastUpdateDate];
	
	// move camera
	self.cameraX += self.bird.speedX * interval;
	
	// update position of bird
	float newSpeedY = self.bird.speedY + interval * self.bird.acceleration;
	if (newSpeedY < BIRD_MAX_SPEED)
	{
		newSpeedY = BIRD_MAX_SPEED;
	}
	self.bird.frame = CGRectMake(self.bird.frame.origin.x + self.bird.speedX * interval,
								 self.bird.frame.origin.y + self.bird.speedY * interval + (interval * interval * self.bird.acceleration) / 2,
								BIRD_WIDTH,
								BIRD_HEIGHT);
	self.bird.speedY = newSpeedY;
	
	// update obstacles
	
	// refresh display
	[self setNeedsDisplay];
	
	// after update
	self.lastUpdateDate = now;
	
	// check whether bird crashes to the post
	BGMObstacle* currentObstacle = self.obstacles[self.currentCheckPostIndex];
	if(self.bird.frame.origin.x >= currentObstacle.topFrame.origin.x + OBSTACLE_WIDTH)
	{
		self.currentCheckPostIndex++;
		if (self.currentCheckPostIndex >= [self.obstacles count]) {
			self.currentCheckPostIndex = [self.obstacles count] - 1;
		}
		currentObstacle = self.obstacles[self.currentCheckPostIndex];
	}
	
	BOOL result = CGRectIntersectsRect(self.bird.frame, currentObstacle.topFrame);
	if(!result)
	{
		result = CGRectIntersectsRect(self.bird.frame, currentObstacle.bottomFrame);
	}
	if (result)
	{
		[self.gameTimer invalidate];
		self.gameTimer = nil;
		[self initialize];
	}
}

- (void)resumeAcceleration
{
	self.bird.acceleration = GRAVITY_ACCELERATION;
}

@end
