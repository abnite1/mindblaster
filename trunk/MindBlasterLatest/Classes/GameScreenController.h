//
//  GameScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Modified by yaniv haramati on 12/03/10, restructuring the code to encapsulate the asteroid and questions into their own classes.
//  Note: 
//  fire() should move to the Ship class. Bullet should become its own class and take care of all the bullet stuff.
//  We need to find a way to create UIIViewImages from the code without relying on interfacebuilder, this will clean up this class immensely.
//  onTimer is still a mess. needs to be cleaned up.
//  Lots of outlets as properties that don't need to be properties. 
//  Only define properties for what needs to be accessed from outside the class.
// 
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundAnimation.h"
#import "Asteroid.h"
#import "Bullet.h"
#import "Question.h"
#import "Ship.h"
#import "GameOverScreenController.h"
#import "HelpScreenController.h"
#import "MindBlasterAppDelegate.h"
#import "Sound.h"


// this preprocessor directive value is used to set whether unit tests will be executed or not 
#define UNIT_TESTS_EXECUTED  FALSE


// constants
static const float ICON_ROTATION_COEFFICIENT = 0.07;
static const int ASTEROID_SPEED_FACTOR = 1;
static const int INCORRECT_ANSWER_PROXIMITY = 10;
static const int ENABLE_BONUS_SPEED_GAME = 0;

@interface GameScreenController : UIViewController 
{
	int asteroidSpeedCounter;
	//int bonusSpeedGameEnable;
	// background space animation
	IBOutlet BackgroundAnimation *background;
	IBOutlet UIButton *profilePic;
	IBOutlet UILabel *difficultyLabel;
	Ship *ship;
	IBOutlet UIImageView *shipIcon;
	
	float iconRotationAngle;
	
	BOOL gamePaused;
	
	// this holds an array of asteroids
	NSMutableArray *asteroids;
	
	//timer variables
	NSTimer *gamePlayTimer;
	double gamePlayTimerInterval;
	//NSNumber *topicTimeCount;
	double topicTimeCount;
	IBOutlet UILabel *topicTimeDisplay;
	
	//IBOutlet UIImageView *ship;
	
	// the initial image outlets, because we don't yet know how to create images without connecting
	// them through interface builder
	
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
	
	// and one array to rule them all and in the darkness bind them
	NSMutableArray *asteroidIcons;
	
	
	IBOutlet UIImageView *rotationBall;
	IBOutlet UIImageView *rotationController;
	IBOutlet UIImageView *shipShield;
	float shieldBarMultiplier;
	CGAffineTransform originalShieldBounds;
	
	// initial bullet outlets
	IBOutlet UIImageView *bullet0;
	IBOutlet UIImageView *bullet1;
	IBOutlet UIImageView *bullet2;
	IBOutlet UIImageView *bullet3;
	IBOutlet UIImageView *bullet4;
	IBOutlet UIImageView *bullet5;
	
	// one array to bind the bullet icons
	NSMutableArray *bulletIcons;
	NSMutableArray *bullets;

	CGPoint bulletPos[6];
	
	// this should go in teh Ship class
	double shipDirectionX;
	double shipDirectionY;

	Question *question;
	
	IBOutlet UILabel *questionLabel; 
	IBOutlet UILabel *livesLabel;
	IBOutlet UILabel *feedbackLabel;
	
	// the outlets for the 5 labels
	IBOutlet UILabel *solutionLabel0;
	IBOutlet UILabel *solutionLabel1;
	IBOutlet UILabel *solutionLabel2;
	IBOutlet UILabel *solutionLabel3;
	IBOutlet UILabel *solutionLabel4;
	IBOutlet UILabel *solutionLabel5;
	
	IBOutlet UIImageView *animatedExplosion;
	
	// and one array to bind them
	NSMutableArray *solutionLabels;
	
	// the scoreboard
	IBOutlet UILabel *scoreLabel;
	
	//int score;
	int lives;
	int shield;
	float shieldPower;
	
	// number of asteroids
	int maxAsteroids;
	
	// progress bar
	UIProgressView *shieldBar;
	
	Sound *sound;
	
	int bulletsFired;
	BOOL gameStarted;
}
@property (nonatomic) double topicTimeCount;
@property (nonatomic, retain) IBOutlet UILabel *topicTimeDisplay;

@property (nonatomic, retain) IBOutlet UIImageView *animatedExplosion;

@property (nonatomic,retain) IBOutlet BackgroundAnimation *background;
@property (nonatomic, retain) Sound *sound;
@property (nonatomic, retain) IBOutlet UIButton *profilePic;
@property (nonatomic,retain) IBOutlet UIProgressView *shieldBar;

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

@property(nonatomic,retain) IBOutlet UIImageView *rotationBall;
@property(nonatomic,retain) IBOutlet UIImageView *rotationController;
@property(nonatomic,retain) IBOutlet UIImageView *shipShield;

@property(nonatomic,retain) IBOutlet UIImageView *bullet0;
@property(nonatomic,retain) IBOutlet UIImageView *bullet1;
@property(nonatomic,retain) IBOutlet UIImageView *bullet2;
@property(nonatomic,retain) IBOutlet UIImageView *bullet3;
@property(nonatomic,retain) IBOutlet UIImageView *bullet4;
@property(nonatomic,retain) IBOutlet UIImageView *bullet5;


@property(nonatomic,retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UILabel *feedbackLabel;

@property(nonatomic,retain) IBOutlet UILabel *solutionLabel0;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel1;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel2;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel3;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel4;
@property(nonatomic,retain) IBOutlet UILabel *solutionLabel5;

@property(nonatomic,retain) IBOutlet UILabel *scoreLabel;

-(IBAction) setQuestion;
-(IBAction) nextScreen;
-(IBAction) helpScreen;
-(IBAction) fireButton;
-(IBAction) pauseButton;
-(void) hitCorrectAsteroid:(int)index;
-(void) hitWrongAsteroid:(int)index;
-(void) hitBlankAsteroid:(int)index;
-(IBAction) setDifficultyLabel;
-(void) setAnswer;
//-(void) initializeBulletPosition;
-(void) animateBackground;
-(void) loseScenario;
-(void) winScenario;
-(void) checkScore;
-(void) asteroidCollision: (int) asteroidIndex;
-(void) handle2AsteroidsColliding: (Asteroid*)as1 with:(Asteroid*)as2;
-(BOOL) checkCollisionOf:(Asteroid*)as1 with:(Asteroid*)as1;
-(BOOL) checkCollisionOf:(Asteroid*)as withShip:(Ship*)aShip;
-(void) updateScoreLabel;
-(void) decreaseShield;
-(void) decreaseLives;
-(void) touchesUpdate:(NSSet*)touches :(UIEvent*)event;
-(void) updateLivesTo:(int)newVal;
-(void) updateShieldTo:(int)newVal;
-(void) updateScoreTo:(int)newScore;
-(void) resetValues;
-(void) initSound;
-(void) beginFeedbackAnimation;
-(void) beginShieldAnimation;
-(void) asteroidExplosionAnimation:(CGPoint)location;
-(void) increaseShield;
-(void) increaseLives;
-(void) updateFeedbackLabelTo:(NSString*)newText;

//unit tests
-(void)gamePausedUnitTest;
-(void) setQuestionUnitTest;
-(void) updateLivesToUnitTest;
-(void) decreaseLivesUnitTest; 
-(void) checkCollisionOfUnitTest;

@end
