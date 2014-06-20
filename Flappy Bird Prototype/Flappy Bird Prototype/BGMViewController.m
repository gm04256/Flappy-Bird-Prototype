//
//  BGMViewController.m
//  Flappy Bird Prototype
//
//  Created by 馬 岩 on 14-6-20.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMViewController.h"

#import "BGMView.h"

@interface BGMViewController ()

@property (weak, nonatomic) IBOutlet BGMView *gameView;

@end

@implementation BGMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self.gameView initialize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonClicked:(id)sender
{
	[self.gameView startTimer];
}

- (IBAction)stopButtonClicked:(id)sender
{
	[self.gameView stopTimer];
	
}

- (IBAction)restartButtonClicked:(id)sender
{
	[self.gameView initialize];
	[self.gameView startTimer];
}
@end
