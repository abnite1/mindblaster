//
//  GameScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "asteroidClass.h"

@interface GameScreenController : UIViewController 
{
	

	IBOutlet UIImageView *ship;
	
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
	
	IBOutlet UIImageView *bullet0;
	IBOutlet UIImageView *bullet1;
	IBOutlet UIImageView *bullet2;
	IBOutlet UIImageView *bullet3;
	IBOutlet UIImageView *bullet4;
	IBOutlet UIImageView *bullet5;
	NSMutableArray *bullets;

	CGPoint bulletPos[6];
	double shipDirectionX;
	double shipDirectionY;

	IBOutlet UILabel *question; 
	IBOutlet UILabel *solution0;
	IBOutlet UILabel *solution1;
	IBOutlet UILabel *solution2;
	IBOutlet UILabel *solution3;
	IBOutlet UILabel *solution4;
	IBOutlet UILabel *solution5;
	IBOutlet NSMutableArray *solutions;
	
	asteroidClass asteroidDetails[10];
	asteroidClass *asteroidDetailsTemp;
	
	IBOutlet UILabel *scoreLabel;
	int score;
	int bulletsFired;
}

//@property (nonatomic,retain) IBOutlet NSMutableArray *asteroidDetails2;

@property (nonatomic,retain) IBOutlet UIImageView *ship;

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

@property(nonatomic,retain) IBOutlet UIImageView *bullet0;
@property(nonatomic,retain) IBOutlet UIImageView *bullet1;
@property(nonatomic,retain) IBOutlet UIImageView *bullet2;
@property(nonatomic,retain) IBOutlet UIImageView *bullet3;
@property(nonatomic,retain) IBOutlet UIImageView *bullet4;
@property(nonatomic,retain) IBOutlet UIImageView *bullet5;
@property(nonatomic,retain) IBOutlet NSMutableArray *bullets;

@property(nonatomic,retain) IBOutlet UILabel *question;
@property(nonatomic,retain) IBOutlet UILabel *solution0;
@property(nonatomic,retain) IBOutlet UILabel *solution1;
@property(nonatomic,retain) IBOutlet UILabel *solution2;
@property(nonatomic,retain) IBOutlet UILabel *solution3;
@property(nonatomic,retain) IBOutlet UILabel *solution4;
@property(nonatomic,retain) IBOutlet UILabel *solution5;
@property(nonatomic,retain) IBOutlet NSMutableArray *solutions;

@property(nonatomic,retain) IBOutlet UILabel *scoreLabel;

-(IBAction) NextScreen;
- (IBAction) HelpScreen;
-(IBAction) FireButton;

@end
