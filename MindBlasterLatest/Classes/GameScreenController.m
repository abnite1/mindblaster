//
//  GameScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//test comment

#import "GameScreenController.h"



@implementation GameScreenController

@synthesize background, profilePic, difficultyLabel, feedbackLabel;
@synthesize sound;
@synthesize topicTimeCount, topicTimeDisplay;
@synthesize animatedExplosion;

@synthesize explosion;
@synthesize shipIcon, ship, shieldBar;
@synthesize asteroid0, asteroid1, asteroid2, asteroid3, asteroid4, asteroid5, asteroid6, asteroid7, asteroid8, asteroid9;
//@synthesize asteroidIcons;  //this is the vector which will hold all of the above asteroid objects

@synthesize rotationBall, rotationController, shipShield;

@synthesize bullet0, bullet1, bullet2, bullet3, bullet4, bullet5;
//@synthesize bullets; //this is the vector which will hold all of the above bullet objects

@synthesize question, questionLabel, scoreLabel;
@synthesize solutionLabel0,solutionLabel1,solutionLabel2,solutionLabel3,solutionLabel4,solutionLabel5;
//@synthesize solutionLabels; //this is the vector which will hold all of the above solution objects


// animate the space background
// and rotate shield and controller icons
-(void)animateBackground {
	
	// move animation
	[background move];
	
	// rotate the ship shield icon and direction controller
	rotationController.transform=CGAffineTransformMakeRotation ([ship direction]);
	
	
	// rotates the shield
	shipShield.transform = CGAffineTransformRotate(shipShield.transform, iconRotationAngle);
	
	
	// increment angle
	iconRotationAngle += ICON_ROTATION_COEFFICIENT;
	
}
/*
// starts fadein/fadeout animation for feedback label
-(void) beginFeedbackAnimation {
	
	feedbackLabel.hidden = NO;
	feedbackLabel.alpha = 0;
	feedbackLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
	
	// start animation seq.
	[UIView beginAnimations: nil context: NULL];
	
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDuration: 1];
	[UIView setAnimationRepeatCount: 1];
	
	feedbackLabel.alpha = 1;
	feedbackLabel.transform = CGAffineTransformIdentity;
	
	// end animation
	[UIView commitAnimations];
}
*/

//animnates warnings such as Correct and Incorrect from the onTimer function
-(void) animateWarning{
	if(warningAnimationCounter == -1)
		return;
	else if(warningAnimationCounter  == WARNING_ANIMATION_DURATION)
	{
		feedbackLabel.hidden = NO;
		feedbackLabel.alpha = 0.5;
		feedbackLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
		warningAnimationCounter--;
	}
	else if(warningAnimationCounter >0)
	{
		feedbackLabel.alpha = 1-warningAnimationCounter/WARNING_ANIMATION_DURATION/2;
		//gradually increases warning's alpha (opacity) as the animation progresses
		feedbackLabel.transform = CGAffineTransformMakeScale(1-warningAnimationCounter/WARNING_ANIMATION_DURATION/2, 
															 1- warningAnimationCounter/WARNING_ANIMATION_DURATION/2);
		//gradually increases warning's size as the animation progresses
		warningAnimationCounter--;
	}
	else
	{
		warningAnimationCounter = -1;
		feedbackLabel.hidden = YES;
	}
}
/*
// starts the decreased shield animation sequence
-(void) beginShieldAnimation {
	
	shipShield.alpha = 0.0;
	
	// start of animation seq.
	[UIView beginAnimations: nil context: NULL];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDuration: 0.7];
	[UIView setAnimationRepeatCount: 1];
	
	shipShield.alpha = shieldPower;
	
	// end animation
	[UIView commitAnimations];
	
}
*/

//animates the shield when the shield is hit by an asteroid
-(void) animateShield 
{

	if(shieldAnimationCounter == -1)
		return;
	else if(shieldAnimationCounter  ==SHIELD_ANIMATION_DURATION)
	{
		shipShield.alpha = 0.0;
		shieldAnimationCounter--;
	}
	else if(shieldAnimationCounter >0)
	{
		shipShield.alpha = shieldPower*(1-warningAnimationCounter/WARNING_ANIMATION_DURATION);  
		//gradually increases shields alpha (opacity) as the animation progresses
		shieldAnimationCounter--;
	}
	else
	{
		shieldAnimationCounter = -1;
		shipShield.alpha =shieldPower;
	}

}

-(void) animateExplosion: (BOOL)shipExploding{
	
	float numberOfGameTicksPerImage = EXPLOSION_ANIMATION_DURATION/11.0 ;
	if(shipExploding == TRUE)
		explosion.transform = CGAffineTransformMakeScale(5, 5);
	else
		explosion.transform = CGAffineTransformMakeScale(2, 2);
	if(explosionAnimationCounter == -1)
		return;
	else if(explosionAnimationCounter  ==EXPLOSION_ANIMATION_DURATION)
	{
		
		explosionImageCounter = 0;
		explosion.image = [explosions objectAtIndex:explosionImageCounter];
		explosion.hidden = NO;
		gameTicksLeftForExplosionImage = numberOfGameTicksPerImage;
		explosionAnimationCounter--;

	}
	else if( explosionAnimationCounter > 0.0 && gameTicksLeftForExplosionImage <=0.0 )
	{
		explosionImageCounter++;
		explosion.image = [explosions objectAtIndex:explosionImageCounter];
		gameTicksLeftForExplosionImage = numberOfGameTicksPerImage;
		explosionAnimationCounter--;
	}
	else if( explosionAnimationCounter > 0.0 )
	{
		gameTicksLeftForExplosionImage = gameTicksLeftForExplosionImage - 1.0;
	}
	else
	{
		shipDestroyed = FALSE;
		explosionAnimationCounter = -1;
		explosion.hidden = YES;
	}
}
// delegate function to take effect at the end of animation
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
	
	// if animation got cut off, redo.
	if (![finished intValue]) {
		
		NSLog(@"animation interrupted.");
		[UIView setAnimationDelegate: nil];
		
	}
	else {
		feedbackLabel.hidden = YES;
	}
}


// switches between play mode and pause
-(void)pauseGame {
	
	if(gamePaused) {
		
		gamePlayTimer = [NSTimer scheduledTimerWithTimeInterval: gamePlayTimerInterval 
														 target: self selector:@selector(onTimer) 
													   userInfo: nil repeats:YES];
		gamePaused = NO;
		NSLog(@"game unpaused");
	}
	else {
		
		[gamePlayTimer invalidate];
		gamePaused = YES;
		NSLog(@"game paused");
	}
}

-(void)gamePausedUnitTest{
	BOOL unitTestPassed = TRUE;
	if(gamePaused == FALSE) {
		[self pauseGame];
		if(gamePaused == FALSE)
		{
			NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: gamePausedUnitTest; gamePaused variable not set");
			unitTestPassed = FALSE;
		}
		if(gamePlayTimer == nil)
		{
			NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: gamePausedUnitTest; gamePlayTimer timer not set");
			unitTestPassed = FALSE;
		}
		
	}
	else {
		[self pauseGame];
		if(gamePaused == TRUE)
		{
			NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: gamePausedUnitTest; gamePaused variable not set");
			unitTestPassed = FALSE;
		}
		if(gamePlayTimer != nil)
		{
			NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: gamePausedUnitTest; gamePlayTimer timer failed to invalidate ");
			unitTestPassed = FALSE;
		}
	}
	[self pauseGame];
	
	if(unitTestPassed == TRUE)
		NSLog(@"UNIT TEST PASSED; class: GameScreenController; function: gamePausedUnitTest");
}

// delegate function that runs every time the view returns from "back" of another screen
- (void)viewWillAppear:(BOOL)animated {
	
}

// delegate function that runs every time the view returns from "back" of another screen
- (void)viewDidAppear:(BOOL)animated {
    
	[super viewDidAppear:animated];
	
	[[UIApplication sharedApplication] setStatusBarHidden: YES animated: NO];
	
	iconRotationAngle = 0.0f;
	asteroidSpeedCounter = 0;//jkehler
	
//	NSLog(@"gamescreen view did appear.");
	
	// set the screen title
	[self.navigationController setTitle: @"gameScreenView"];
	
	// if the game is paused when returning to view, unpause.
	if (gamePaused) {
		
		//NSLog(@"unpausing game in viewdidappear");
		[self pauseGame];
	}
	
	// stop the background sound if it's playing
	// then restart it
	if (sound == nil || ![sound bgIsPlaying]) {
		
		[self initSound];
		[sound playBG];
		[sound setBgIsPlaying: YES];
	}

}

// delegate for what to do before leaving screen
-(void) viewWillDisappear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	NSLog(@"inside viewWillDisappear");
	
	// if the game isn't paused, pause it.
	if (!gamePaused) {
		
		[self pauseGame];
	}
	
	// stop background sound if it is playing
	//NSLog(@"about to check if sound is playing");
	if (sound != nil && [sound.bgPlayer isPlaying]) {
		
		[sound.bgPlayer stop];
	}
	
	[sound release];
	
	//NSLog(@"after sound release in view will disappear");
	sound = nil;
	
	// compare score and save to profile if necessary
	if ([UIAppDelegate.currentUser.score score] > [UIAppDelegate.currentUser.highestScore score]) {
		//NSLog(@"comparing scores");
		[UIAppDelegate.currentUser setHighestScore: [UIAppDelegate.currentUser score]];
	}
	
	// save profile to plist before leaving gamescreen
	[GlobalAdmin saveSettings];
}

// another delegate for view lifespan
-(void) viewDidDisappear:(BOOL)animated {
	
	//NSLog(@"inside view did disappear");
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	
	//initialize timecount to 0  //jkehler
	topicTimeCount = 0;
	UIAppDelegate.bonusSpeedGameEnable=0;
	
	//NSLog(@"started viewDidLoad");
	
	//shieldPower initialized at 1 or full power
	shieldPower = 1;
	
	// initialize feedbackLabel
	[feedbackLabel setText: @""];
	
	
#if (UNIT_TESTS_EXECUTED == 1)
	[self gamePausedUnitTest];
	[self setQuestionUnitTest];
	[self updateLivesToUnitTest];
	[self decreaseLivesUnitTest];
	[self checkCollisionOfUnitTest];
#endif
	
	//gamePausedUnitTest();
	
	// the initial setting actually starts the timer
	gamePaused = FALSE;
	[self pauseGame];
	
	gamePlayTimerInterval = 0.06; //sverner     //0.03;//jkehler
	
	shipDestroyed = FALSE;  //initialize the shipDestroyed variable used by the animateExplosion Funtion
	
	gameOverCounter = -1;  //initialize the gameOverCounter variable used to animate the game over warning and explosoin
	
	asteroidIcons = [[NSMutableArray alloc] initWithObjects: asteroid0, asteroid1, asteroid2, asteroid3,
					 asteroid4,/* asteroid5, asteroid6, asteroid7, asteroid8, asteroid9,*/nil];//jkehler
	[asteroidIcons retain];
	
	solutionLabels  = [[NSMutableArray alloc] initWithObjects: solutionLabel0, solutionLabel1, solutionLabel2, 
					   solutionLabel3/*, solutionLabel4, solutionLabel5*/, nil];//jkehler
	[solutionLabels retain];
	
	asteroids = [[NSMutableArray alloc] init];
	[asteroids retain];
	bullets = [[NSMutableArray alloc] init];
	[bullets retain];
	explosions = [[NSMutableArray alloc] init];
	[explosions retain];
	

	//declare the explosion images and save them in the explosions array for use in the explosion animation
	NSString *explosionName ;
	for(int i = 1; i<= 11; i++)
	{  
		explosionName = [[NSString alloc] initWithFormat:@"expl%d", i];
		[explosions addObject: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:  explosionName ofType:@"png"] ]];
	}
	
	//[explosions addObject: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:  explosionName ofType:@"png"] ]];
	
	NSLog(@"allocated solutionLabels");
	// set the gamescreen label for the selected difficulty
	[self setDifficultyLabel];
	
	// create a temp object for the initialization
	Asteroid *asteroid;
	
	// initialize shield
	[self updateShieldTo: 3];
	
	// initialize size of shield frame to 1.3 of its original size
	// because we want the shield to lose .1 of its size on each hit and multiplication is safer than division.
	// so we start at 1.3 and go down to the original size (that being * 1.0).
	shieldBarMultiplier = 1.3;

	
	// initialize lives
	[self updateLivesTo: 3];
	
	NSLog(@"allocated asteroids");
	
	// for all 6 correct/incorrect solution asteroids in the array, attach an image and a label
	
	for (int i = 0; i < 5; i++) {
		
		if (i < 4) {
			
			// for the first 3 asteroids attach an image and a label
			asteroid = [[Asteroid alloc] initWithElements: [asteroidIcons objectAtIndex: i]: 
						[solutionLabels objectAtIndex: i]];
			[asteroids addObject: asteroid];
			[asteroid release];
		}
		
		// for all remaining 4 blank asteroids in the array, attach an image but no label
		else {
			NSLog(@"allocating non labled asteroids");
			asteroid = [[Asteroid alloc] init];
			[asteroid setAsteroidIcon: [asteroidIcons objectAtIndex: i]];
			[asteroid setAsteroidSize: CGPointMake([[asteroidIcons objectAtIndex: i] bounds].size.width,
												   [[asteroidIcons objectAtIndex: i] bounds].size.height)];
			[asteroids addObject: asteroid];
			[asteroid release];
		}
	}
	
	// check their position (debug)
	/*
	 for (int i = 0; i < 10; i++) {
	 int x = [[asteroids objectAtIndex: i] asteroidPosition].x;
	 NSLog(@"class at index %d : %f", i, x);
	 }
	 */
	
	// allocate bullet icons to each bullet object
	bulletIcons = [[NSMutableArray alloc] initWithObjects: bullet0,bullet1,bullet2,bullet3,bullet4,bullet5,nil];
	for (int i = 0; i < 6; i++) {
		
		Bullet *bullet = [[Bullet alloc] init];
		[bullet setBulletIcon: [bulletIcons objectAtIndex: i]];
		[bullet setBulletPosition: 0 :500];	// set initial position offscreen so they won't hit asteroids.
		[bullets addObject: bullet];
		[bullet release];
		
	}
	
	
	//set the profile pic!
	int picIndex = [UIAppDelegate.currentUser profilePic];
	[profilePic setImage: [GlobalAdmin getPic: picIndex] forState:0];

	
	[NSTimer scheduledTimerWithTimeInterval: 0.01 target: self//changed 0.01 from 0.08
								   selector:@selector(animateBackground) userInfo: nil repeats: YES];
	[background setSpeedX: 0.2 Y: 0.2];
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem
	//[background move];
	
	// create game objects
	ship = [[Ship alloc] init];				// create the ship object
	[ship retain];
	[ship setIcon: shipIcon];				// connect the ship icon to the Ship object so it can be rotated
	[ship setPos: CGPointMake(shipIcon.center.x , shipIcon.center.y)];
	
	
	// initialize original shield bounds
	originalShieldBounds = shipShield.transform;
	
	// set the initial question
	[self setQuestion];						
	
	
	// set the score initially to 0
	[UIAppDelegate.currentUser.score setScore: 0];
	
	//values used to describe the direction the ship is facing, derived from the rotation wheel
	shipDirectionX = 0;  
	shipDirectionY = -15;
	//NSLog(@"Post load:   shipX = %f,   shipY = %f", shipDirectionX, shipDirectionY);
	
	//incrementor which denotes the next bullet to be fired, the 0th bullet is fired first
	bulletsFired = 0;
	
	if(gameStarted != TRUE)
		gameStarted = FALSE;
	
	//automated unit testing
#if (UNIT_TESTS_EXECUTED ==1)
	
	[self setQuestionUnitTest];
	[self updateLivesToUnitTest];
	[self decreaseLivesUnitTest];
	[self checkCollisionOfUnitTest];
	[question setQuestionUnitTest];
	[ship setIconUnitTest:shipIcon];
	[ [Asteroid alloc] initWithElementsUnitTest:  [asteroidIcons objectAtIndex: 1]:   [solutionLabels objectAtIndex: 1]];
	[ [Asteroid alloc] setAsteroidDirectionUnitTest];
	[ [Asteroid alloc] moveUnitTest];
	[ [Bullet alloc] moveUnitTest];
#endif
    
}

// pause the game
-(IBAction) pauseButton
{
	[self pauseGame];
}

// sets the initial location of bullets on screen
/*
 -(void)initializeBulletPosition {
 
 //NSLog(@"starting initializeBulletPosition");
 UIImageView *tempBullet;  //temperary UIImageView allows manipulation of the elements of the bullets array
 for(int i = 0; i < 6;  i++)
 {
 tempBullet = [bulletIcons objectAtIndex:i];
 tempBullet.center = CGPointMake(0,500); //set all bullets starting location as off-screen so they don't destroy any asteroids yet
 }
 
 //NSLog(@"finished initializeBulletPosition");
 }
 */


// handle bullet animation and interaction with asteroids
-(IBAction) fireButton{
	//update stats with #bullets fired
	[[UIAppDelegate.currentUser stats] setShotsFired: [[UIAppDelegate.currentUser stats] shotsFired] + 1]; //jkehler
	
	
	// begin laser sound
	[sound playLaser];
	
	//assigns element of bullets array to tempBullet to allow manipulation of that element
	Bullet *tempBullet  = [bullets objectAtIndex: bulletsFired];
	
	//sets the bullet being fired's movement vector to the vector defined by the direction in which the ship is pointing
	bulletPos[bulletsFired] = CGPointMake(shipDirectionX,shipDirectionY); 
	
	// set it to the location of the ship icon
	[tempBullet setBulletPosition: ship.pos.x : ship.pos.y];
	//[tempBullet setBulletDirection: shipDirectionX :shipDirectionY];
	
	tempBullet.bulletIcon.hidden = NO;
	[tempBullet rotate: [ship direction]];
	//NSLog(@"angle: %f", [ship direction]);
	
	
	
	if(bulletsFired == 5)   //there are only six bullets so once all 6 have been fired start at 0 again
		bulletsFired = 0;
	else
		bulletsFired++;
}

// sets the label for the question according to the profile settings
-(IBAction) setQuestion {
	
	//NSLog(@"starting setQuestion");
	question = [[Question alloc] init];						// create a new question object
	[question retain];
	question.questionLabelOutletPointer = questionLabel;	// connect the local outlet to the object outlet
	
	//set the question on the screen
	//NSLog(@"Calling SetQuestion for question class\n");
	[question setQuestion];
	
	// set the answers on the asteroid labels
	//NSLog(@"Calling setAnswer on self, next function\n");
	[self setAnswer];
	//[question release];
}

-(void) setQuestionUnitTest {
	[self setQuestion];
	BOOL unitTestPassed = TRUE;
	if(question == nil)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: setQuestion; question object not allocated");
		unitTestPassed = FALSE;
	}
	if(question.questionLabelOutletPointer == nil)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: setQuestion; questionLabelOutletPointer object not connected to label");
		unitTestPassed = FALSE;
	}
	if(unitTestPassed == TRUE)
		NSLog(@"UNIT TEST PASSED; class: GameScreenController; function: setQuestion");
}

// sets the answers on the asteroid labels
//jkehler edited this to simplyify 
-(void)setAnswer {
	
	// define the solution set of labels on asteroids
	//NSLog(@"starting setAnswer");	
	
	//what is this for???? //jkehler
	//temporarily records the wrong answers being printed on the incorrect solution asteroids
	//int wrongAnswers[5];
	int finalWrongAnswer;
		/*int i;
	for(i=0; i<5; i++)
		wrongAnswers[0] = [question answer];
	*/
	
	// determine the correct_answer asteroid randomly and set its value and type
	// because we have 4 labeled asteroids
	int randomCorrectAsteroid = arc4random() % 3;	 // from 0 to 3 //jkehler
	NSString *inputString = [[NSString alloc] initWithFormat:@"%d",(int)[question answer]];
	[[[asteroids objectAtIndex: randomCorrectAsteroid] asteroidLabel] setText: inputString];
	
	
	// set asteroid type
	[[asteroids objectAtIndex: randomCorrectAsteroid] setAsteroidType:CORRECT_ASTEROID];
	[inputString release];
	
	//NSLog(@"inside setAnswer and random correct asteroid index is : %d", randomCorrectAsteroid);
	
	// sort through the incorrect_answer asteroids and set their value and type and direction
	for(int asteroidIndex = 0; asteroidIndex < 4; asteroidIndex++)//jkehler
	{
		if (asteroidIndex != randomCorrectAsteroid) {
			
			// set wrong answer equal to some random value of +- [1-7] from the correct answer
			//and keep setting the wrong answer until it is different from the correct answer
			//and from the other wrong answers
			/*do {
				finalWrongAnswer = [question answer] + (arc4random() % 8 * pow(-1, (int)(arc4random() % 8)));
			} while (finalWrongAnswer == [question answer]  || finalWrongAnswer == wrongAnswers[0]
					 || finalWrongAnswer == wrongAnswers[1] || finalWrongAnswer == wrongAnswers[2]
					 || finalWrongAnswer == wrongAnswers[3] || finalWrongAnswer == wrongAnswers[4] );
			wrongAnswers[asteroidIndex] = finalWrongAnswer;*/
			
			int offsetValue;//jkehler got rid of while loop (its not a big deal if some are repeats (not worth the checking)
			offsetValue=arc4random()%INCORRECT_ANSWER_PROXIMITY+1;//so its never zero
			if(arc4random()%3<2)
				offsetValue*=-1;
			if((finalWrongAnswer = ([question answer] + offsetValue)) < 0){ //don't want negative values
				finalWrongAnswer*=-1; //change it back.
			}
			//finalWrongAnswer = [question answer] + offsetValue;
			
			NSString *inputString = [[NSString alloc] initWithFormat:@"%d",finalWrongAnswer];
			[[[asteroids objectAtIndex: asteroidIndex] asteroidLabel] setText: inputString];
			
			// and set the incorrect type
			[[asteroids objectAtIndex: asteroidIndex] setAsteroidType:INCORRECT_ASTEROID];
			
			//jkehler removing this caused no problems, it seems it was unecessary (since move and assinging random velocities is handled elsewhere.
			// then send it on a random path
			//[[asteroids objectAtIndex: asteroidIndex] 
			 //setAsteroidDirection:((arc4random() %30 ) / 5  -3) :((arc4random() % 30) / 5 -3)];
			// setAsteroidDirection:	arc4random() % ([UIAppDelegate.currentUser.currentTopic difficulty]) : 
			// arc4random() % ([UIAppDelegate.currentUser.currentTopic difficulty])];
			[inputString release];
			
			//[[asteroids objectAtIndex: asteroidIndex] move]; 
		}
	}
	
	[[asteroids objectAtIndex: 4] setAsteroidType:BLANK_ASTEROID];
	//jkehler ALSO uncessesary
	// set the blank type on a random path
/*	for (int asteroidIndex = 4; asteroidIndex < 5; asteroidIndex++) {//jkehler
		
		[[asteroids objectAtIndex: asteroidIndex] setAsteroidType:BLANK_ASTEROID];
		[[asteroids objectAtIndex: asteroidIndex] 
		 setAsteroidDirection:	arc4random() % ([UIAppDelegate.currentUser.currentTopic difficulty]) : 
		 arc4random() % ([UIAppDelegate.currentUser.currentTopic difficulty])];
		[[asteroids objectAtIndex: asteroidIndex] move];
	}*/
	//NSLog(@"end of answer");
}

// updates the difficulty label to the current difficulty in the user profile
-(IBAction) setDifficultyLabel {
	//NSLog(@"start setDifficultyLabel");
	//what the crap does this lline below do? setitto itself????? //jkehler
	//[[UIAppDelegate.currentUser currentTopic] setDifficulty: UIAppDelegate.currentUser.currentTopic.difficulty];
	int diff = [[UIAppDelegate.currentUser currentTopic] difficulty];
	
	//int diff = [UIAppDelegate.currentUser currentDifficulty];
	
	NSString *diffMsg;
	if (diff == 1) diffMsg = @"Easiest";
	if (diff == 2) diffMsg = @"Easy";
	if (diff == 3) diffMsg = @"Hard";
	if (diff == 4) diffMsg = @"Hardest";
	
		
	if(gameStarted == TRUE)
	{
		[feedbackLabel setTextColor:[UIColor yellowColor]];
		[self updateFeedbackLabelTo: @"You passed a level!"];
		//[self beginFeedbackAnimation];
		warningAnimationCounter = WARNING_ANIMATION_DURATION;
	}
	gameStarted = 1;
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Difficulty: %@", diffMsg];
	[difficultyLabel setText:msg];
	[diffMsg release];
	[msg release];
	//NSLog(@"finished setDifficultyLabel");
	
}

/*
 *	this function is the animation selector for the asteroids and the bullets
 *	it is also where we check for collisions
 */
-(void) onTimer {
	//update the time count by adding 'gamePlayTimerInterval' seconds to the current count.  //jkehler
	topicTimeCount += gamePlayTimerInterval;
	//write the timer to the screen display;
	topicTimeDisplay.text = [NSString stringWithFormat:@"%d",(int)topicTimeCount];
	

	//NSLog(@"ship direction: %@", [ship direction]);
	
	
	//updates asteroid movement for each of the 10 asteroids, 0-9
	//update every ASTEROID_SPEED_FACTOR times that onTimer is called //jkehler
	//if(asteroidSpeedCounter==ASTEROID_SPEED_FACTOR){
		
	[self animateWarning];
	[self animateShield];
	[self animateExplosion: shipDestroyed];
	
	if(gameOverCounter == 0)     //game is over, initiate loose scenario
	{
		gameOverCounter = -1;
		[self loseScenario];
	}
	else if(gameOverCounter >0)   //game is over, allow to run for final animations
		gameOverCounter--;
	else						//game is not over so ship should not be hidden
		shipIcon.hidden = NO;
		
	
	asteroidSpeedCounter=0;//reset it to startcounting again.
	for(int asteroidIndex = 0; asteroidIndex < 5; asteroidIndex++)
	{
		[[asteroids objectAtIndex: asteroidIndex] move];
	}
		
	//}else{
	//	asteroidSpeedCounter++;
	//}
	
	//updates the bullet movement for each of the 6 bullets and checks for collisions with asteroids 
	//in which case both bullet and asteroid are destroyed
	Bullet *tempBullet;
	for(int bulletIndex = 0; bulletIndex < 6; bulletIndex++)
	{
		
		tempBullet = [bullets objectAtIndex: bulletIndex];
		
		//moves bullet
		[tempBullet setBulletPosition: (tempBullet.bulletPosition.x + bulletPos[bulletIndex].x) 
									 : (tempBullet.bulletPosition.y + bulletPos[bulletIndex].y)];
		
		
		// hide the bullet if it's offscreen
		// x > height because Apple is retarded and in a wideview, height is still referred to as what is now width
		// we hide the bullets offscreen at -200,700 so check that the bullet is within boundaries.
		if( tempBullet.bulletPosition.x > [[UIScreen mainScreen] bounds].size.height  ||  
		   tempBullet.bulletPosition.x  < 0 &&  tempBullet.bulletPosition.x > -200 || 
		   tempBullet.bulletPosition.y > [[UIScreen mainScreen] bounds].size.width && tempBullet.bulletPosition.y < 700 ||  
		   tempBullet.bulletPosition.y  <  0 ) {
			
			
		//	NSLog(@"bullet out of bounds at x: %f y: %f", tempBullet.bulletIcon.center.x, tempBullet.bulletIcon.center.y);
		//	NSLog(@"screen width: %f\nscreen height: %f", [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
			bulletPos[bulletIndex].x = 0;
			bulletPos[bulletIndex].y = 0;
			
			[tempBullet setBulletPosition: -200 : 700];
			tempBullet.bulletIcon.hidden = YES;
		}
		
		//for every asteroid (10 asteroids) check for collision 
		for( int asteroidIndex = 0; asteroidIndex < 5; asteroidIndex++)//jkehler
		{
			
			//if there is a collision then destroy both asteroid and bullet, hide the bullet and move it off screen and
			//move the asteroid to just above and to the left of the screen so it can move back into the screen area
			//as a new asteroid
			
			
			// if bullets collide with ANY of the 10 asteroids
			int asteroidPositionX = [[asteroids objectAtIndex: asteroidIndex] asteroidPosition].x;
			int asteroidPositionY = [[asteroids objectAtIndex: asteroidIndex] asteroidPosition].y;
			int asteroidWidth = [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].image.size.width;
			int asteroidHeight = [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].image.size.height;
			
			// check boundaries within 60% of width and height (compensates for timer inconsistencies)
			if(  (tempBullet.bulletPosition.x < asteroidPositionX + asteroidWidth * 0.6) 
					&& (tempBullet.bulletPosition.x > asteroidPositionX - asteroidWidth * 0.6) 
					&& (tempBullet.bulletPosition.y < asteroidPositionY + asteroidHeight * 0.6) 
					&& (tempBullet.bulletPosition.y > asteroidPositionY - asteroidHeight * 0.6)) {		
				
				//NSLog(@"asteroid position: %f",[[asteroids objectAtIndex:asteroidIndex]asteroidIcon].center.x);
				//NSLog(@"bullet position: %f", tempBullet.center.x);
				
				//set explosion to the position of the asteroid  //sverner
				explosion.center =  [[asteroids objectAtIndex: asteroidIndex] asteroidPosition];
				
				// destroy asteroid and bullet by hiding them off screen
				[[asteroids objectAtIndex: asteroidIndex] setAsteroidPosition: -10 - (arc4random() % 4) : -10 - (arc4random() % 4)];
				[tempBullet setBulletPosition: 0 :500];
				tempBullet.bulletIcon.hidden = YES;
				bulletPos[bulletIndex] = CGPointMake(0,0);
				
				//start explosion  //sverner
				explosionAnimationCounter = EXPLOSION_ANIMATION_DURATION;

				
			}
			
			// if we have no collision, check the next bullet.
			else continue;
			
			// handle correct/incorrect collision with bullets scenarios
			[self asteroidCollision: asteroidIndex];
			
			// no need to check the other asteroids if we made a hit.
			break;
			
		} // end of asteroidIndex
		
	} // end of bulletIndex
	
	
	/*
	 *	check for asteroid-asteroid collision and collision with the ship
	 */
	// for every asteroid i
	for (int i = 0; i < 5; i++) {//jkehler
		/*
		// and for every asteroid j > i
		for (int j = i + 1; j < 5; j++) {//jkehler
			
			// check for collision with other asteroids
			// not working.
			//[self checkCollisionOf: [asteroids objectAtIndex: i] with : [asteroids objectAtIndex: j]];
		}*/
		
		// check for collision with the ship
		[self checkCollisionOf: [asteroids objectAtIndex: i] withShip: ship];
		
	}
}

// check collision of asteroid with ship
-(BOOL) checkCollisionOf:(Asteroid*)as withShip:(Ship*)aShip {
	int shipWidth;
	int shipHeight;
	//int randomizeAsteroidRestart = rand()%4;
	
	// if the shield is not zero, regard the shield's dimensions instead of the ship's for collisions //jkehler
	/*if (shield != 0) {
		
		// add the asteroid's width and height so it would collide with the edge rather than the center of the asteroid
		shipWidth = shipShield.image.size.width + as.asteroidIcon.image.size.width / 2;
		shipHeight = shipShield.image.size.height + as.asteroidIcon.image.size.height / 2;
	}
	// otherwise check with the dimensions of the ship itself
	else{
		
		shipWidth = ship.shipIcon.image.size.width;
		shipHeight = ship.shipIcon.image.size.height;
	}*/
	//jkehler commented out above and wrote below, changing so it always uses ships dimensions, shield is too large a target.
	shipWidth = shipShield.image.size.width + as.asteroidIcon.image.size.width / 2;
	shipHeight = shipShield.image.size.height + as.asteroidIcon.image.size.height / 2;
	
	
	// asteroid did collide with the ship
	if(  ((as.asteroidPosition.x < shipShield.center.x + shipWidth / 2 ) 
		  && (as.asteroidPosition.x > shipShield.center.x - shipWidth / 2))
	   && ((as.asteroidPosition.y < shipShield.center.y + shipHeight / 2) 
		   && (as.asteroidPosition.y > shipShield.center.y - shipHeight / 2)) ) {
		
		// so set the asteroid somewhere off screen, either along the bottom of the screen (first if) 
		//or along the left side of the screen (second if)
		/*	if(randomizeAsteroidRestart == 0 )
			[as setAsteroidPosition: -20 + rand()%490 : 320];  
		else 
			[as setAsteroidPosition: -20  : rand()%310 + 10 ];
		*/
		
		//jkehler why not just call setASteroidPosition because we hsould alsochange its vector.
		//first set the position somewhere outside the screen.
		int xpos,ypos;
		//either -20 or 320
		if(rand()%3<2){
			xpos=-20;
		}else
			xpos=320;
		if(rand()%3<2){
			ypos=-20;
		}else
			ypos=490;
		//now changed vector as well
		[as setAsteroidPosition:xpos:ypos];
		
		// decrease the shield by a third of its power ONLY if the asteroid was a blank! //jkehler
		//if([as asteroidType] == BLANK_ASTEROID){
			[self decreaseShield];
		//}
	}
	return NO;
	
}


-(void) checkCollisionOfUnitTest{
	
	BOOL unitTestPassed = TRUE;
	[[asteroids objectAtIndex: 1] setAsteroidPosition:20 :20];
	[[asteroids objectAtIndex: 2] setAsteroidPosition:20 :20];
	
	if([self checkCollisionOf: [asteroids objectAtIndex: 1] with : [asteroids objectAtIndex: 2]] == NO)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: checkCollisionOf; collision not detected properly1");
		unitTestPassed = FALSE;
	}
	
	[[asteroids objectAtIndex: 1] setAsteroidPosition:20 :100];
	[[asteroids objectAtIndex: 2] setAsteroidPosition:20 :20];
	
	if([self checkCollisionOf: [asteroids objectAtIndex: 1] with : [asteroids objectAtIndex: 2]] == YES)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: checkCollisionOf; collision not detected properly2");
		unitTestPassed = FALSE;
	}
	
	[[asteroids objectAtIndex: 1] setAsteroidPosition:100 :20];
	[[asteroids objectAtIndex: 2] setAsteroidPosition:20 :20];
	
	if([self checkCollisionOf: [asteroids objectAtIndex: 1] with : [asteroids objectAtIndex: 2]] == YES)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: checkCollisionOf; collision not detected properly3");
		unitTestPassed = FALSE;
	}
	if(unitTestPassed == TRUE)
		NSLog(@"UNIT TEST PASSED; class: GameScreenController; function: checkCollisionOf");
	
}


// reduce the shield of the ship by a third of its power
// and check if lives are lost
-(void) decreaseShield {
	
	// check that shield isn't at 0
	if (shield > 0)  {
		
		shield--;
		shieldPower -= 0.33333;
		
		[self updateShieldTo: shield];
		
	}
	else {
		// if shield is at 0, reset it, and decrease lives.
		shieldPower = 1.0;
		[self updateShieldTo: 3];
		[self decreaseLives];
	}
	//[self beginShieldAnimation];
	shieldAnimationCounter = SHIELD_ANIMATION_DURATION;
}

// increase the shield by a third of its power, if it is full, do nothing.
-(void) increaseShield {
	
	if (shield != 3) {
		[self updateShieldTo: shield + 1];
	}
}

-(void) decreaseShieldUnitTest {
	int tempShield = shield;
	[self decreaseShield];
	if (tempShield == shield)
		NSLog(@"UNIT TEST FAILED; function: decreaseShield; sheild not changed by decrease");
	else
		NSLog(@"UNIT TEST PASSED; fucntion: decreaseShield");
}

// decrease lives by one and update the livesLabel
-(void) decreaseLives {
	
	if (lives == 0) 
	{
		shipDestroyed = TRUE;
		shipIcon.hidden = YES;
		gameOverCounter = WARNING_ANIMATION_DURATION; 
		explosionAnimationCounter = EXPLOSION_ANIMATION_DURATION;
		//[self loseScenario];
	}
	else {
		lives--;
		[self updateLivesTo: lives];
		[feedbackLabel setTextColor:[UIColor redColor]];
		//jkehler i dont' think we need anything but an animation here.
		[self updateFeedbackLabelTo: @"Death really hurts!"];
		//[self beginFeedbackAnimation];
		
		warningAnimationCounter = WARNING_ANIMATION_DURATION;
		explosionAnimationCounter = EXPLOSION_ANIMATION_DURATION;
		explosion.center = shipIcon.center;
		shipIcon.hidden = YES;
		NSLog(@"Ship is destroyed since the player has lost a life.");
		shipDestroyed = TRUE;
		//for(int i = 0; i<EXPLOSION_ANIMATION_DURATION; i++)
		//{
		//	[self animateExplosion: TRUE];

		//}

	}
}

// increase lives by one and update livesLabel
-(void) increaseLives {
	
	lives++;
	[self updateLivesTo: lives];
}

-(void) decreaseLivesUnitTest {
	//int tempLives = lives;
	[self decreaseLives];
	//if(tempLives == lives)
	//	NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: decreaseShield; sheild not changed by decrease");
	//else
	//	NSLog(@"UNIT TEST PASSED; class: GameScreenController; fucntion: decreaseShield");
}

// update the lives representing UI elements
-(void) updateLivesTo:(int)newVal {
	
	lives = newVal;
	NSString *msg = [[NSString alloc] initWithFormat:@"Lives: %d",lives];
	[livesLabel setText:msg];
	[msg release];
}
-(void) updateLivesToUnitTest{
	
	BOOL unitTestPassed = TRUE;
	[self updateLivesTo:1];
	if (lives != 1)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: updateLivesTo; lives variable not changed properly");
		unitTestPassed = FALSE;
	}	
	[self updateLivesTo:3];
	if (lives != 3)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: updateLivesTo; lives variable not changed properly");
		unitTestPassed = FALSE;
	}
	
	if(unitTestPassed == TRUE)
		NSLog(@"UNIT TEST PASSED; class: GameScreenController; fucntion: updateLivesTo");
}
// updates the shield and whatever UI elements represent it
-(void) updateShieldTo:(int)newVal {
	
	shield = newVal;
	[shieldBar setProgress: 1.0 - (3-shield) * 0.33];
	shieldBarMultiplier = 1.0 + (shield / 10.0);
	if (shield == 0) shipShield.hidden = YES;
	else shipShield.hidden = NO;
	
	shipShield.transform =  originalShieldBounds;
	shipShield.transform = CGAffineTransformMakeScale(shieldBarMultiplier, shieldBarMultiplier);
	

}
-(void) updateShieldToUnitTest{
	
	BOOL unitTestPassed = TRUE;
	
	[self updateShieldTo:1];
	if (shield != 1)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: updateShieldTo; shield variable not changed properly");
		unitTestPassed = FALSE;
	}
	
	[self updateShieldTo:3];
	if (shield != 3)
	{
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: updateShieldTo; shield variable not changed properly");
		unitTestPassed = FALSE;
	}
	if(unitTestPassed == TRUE)
		NSLog(@"UNIT TEST PASSED; class: GameScreenController; fucntion: updateShieldTo");
}
// updates the score and its UI elements
-(void) updateScoreTo:(int)newScore {
	
	[UIAppDelegate.currentUser.score setScore: newScore];
	[self updateScoreLabel];
}

// updates the feedbackLabel
-(void) updateFeedbackLabelTo:(NSString*)newText {
	
	[feedbackLabel setText: newText];
	
	
}



// reset : score = 0, lives = 3, shield = 3
-(void) resetValues {
	
	[self updateLivesTo: 3];
	[self updateShieldTo: 3];
	[self updateScoreTo: 0];
}

// checks if two asteroids collide
-(BOOL) checkCollisionOf:(Asteroid*)as1 with:(Asteroid*)as2 {
	
	
	if(  ((as1.asteroidPosition.x + as1.asteroidIcon.bounds.size.width / 2< 
		   as2.asteroidPosition.x + as2.asteroidIcon.bounds.size.width / 2 ) 
		  && (as1.asteroidPosition.x + as1.asteroidIcon.bounds.size.width / 2  > 
			  as2.asteroidPosition.x - as2.asteroidIcon.bounds.size.width / 2 ))
	   && ((as1.asteroidPosition.y + as1.asteroidIcon.bounds.size.height / 2 < 
			as2.asteroidPosition.y + as2.asteroidIcon.bounds.size.height / 2 ) 
		   && (as1.asteroidPosition.y +as1.asteroidIcon.bounds.size.height / 2 > 
			   as2.asteroidPosition.y - as2.asteroidIcon.bounds.size.height / 2)) ) {
	 
	
		// if they collide, handle the collision.
		[self handle2AsteroidsColliding: as1 with : as2];
		return YES;
	}
	return NO;
}

// handle the case of asteroids colliding with each other
-(void) handle2AsteroidsColliding: (Asteroid*)as1 with:(Asteroid*)as2 {
	
	// reverse their x directions
	//NSLog(@"asteroid x: %f asteroid y: %f", as1.asteroidSize.x , as1.asteroidSize.y);
	
	// currently leads to very funky results
	
	 [as1 setAsteroidDirection: -as1.asteroidDirection.x : as1.asteroidDirection.y];
	 [as1 setAsteroidDirection: as1.asteroidDirection.x : -as1.asteroidDirection.y];
	 [as2 setAsteroidDirection: -as2.asteroidDirection.x : as2.asteroidDirection.y];
	 [as2 setAsteroidDirection: as2.asteroidDirection.x : -as2.asteroidDirection.y];
	
	
	
}

// begin explosion animation
-(void) asteroidExplosionAnimation:(CGPoint)location {
	/*
	// define animation images
	NSMutableArray *myImages = [NSMutableArray arrayWithObjects: 
						 [UIImage imageNamed:@"expl1.png"], 
						 [UIImage imageNamed:@"expl2.png"], 
						 [UIImage imageNamed:@"expl3.png"], 
						 [UIImage imageNamed:@"expl4.png"], 
						 [UIImage imageNamed:@"expl5.png"], 
						 [UIImage imageNamed:@"expl6.png"], 
						 [UIImage imageNamed:@"expl7.png"], 
						 [UIImage imageNamed:@"expl8.png"],
						 [UIImage imageNamed:@"expl9.png"], 
						 [UIImage imageNamed:@"expl10.png"], 
						 [UIImage imageNamed:@"expl11.png"], nil];
	
	animatedExplosion = [UIImageView alloc];
	CGRect frame = CGRectMake(location.x, location.y, 40.0, 40.0);
	[animatedExplosion initWithFrame: frame]; 
	animatedExplosion.animationImages = myImages; 
	animatedExplosion.animationDuration = 0.25; // seconds 
	animatedExplosion.animationRepeatCount = 5; // 0 = loops forever 
	
	// start animation
	NSLog(@"animating explosion");
	[animatedExplosion startAnimating];
	
	// release object
	[animatedExplosion release]; 
	 */
}

// handles the asteroid collision scenarios
-(void) asteroidCollision: (int) asteroidIndex {
	
	// sound an explosion
	[sound playAsteroidExplosion];
	
	// begin explosion animation at current location 
	//[[asteroids objectAtIndex: asteroidIndex] beginExplosionAnimation: [[asteroids objectAtIndex: asteroidIndex] asteroidPosition]];
	//[self asteroidExplosionAnimation: [[asteroids objectAtIndex: asteroidIndex] asteroidPosition]];
		
	explosionAnimationCounter = EXPLOSION_ANIMATION_DURATION;
	
	// if we hit the right asteroid
	if([[asteroids objectAtIndex: asteroidIndex] asteroidType] == CORRECT_ASTEROID) 
	{
		// update the score and reset asteroid positions/labels/types
		[self hitCorrectAsteroid: asteroidIndex];
	}
	
	// if we hit a wrong asteroid
	else if ([[asteroids objectAtIndex: asteroidIndex] asteroidType] == INCORRECT_ASTEROID) 
	{
		// update the score and reset only position/label of current asteroid
		[self hitWrongAsteroid: asteroidIndex];
	}
	
	// if we hit a blank asteroid
	else if ([[asteroids objectAtIndex: asteroidIndex] asteroidType] == BLANK_ASTEROID)
	{
		[self hitBlankAsteroid: asteroidIndex];
	}
	

}

// what to do when a bullet collides with the correct_answer asteroid
-(void) hitCorrectAsteroid: (int) index {
	
	NSLog(@"hit correct asteroid.");
	
	if(shieldPower < 1)
		shieldPower += 0.33333;
	shipShield.alpha = shieldPower;
	
	[self increaseShield];
	int score = [UIAppDelegate.currentUser.score score];
	//update stats
	[[UIAppDelegate.currentUser stats] setCorrectHits:[[UIAppDelegate.currentUser stats] correctHits] + 1]; //jkehler
	
	// update the feedback label
	[feedbackLabel setTextColor:[UIColor greenColor]];
	[self updateFeedbackLabelTo: @"Correct!"];
//	[self beginFeedbackAnimation];
	warningAnimationCounter = WARNING_ANIMATION_DURATION;
	
	// update the scoreboard 
	score = score + CORRECT_ANSWER_REWARD;
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", score ];
	[scoreLabel setText: inputString];
	[inputString release];
	
	// update the location of the asteroid to a random point on the screen
	//jkehler following code is to prevent spawns too close to ship

	//int i=0;
	int xloc,yloc;
	for(int i=0;i<5;i++){ //we want them to spawn outside range of ship x: outside 50-410,y outside 50-270
		//either %50 or 410+%50
		if(arc4random()%3<2){
			xloc = arc4random()%50;
		}else
			xloc = 410+arc4random()%50;
		
		if(arc4random()%3<2){
			yloc = arc4random()%50;
		}else
			yloc = 270 + arc4random()%50;
		
		//(Max - Min) * random(0 to 1) + Min = random(Min to Max)
		/*
		int xloc=460/2;
		int yloc=320/2;
		while(xloc > 100 && xloc < 360){
			xloc=arc4random()%460;
		}
		while(yloc > 100 && yloc < 220){
			yloc=arc4random()%320;
		}*/
		//[[asteroids objectAtIndex:index] setAsteroidPosition:xloc: yloc];
		[[asteroids objectAtIndex:i] setAsteroidPosition:xloc:yloc];//reset all the asteroid positions.
	}
	//[[asteroids objectAtIndex: index] setAsteroidPosition: (arc4random() % 460) : (arc4random() % 320)];
	
	[UIAppDelegate.currentUser.score setScore: score];
	
	// check if gameover
	[self checkScore];
	
	// reset question and asteroid labels
	[self setQuestion];
	
}

// hit wrong asteroid
-(void) hitWrongAsteroid:(int)index {
	
	NSLog(@"hit incorrect asteroid.");
	int score = [UIAppDelegate.currentUser.score score];
	//update stats
	[[UIAppDelegate.currentUser stats] setIncorrectHits:[[UIAppDelegate.currentUser stats] incorrectHits] + 1]; //jkehler
	
	// update the feedback label
	[feedbackLabel setTextColor:[UIColor redColor]];
	[self updateFeedbackLabelTo: @"Incorrect!"];
	//[self beginFeedbackAnimation];
	warningAnimationCounter= WARNING_ANIMATION_DURATION;
	
	// decrement score by incorrect penalty and update the scoreboard
	score = score - INCORRECT_ANSWER_PENALTY;
	NSString *inputString = [[NSString alloc] initWithFormat: @"Score: %d", score ];
	[scoreLabel setText: inputString];
	[inputString release];
	
	// update the location of the asteroid to a random point on the screen
	//should be OFF the screen!
	int xpos,ypos;
	//either -20 or 320
	if(rand()%3<2){
		xpos=-20;
	}else
		xpos=320;
	if(rand()%3<2){
		ypos=-20;
	}else
		ypos=490;
	//now changed vector as well
	//[as setAsteroidPosition:xpos:ypos];
	[[asteroids objectAtIndex: index] setAsteroidPosition: xpos : ypos];
	//[[asteroids objectAtIndex: index] setAsteroidPosition: (arc4random() % 460) : (arc4random() % 320)];
	
	[UIAppDelegate.currentUser.score setScore: score];
	
	// check if game is over
	[self checkScore];
}

// hit a blank asteroid
-(void) hitBlankAsteroid:(int)index {
	
	NSLog(@"hit blank asteroid.");
	
	int score = [UIAppDelegate.currentUser.score score];
	//update stats
	[[UIAppDelegate.currentUser stats] setBlankHits:[[UIAppDelegate.currentUser stats] blankHits] + 1]; //jkehler
	
	// increase score by 1 and update the scoreboard
	score = score + BLANK_REWARD;
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", score ];
	[scoreLabel setText:inputString];
	[inputString release];
	
	// update the location of the asteroid to a random point on the screen
	int xpos,ypos;
	//either -20 or 320
	if(rand()%3<2){
		xpos=-20;
	}else
		xpos=320;
	if(rand()%3<2){
		ypos=-20;
	}else
		ypos=490;
	//now changed vector as well
	//[as setAsteroidPosition:xpos:ypos];
	[[asteroids objectAtIndex: index] setAsteroidPosition: xpos : ypos];
	//[[asteroids objectAtIndex: index] setAsteroidPosition: (arc4random() % 460) : (arc4random() % 320)];
	
	[UIAppDelegate.currentUser.score setScore: score];
	
	// check if game is over
	[self checkScore];
}

// raise the difficulty if the user reached the limit and as long as it's not already on hardest
// if it's lower than 0 then the game is over (lose scenario)
// if it's over the limit of the hardest difficulty then the game is over (win scenario)
-(void) checkScore {//jkehler settings are saved once at the end of the function now
	
	int diff = [UIAppDelegate.currentUser.currentTopic difficulty];
	int score = [UIAppDelegate.currentUser.score score];
	
	// if the current score is higher than highestScore, update the AppDelegate profile.
	if (score > [UIAppDelegate.currentUser.highestScore score]) {
		
		//NSLog(@"saving highest score : %d", score);
		[UIAppDelegate.currentUser.highestScore setScore: score];
	}
	
	// if current topic is higher than lastTopicCompleted (highest topic achieved yet) then update the AppDelegate profile.
	if (UIAppDelegate.currentUser.currentTopic.topic > UIAppDelegate.currentUser.lastTopicCompleted.topic) {
		
		[UIAppDelegate.currentUser setLastTopicCompleted: UIAppDelegate.currentUser.currentTopic];
		
		// and save settings
		//[GlobalAdmin saveSettings];
	}
	
	//jkehler isn't this handled by the asteroid destrcution function ????
	// if score is higher than set limit for difficulty, then raise the difficulty

	if (score > DIFFICULTY_LIMIT * diff && diff < DIFFICULTY_HARDEST) {
		
		// raise difficulty by one
		[[UIAppDelegate.currentUser currentTopic] setDifficulty: diff + 1];
		//also update
		// and save settings
		//[GlobalAdmin saveSettings];
		
		
		// reset the label
		[self setDifficultyLabel];
	}
	
	// if negative score, game is over (lose)
	if (score < 0 ) {
		
		// reset the score
		score = 0;
		[UIAppDelegate.currentUser.score setScore: score];
		
		[self updateScoreLabel];
		
		
		// initiate lose scenario
		shipDestroyed = TRUE;
		shipIcon.hidden = YES;
		gameOverCounter = WARNING_ANIMATION_DURATION; 
		explosionAnimationCounter = EXPLOSION_ANIMATION_DURATION;
		//[self loseScenario];
	}
	
	// if the current topic is the highest we've done so far, update the highest difficulty.
	if ([UIAppDelegate.currentUser.currentTopic topic] == [UIAppDelegate.currentUser.lastTopicCompleted topic] &&
		diff > [UIAppDelegate.currentUser.lastTopicCompleted difficulty]) {
		
		// then update the highestDifficulty in the AppDelegate profile
		[UIAppDelegate.currentUser.lastTopicCompleted setDifficulty: diff];
		
		// save settings
		//[GlobalAdmin saveSettings];
	}
	
	// if the score is higher than the set limit for topic
	if (score > DIFFICULTY_HARDEST * DIFFICULTY_LIMIT) {
		
		// when progressing to the next topic, we should save and reset the topicTimeCount 
		// (we only save if its better than whats currently stored in the user profile
		//jkehler
		NSNumber *temp = [NSNumber numberWithDouble: topicTimeCount];
		
		if([[UIAppDelegate.currentUser currentTopic] topic] == TOPIC_ADDITION &&
		   [[UIAppDelegate.currentUser stats] additionTime] < [temp intValue]) {
			
			[[UIAppDelegate.currentUser stats] setAdditionTime: [temp intValue]];
		}
		
		else if ([[UIAppDelegate.currentUser currentTopic] topic] == TOPIC_SUBTRACTION &&
				  [[UIAppDelegate.currentUser stats] subtractionTime] < [temp intValue]) {
				
			[[UIAppDelegate.currentUser stats] setSubtractionTime: [temp intValue]];
		}
	
		else if ([[UIAppDelegate.currentUser currentTopic] topic] == TOPIC_MULTIPLICATION &&
				  [[UIAppDelegate.currentUser stats] multiplicationTime] < [temp intValue]) {
				
			[[UIAppDelegate.currentUser stats] setMultiplicationTime: [temp intValue]];
		}
			
		else if([[UIAppDelegate.currentUser currentTopic] topic] == TOPIC_MULTIPLICATION &&
				 [[UIAppDelegate.currentUser stats] divisionTime]< [temp intValue]) {
			
				[[UIAppDelegate.currentUser stats] setDivisionTime:[temp intValue]];
		}

		topicTimeCount = 0;

		
		// if we haven't yet exhaused all our topics, progress to the next topic
		if ([UIAppDelegate.currentUser.currentTopic nextTopic]) {

			// increase lives by 1
			[self increaseLives];
			
			// update the profile's lastTopicCompleted if this one is higher
			if (UIAppDelegate.currentUser.currentTopic.topic > UIAppDelegate.currentUser.lastTopicCompleted.topic) {
				
				[UIAppDelegate.currentUser setLastTopicCompleted: UIAppDelegate.currentUser.currentTopic];
			}
			else {};	// avoid nested ambiguities.
			
			// save settings
			//[GlobalAdmin saveSettings];
			
			// reset the score
			score = 0;
			[UIAppDelegate.currentUser.score setScore: score];
			
			// reset the labels
			[self setDifficultyLabel];
			[self updateScoreLabel];
		}
		
		// otherwise, you've won.
		else {
			[self winScenario];
		}
	}
	[GlobalAdmin saveSettings];
}

// update the score label to the current score value
-(void) updateScoreLabel {
	
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", [UIAppDelegate.currentUser.score score]];
	[scoreLabel setText:inputString];
	[inputString release];
}

// begin lose scenario
-(void) loseScenario {
	
	//ship explodes animation and game over warning
	[self updateFeedbackLabelTo: @"Game Over!"];
	warningAnimationCounter = WARNING_ANIMATION_DURATION;
	explosionAnimationCounter = EXPLOSION_ANIMATION_DURATION;
	explosion.center = shipIcon.center;
	shipIcon.hidden = YES;
	NSLog(@"Ship explodes for game over.");
	for(int i = 0; i<EXPLOSION_ANIMATION_DURATION; i++)
	{
		[self animateExplosion: TRUE ];
		[self animateWarning];
		
	}
	for(int i=EXPLOSION_ANIMATION_DURATION; i<WARNING_ANIMATION_DURATION; i++)
	{
		[self animateWarning];
		usleep(100000);
	}
	
	// first save settings to plist
	[GlobalAdmin saveSettings];
	
	// reset score, shield and lives
	[self resetValues];
	
	//play you loose warning
	//[feedbackLabel setTextColor:[UIColor redColor]];
	[self updateFeedbackLabelTo: @"Game Over!"];
	//[self beginFeedbackAnimation];
	warningAnimationCounter = WARNING_ANIMATION_DURATION;
	
	// show lose alert
	UIAlertView *loseAlert = [[[UIAlertView alloc] initWithTitle: @" ): "
														message: @"Don't give up!"
													   delegate: self
											  cancelButtonTitle: nil
											  otherButtonTitles: @"OK", nil] autorelease];
	
	[loseAlert show];
	

	
	[self nextScreen];
}

// begin win scenario
-(void) winScenario {
	
	//unlock last topic diff (couldn't figureu out where to put this in checkScore so putting it here.
	[[UIAppDelegate.currentUser lastTopicCompleted] setDifficulty: DIFFICULTY_HARDEST];
	// first save settings to plist
	[GlobalAdmin saveSettings];
	
	
	// show win alert
	UIAlertView *winAlert = [[[UIAlertView alloc] initWithTitle: @"CONGRATULATIONS !!!!"
													 message: @"You've won the game."
													delegate: self
										   cancelButtonTitle: nil
										   otherButtonTitles: @"OK", nil] autorelease];

	[winAlert show];
	
	//[self nextScreen];
	
	// go directly to main menu from here
	//add option to keep playing?
	if(ENABLE_BONUS_SPEED_GAME == 1){
		UIAppDelegate.bonusSpeedGameEnable=1;
	}else
		[self.navigationController popToRootViewControllerAnimated:YES];
}

// initialize the sound files
// sound gets released at dealloc
-(void) initSound {
	
	
	NSArray *bgFile = [BACKGROUND_MUSIC_3 componentsSeparatedByString: @"."];
	NSArray *laserFile = [LASER_EFFECT_4 componentsSeparatedByString: @"."];
	NSArray *explosionFile = [ASTEROID_EXPLOSION_1 componentsSeparatedByString: @"."];
	
	//NSLog(@"%@", [bgFile objectAtIndex: 0]);
	//NSLog(@"%@", [bgFile objectAtIndex: 1]);
	
	sound = [[Sound alloc] initWithSoundFiles: [bgFile objectAtIndex: 0] bgExt: [bgFile objectAtIndex: 1] 
										laser: [laserFile objectAtIndex: 0] lasterExt: [laserFile objectAtIndex: 1] 
								shipExplosion: [explosionFile objectAtIndex: 0] shipExplosionExt: [explosionFile objectAtIndex: 1] 
							asteroidExplosion: [explosionFile objectAtIndex: 0] asteroidExplosionExt: [explosionFile objectAtIndex: 1]];
	[sound retain];
	
}


// navigate to the help screen
-(IBAction) helpScreen {
	
	
	// Navigation logic may go here -- for example, create and push another view controller.
	if(gamePaused == FALSE)  //pause game while entering the help screen
		[self pauseGame];
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
	
}

// navigate to the gameover screen
-(IBAction) nextScreen {
	
	GameOverScreenController *gamesOverScreenView = [[GameOverScreenController alloc] initWithNibName:@"GameOverScreenController" bundle:nil];
	[self.navigationController pushViewController:gamesOverScreenView animated:YES];
	[gamesOverScreenView release];
	
}

-(void) touchesUpdateUnitTest:(NSSet*)touches :(UIEvent*)event {
	//[touch 
}

// update the touch events (rotation wheel)
-(void) touchesUpdate:(NSSet*)touches :(UIEvent*)event {
	
	UITouch *touch = [[event allTouches] anyObject];		//records touch as touch object
    CGPoint location = [touch locationInView:touch.view];	//records touch's location
    //NSLog(@"X: %f",location.x);
    //NSLog(@"Y: %f",location.y);
	
	
	double x,y;
	double radius = 48;  //radius of rotation wheel
	double radiusSquared = radius*radius; //radius squared
	double xcenter = 80; //center of rotation wheel, x coordinate
	double ycenter = 222; //center of rotation wheel, y coordinate
	
	//if location of a touch is in the area of the rotation wheel, update the 
	//rotation wheel
	if(location.x > 22 && location.x < 160 && location.y > 146 && location.y < 285)
	{
		
		//code to approximate the closest point on the rotation wheel to the point
		//where the user touched the screen (they usually will not touch the 
		//rotation wheel right on so an approximation is necessary:
		
		if(location.y < ycenter-radius)
			location.y = ycenter-radius;
		else if (location.y > ycenter+radius )
			location.y = ycenter+radius ;
		
		if(location.x < xcenter-radius)
			location.x = xcenter-radius;
		else if (location.x > xcenter+radius )
			location.x = xcenter+radius ;
		
		if(location.y >= ycenter)
			y = sqrt( radiusSquared - pow(xcenter- location.x , 2) ) + ycenter; 
		else
		{
			y = -sqrt( radiusSquared - pow(xcenter- location.x , 2) ) + ycenter; 
		}
		
		y = (y + location.y) / 2.0;
		
		if(location.x >= xcenter)
			x = sqrt(radiusSquared - pow(ycenter - y,2) ) + xcenter;
		else
			x = -sqrt(radiusSquared - pow(ycenter - y, 2) ) + xcenter;
		
		//rotation ball is moved to the approximation of the closest point on the
		//rotation wheel to the point where to user actually touched the screen
		rotationBall.center = CGPointMake(x,y); 
		
		//shipDirection (used for ship rotation and firing direction) is updated
		shipDirectionX = (x - xcenter);
		shipDirectionY = (y - ycenter);
		
		CGFloat rotationAngle = atan2( shipDirectionY,shipDirectionX) + M_PI_2;
		[ship rotate: rotationAngle];		
	}
	
}

/*This function is called when a touch on the screen is first detected
 */
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	
	[self touchesUpdate:touches : event];
	
	//[self touchesUpdateUnitTest:touches : event];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touchesEnded");
}

/*This function is called when a finger is dragged on the screen */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{ 
	[self touchesUpdate:touches : event];
	
}

// override to allow orientations other than the default portrait orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

// release all created objects
- (void)dealloc {
	[ship release];
	[asteroidIcons release];
	[bulletIcons release];
	[solutionLabels release];
	[asteroids release];
	[bullets release];
	[question release];
	[sound release];
	sound = nil;
    [super dealloc];
}


@end
