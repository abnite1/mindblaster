//
//  GameScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"

@interface GameScreenController : UIViewController 
{
	IBOutlet UIImageView *asteroid0;
	IBOutlet UIImageView *asteroid1;
	IBOutlet UIImageView *asteroid2;
	IBOutlet UIImageView *asteroid3;
	IBOutlet UIImageView *asteroid4;
	IBOutlet UIImageView *asteroid5;
	IBOutlet UIImageView *asteroid6;
	IBOutlet UIImageView *asteroid7;
	IBOutlet UIImageView *asteroid8;
	IBOutlet UIImageView *asteroid9;
	
	NSMutableArray *asteroids;
	
	IBOutlet UIImageView *rotationBall;

	CGPoint asteroidPos[10];
}

@property(nonatomic,retain) IBOutlet UIImageView *asteroid0;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid1;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid2;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid3;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid4;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid5;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid6;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid7;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid8;
@property(nonatomic,retain) IBOutlet UIImageView *asteroid9;

@property(nonatomic,retain) IBOutlet NSMutableArray *asteroids;

@property(nonatomic,retain) IBOutlet UIImageView *rotationBall;

-(IBAction) NextScreen;
- (IBAction) HelpScreen;


@end
