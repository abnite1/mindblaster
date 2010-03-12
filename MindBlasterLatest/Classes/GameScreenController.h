//
//  GameScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "Asteroid.h"
#import "Questions.h"
#import "Ship.h"
#import "GameOverScreenController.h"
#import "HelpScreenController.h"
#import "MindBlasterAppDelegate.h"

@interface GameScreenController : UIViewController 
{
	IBOutlet Ball *background;
	IBOutlet UIButton *profilePic;
	IBOutlet UILabel *difficultyLabel;
	Ship *ship;
	IBOutlet UIImageView *shipIcon;
	NSMutableArray *asteroids;
	//IBOutlet UIImageView *ship;
	
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
	
	NSMutableArray *asteroidIcons;
	
	
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

	Question *question;
	
	IBOutlet UILabel *questionLabel; 
	
	IBOutlet UILabel *solutionLabel0;
	IBOutlet UILabel *solutionLabel1;
	IBOutlet UILabel *solutionLabel2;
	IBOutlet UILabel *solutionLabel3;
	IBOutlet UILabel *solutionLabel4;
	IBOutlet UILabel *solutionLabel5;
	

	NSMutableArray *solutionLabels;
	
	
	IBOutlet UILabel *scoreLabel;
	int score;
	int bulletsFired;
}
@property (nonatomic,retain) IBOutlet Ball *background;
@property (nonatomic, retain) IBOutlet UIButton *profilePic;
//@property (nonatomic,retain) IBOutlet NSMutableArray *asteroidDetails2;

@property (nonatomic,retain) IBOutlet UIImageView *shipIcon;
@property (nonatomic,retain) Ship *ship;
@property (nonatomic,retain) Question *question;
@property (nonatomic,retain) IBOutlet UILabel *difficultyLabel;


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

//@property(nonatomic,retain) NSMutableArray *asteroidIcons;
 

@property(nonatomic,retain) IBOutlet UIImageView *rotationBall;

@property(nonatomic,retain) IBOutlet UIImageView *bullet0;
@property(nonatomic,retain) IBOutlet UIImageView *bullet1;
@property(nonatomic,retain) IBOutlet UIImageView *bullet2;
@property(nonatomic,retain) IBOutlet UIImageView *bullet3;
@property(nonatomic,retain) IBOutlet UIImageView *bullet4;
@property(nonatomic,retain) IBOutlet UIImageView *bullet5;

//@property(nonatomic,retain) NSMutableArray *bullets;

@property(nonatomic,retain) IBOutlet UILabel *questionLabel;

@property(nonatomic,retain) IBOutlet UILabel *solutionLabel0;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel1;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel2;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel3;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel4;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel5;

//@property(nonatomic,retain) NSMutableArray	*solutionLabels;

@property(nonatomic,retain) IBOutlet UILabel *scoreLabel;

-(IBAction) setQuestion;
-(IBAction) NextScreen;
-(IBAction) HelpScreen;
-(IBAction) FireButton;
-(void) hitCorrectAsteroid:(int)index;
-(void) hitWrongAsteroid:(int)index;
-(void) hitBlankAsteroid:(int)index;
-(IBAction) setDifficultyLabel;
-(void) setAnswer;
-(void) initializeBulletPosition;
-(void) animateBackground;
-(void) loseScenario;
-(void) winScenario;
-(void) checkScore;
@end
