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
	//rotationController.transform=CGAffineTransformMakeRotation (iconRotationAngle);
	rotationController.transform=CGAffineTransformMakeRotation ([ship direction]);
	
	// scale to 1.3, 1.2, 1.1, or 1.0 of original size
	shipShield.transform = CGAffineTransformMakeScale(shieldBarMultiplier, shieldBarMultiplier);
	
	//NSLog(@"multiplier: %f", shieldBarMultiplier);
	
	// rotates the shield (but currently negates the effect of scaling)
	// comment this out to allow shield scaling
	//shipShield.transform = CGAffineTransformMakeRotation (iconRotationAngle);
	
	
	// increment angle
	iconRotationAngle += ICON_ROTATION_COEFFICIENT;
	
}

// starts fadein/fadeout animation for feedback label
-(void) beginFeedbackAnimation {
	
	feedbackLabel.hidden = NO;
	feedbackLabel.alpha = 0;
	feedbackLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
	
	// start animation seq.
	[UIView beginAnimations: nil context: NULL];
	
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDuration: 1];
	[UIView setAnimationRepeatCount: 3];
	
	feedbackLabel.alpha = 1;
	feedbackLabel.transform = CGAffineTransformIdentity;
	
	// end animation
	[UIView commitAnimations];
}

// starts the decreased shield animation sequence
-(void) beginShieldAnimation {
	
	shipShield.alpha = 0.0;
	
	// start of animation seq.
	[UIView beginAnimations: nil context: NULL];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDuration: 0.7];
	[UIView setAnimationRepeatCount: 3];
	
	shipShield.alpha = 1.0;
	
	// end animation
	[UIView commitAnimations];
	
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
	
	iconRotationAngle = 0.0f;
	
	NSLog(@"gamescreen view did appear.");
	
	// set the screen title
	[self.navigationController setTitle: @"gameScreenView"];
	
	// if the game is paused when returning to view, unpause.
	//if (gamePaused == FALSE) {
	if (gamePaused) {
		
		NSLog(@"unpausing game in viewdidappear");
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
	NSLog(@"about to check if sound is playing");
	if (sound != nil && [sound.bgPlayer isPlaying]) {
		
		[sound.bgPlayer stop];
	}
	
	[sound release];
	
	NSLog(@"after sound release in view will disappear");
	sound = nil;
	
	// compare score and save to profile if necessary
	if ([UIAppDelegate.currentUser.score score] > [UIAppDelegate.currentUser.highestScore score]) {
		NSLog(@"comparing scores");
		[UIAppDelegate.currentUser setHighestScore: [UIAppDelegate.currentUser score]];
	}
	
	// save profile to plist before leaving gamescreen
	[GlobalAdmin saveSettings];
}

// another delegate for view lifespan
-(void) viewDidDisappear:(BOOL)animated {
	
	NSLog(@"inside view did disappear");
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	NSLog(@"started viewDidLoad");
	
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
	
	gamePlayTimerInterval = 0.03;
	
	asteroidIcons = [[NSMutableArray alloc] initWithObjects: asteroid0, asteroid1, asteroid2, asteroid3,
					 asteroid4, asteroid5, asteroid6, asteroid7, asteroid8, asteroid9,nil];
	[asteroidIcons retain];
	NSLog(@"allocated asteroidIcons");
	
	solutionLabels  = [[NSMutableArray alloc] initWithObjects: solutionLabel0, solutionLabel1, solutionLabel2, 
					   solutionLabel3, solutionLabel4, solutionLabel5, nil];
	[solutionLabels retain];
	
	asteroids = [[NSMutableArray alloc] init];
	[asteroids retain];
	bullets = [[NSMutableArray alloc] init];
	[bullets retain];
	
	NSLog(@"allocated solutionLabels");
	// set the gamescreen label for the selected difficulty
	[self setDifficultyLabel];
	
	// create a temp object for the initialization
	Asteroid *asteroid;
	
	// initialize shield
	[self updateShieldTo: 3];
	
	// initialize size of shield frame to 1.3 of its original size
	shieldBarMultiplier = 1.3;

	
	
	// initialize lives
	[self updateLivesTo: 3];
	
	NSLog(@"allocated asteroids");
	
	// for all 6 correct/incorrect solution asteroids in the array, attach an image andd a label
	
	for (int i = 0; i < 10; i++) {
		
		if (i < 6) {
			
			// for the first 6 asteroids attach an image and a label
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
			[asteroid setAsteroidSize: CGPointMake(ASTEROID_SIZE_X,ASTEROID_SIZE_Y)];
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
	
	// reset the position of the bullets to be offscreen
	//	[self initializeBulletPosition];
	
	
	//set the profile pic!
	int picIndex = [UIAppDelegate.currentUser profilePic];
	[profilePic setImage: [GlobalAdmin getPic: picIndex] forState:0];
	//[temp setImage:[(UIAppDelegate.currentUser) getPic] forState:0];
	
	
	[NSTimer scheduledTimerWithTimeInterval: 0.08 target: self
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
	
	// begin laser sound
	[sound playLaser];
	
	Bullet *tempBullet  = [bullets objectAtIndex:bulletsFired];
	//assigns element of bullets array to tempBullet to allow manipulation of that element
	
	//sets the bullet being fired's movement vector to the vector defined by the direction in which the ship is pointing
	bulletPos[bulletsFired] = CGPointMake(shipDirectionX,shipDirectionY); 
	
	// set it to the location of the ship icon
	[tempBullet setBulletPosition: ship.pos.x : ship.pos.y];
	//[tempBullet setBulletDirection: shipDirectionX :shipDirectionY];
	
	tempBullet.bulletIcon.hidden = NO;
	[tempBullet rotate: [ship direction]];
	NSLog(@"angle: %f", [ship direction]);
	
	
	
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
-(void)setAnswer {
	
	// define the solution set of labels on asteroids
	//NSLog(@"starting setAnswer");	
	
	// determine the correct_answer asteroid randomly and set its value and type
	// because we have 6 labeled asteroids
	int randomCorrectAsteroid = arc4random() % 6;	 // from 0 to 5
	NSString *inputString = [[NSString alloc] initWithFormat:@"%d",(int)[question answer]];
	[[[asteroids objectAtIndex: randomCorrectAsteroid] asteroidLabel] setText: inputString];
	
	
	// set asteroid type
	[[asteroids objectAtIndex: randomCorrectAsteroid] setAsteroidType:CORRECT_ASTEROID];
	[inputString release];
	
	//NSLog(@"inside setAnswer and random correct asteroid index is : %d", randomCorrectAsteroid);
	
	// sort through the incorrect_answer asteroids and set their value and type and direction
	for(int asteroidIndex = 0; asteroidIndex < 6; asteroidIndex++)
	{
		if (asteroidIndex != randomCorrectAsteroid) {
			
			// set wrong answer equal to some random value of + [1-7] from the correct answer
			
			// that isn't the correct answer
			int wrongAnswer = 0;
			do {
				wrongAnswer = [question answer] + (arc4random() % 8 * pow(-1, (int)(arc4random() % 8)));
			} while (wrongAnswer == [question answer]);
			NSString *inputString = [[NSString alloc] initWithFormat:@"%d",wrongAnswer];
			[[[asteroids objectAtIndex: asteroidIndex] asteroidLabel] setText: inputString];
			
			// and set the incorrect type
			[[asteroids objectAtIndex: asteroidIndex] setAsteroidType:INCORRECT_ASTEROID];
			
			// then send it on a random path
			[[asteroids objectAtIndex: asteroidIndex] 
			 //setAsteroidDirection:((arc4random() %30 ) / 5  -3) :((arc4random() % 30) / 5 -3)];
			 setAsteroidDirection:	arc4random() % ([UIAppDelegate.currentUser.currentTopic difficulty]) : 
			 arc4random() % ([UIAppDelegate.currentUser.currentTopic difficulty])];
			[inputString release];
			
			[[asteroids objectAtIndex: asteroidIndex] move]; 
		}
	}
	
	
	// set the blank type on a random path
	for (int asteroidIndex = 6; asteroidIndex < 10; asteroidIndex++) {
		
		[[asteroids objectAtIndex: asteroidIndex] setAsteroidType:BLANK_ASTEROID];
		[[asteroids objectAtIndex: asteroidIndex] 
		 setAsteroidDirection:	arc4random() % ([UIAppDelegate.currentUser.currentTopic difficulty]) : 
		 arc4random() % ([UIAppDelegate.currentUser.currentTopic difficulty])];
		[[asteroids objectAtIndex: asteroidIndex] move];
	}
	//NSLog(@"end of answer");
}

// updates the difficulty label to the current difficulty in the user profile
-(IBAction) setDifficultyLabel {
	//NSLog(@"start setDifficultyLabel");
	[[UIAppDelegate.currentUser currentTopic] setDifficulty: UIAppDelegate.currentUser.currentTopic.difficulty];
	int diff = [[UIAppDelegate.currentUser currentTopic] difficulty];
	
	//int diff = [UIAppDelegate.currentUser currentDifficulty];
	
	NSString *diffMsg;
	if (diff == 1) diffMsg = @"Easiest";
	if (diff == 2) diffMsg = @"Easy";
	if (diff == 3) diffMsg = @"Hard";
	if (diff == 4) diffMsg = @"Hardest";
	
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
	
	
	Bullet *tempBullet;
	//NSLog(@"ship direction: %@", [ship direction]);
	
	
	//updates asteroid movement for each of the 10 asteroids, 0-9
	for(int asteroidIndex = 0; asteroidIndex < 10; asteroidIndex++)
	{
		
		[[asteroids objectAtIndex: asteroidIndex] move];
		
	}
	
	
	//updates the bullet movement for each of the 6 bullets and checks for collisions with asteroids 
	//in which case both bullet and asteroid are destroyed
	for(int bulletIndex = 0; bulletIndex < 6; bulletIndex++)
	{
		
		tempBullet = [bullets objectAtIndex: bulletIndex];
		
		//moves bullet
		[tempBullet setBulletPosition: (tempBullet.bulletPosition.x + bulletPos[bulletIndex].x) 
									 : (tempBullet.bulletPosition.y + bulletPos[bulletIndex].y)];
		
		
		
		// hide the bullet if it's offscreen
		if( tempBullet.bulletPosition.x > 486 ||  tempBullet.bulletPosition.x < -6 
		   || tempBullet.bulletPosition.y > 320  ||  tempBullet.bulletPosition.y < -6 ) {
			
	
			bulletPos[bulletIndex].x = 0;
			bulletPos[bulletIndex].y = 0;
			
			[tempBullet setBulletPosition: 0 : 500];
			tempBullet.bulletIcon.hidden = YES;
		}
		
		//for every asteroid (10 asteroids) check for collision 
		for( int asteroidIndex = 0; asteroidIndex < 10; asteroidIndex++)
		{
			
			//if there is a collision then destroy both asteroid and bullet, hide the bullet and move it off screen and
			//move the asteroid to just above and to the left of the screen so it can move back into the screen area
			//as a new asteroid
			
			
			// if bullets collide with ANY of the 10 asteroids
			if(  ((tempBullet.bulletPosition.x < [[asteroids objectAtIndex: asteroidIndex] asteroidPosition].x + 
				   [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].image.size.width) 
				  && (tempBullet.bulletPosition.x > [[asteroids objectAtIndex: asteroidIndex] asteroidPosition].x - 
					  [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].image.size.width))
			   &&((tempBullet.bulletPosition.y < [[asteroids objectAtIndex: asteroidIndex] asteroidPosition].y + 
				   [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].image.size.height) 
				  && (tempBullet.bulletPosition.y > [[asteroids objectAtIndex: asteroidIndex] asteroidPosition].y - 
					  [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].image.size.height)) ) {		
				
				//NSLog(@"asteroid position: %f",[[asteroids objectAtIndex:asteroidIndex]asteroidIcon].center.x);
				//NSLog(@"bullet position: %f", tempBullet.center.x);
				
				// destroy asteroid and bullet by hiding them off screen
				[[asteroids objectAtIndex: asteroidIndex] setAsteroidPosition: -10 - (arc4random() % 4) : -10 - (arc4random() % 4)];
				[tempBullet setBulletPosition: 0 :500];
				tempBullet.bulletIcon.hidden = YES;
				bulletPos[bulletIndex] = CGPointMake(0,0);
				
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
	for (int i = 0; i < 10; i++) {
		
		// and for every asteroid j > i
		for (int j = i + 1; j < 10; j++) {
			
			// check for collision with other asteroids
			[self checkCollisionOf: [asteroids objectAtIndex: i] with : [asteroids objectAtIndex: j]];
		}
		
		// check for collision with the ship
		[self checkCollisionOf: [asteroids objectAtIndex: i] withShip: ship];
		
	}
}

// check collision of asteroid with ship
-(BOOL) checkCollisionOf:(Asteroid*)as withShip:(Ship*)aShip {
	int shipWidth;
	int shipHeight;
	
	// if the shield is not zero, regard the shield's dimensions for collisions
	if (shield != 0) {
		
		shipWidth = shipShield.image.size.width;
		shipHeight = shipShield.image.size.height;
	}
	// otherwise check with the dimensions of the ship itself
	else{
		
		shipWidth = ship.shipIcon.image.size.width;
		shipHeight = ship.shipIcon.image.size.height;
	}
	
	
	if(  ((as.asteroidPosition.x < shipShield.center.x + shipWidth / 2 ) 
		  && (as.asteroidPosition.x > shipShield.center.x - shipWidth / 2))
	   && ((as.asteroidPosition.y < shipShield.center.y + shipHeight / 2) 
		   && (as.asteroidPosition.y > shipShield.center.y - shipHeight / 2)) ) {
		
		// set the asteroid somewhere off screen
		[as setAsteroidPosition: -10 - (arc4random() % 4) : -10 - (arc4random() % 4)];
		
		// decrease the shield by a third of its power
		[self decreaseShield];
		
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
		[self updateShieldTo: shield];
		
	}
	else {
		// if shield is at 0, reset it, and decrease lives.
		[self updateShieldTo: 3];
		[self decreaseLives];
	}
	[self beginShieldAnimation];
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
	if (lives == 0) [self loseScenario];
	else {
		lives--;
		[self updateLivesTo: lives];
	}
}

-(void) decreaseLivesUnitTest {
	int tempLives = lives;
	[self decreaseLives];
	if(tempLives == lives)
		NSLog(@"UNIT TEST FAILED; class: GameScreenController; function: decreaseShield; sheild not changed by decrease");
	else
		NSLog(@"UNIT TEST PASSED; class: GameScreenController; fucntion: decreaseShield");
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
	
	if(  ((as1.asteroidPosition.x < as2.asteroidPosition.x + ASTEROID_SIZE_X ) 
		  && (as1.asteroidPosition.x > as2.asteroidPosition.x - ASTEROID_SIZE_X	))
	   && ((as1.asteroidPosition.y < as2.asteroidPosition.y + ASTEROID_SIZE_Y) 
		   && (as1.asteroidPosition.y > as2.asteroidPosition.y - ASTEROID_SIZE_Y)) ) {
		
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
	/*
	 [as1 setAsteroidDirection: -as1.asteroidDirection.x : as1.asteroidDirection.y];
	 [as1 setAsteroidDirection: as1.asteroidDirection.x : -as1.asteroidDirection.y];
	 [as2 setAsteroidDirection: -as2.asteroidDirection.x : as2.asteroidDirection.y];
	 [as2 setAsteroidDirection: as2.asteroidDirection.x : -as2.asteroidDirection.y];
	 */
	
	
}

// handles the asteroid collision scenarios
-(void) asteroidCollision: (int) asteroidIndex {
	
	// sound an explosion
	[sound playAsteroidExplosion];
	
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
	int score = [UIAppDelegate.currentUser.score score];
	
	// update the feedback label
	[feedbackLabel setTextColor:[UIColor greenColor]];
	[self updateFeedbackLabelTo: @"Correct!"];
	[self beginFeedbackAnimation];
	
	// update the scoreboard 
	score = score + CORRECT_ANSWER_REWARD;
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", score ];
	[scoreLabel setText: inputString];
	[inputString release];
	
	// update the location of the asteroid to a random point on the screen
	[[asteroids objectAtIndex: index] setAsteroidPosition: (arc4random() % 460) : (arc4random() % 320)];
	
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
	
	// update the feedback label
	[feedbackLabel setTextColor:[UIColor redColor]];
	[self updateFeedbackLabelTo: @"Incorrect!"];
	[self beginFeedbackAnimation];
	
	// decrement score by incorrect penalty and update the scoreboard
	score = score - INCORRECT_ANSWER_PENALTY;
	NSString *inputString = [[NSString alloc] initWithFormat: @"Score: %d", score ];
	[scoreLabel setText: inputString];
	[inputString release];
	
	// update the location of the asteroid to a random point on the screen
	[[asteroids objectAtIndex: index] setAsteroidPosition: (arc4random() % 460) : (arc4random() % 320)];
	
	[UIAppDelegate.currentUser.score setScore: score];
	
	// check if game is over
	[self checkScore];
	
	// set the next question
	[self setQuestion];
}

// hit a blank asteroid
-(void) hitBlankAsteroid:(int)index {
	
	NSLog(@"hit blank asteroid.");
	
	int score = [UIAppDelegate.currentUser.score score];
	
	// increase score by 1 and update the scoreboard
	score = score + BLANK_REWARD;
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", score ];
	[scoreLabel setText:inputString];
	[inputString release];
	
	// update the location of the asteroid to a random point on the screen
	[[asteroids objectAtIndex: index] setAsteroidPosition: (arc4random() % 460) : (arc4random() % 320)];
	
	[UIAppDelegate.currentUser.score setScore: score];
	
	// check if game is over
	[self checkScore];
}

// raise the difficulty if the user reached the limit and as long as it's not already on hardest
// if it's lower than 0 then the game is over (lose scenario)
// if it's over the limit of the hardest difficulty then the game is over (win scenario)
-(void) checkScore {
	
	int diff = [UIAppDelegate.currentUser.currentTopic difficulty];
	int score = [UIAppDelegate.currentUser.score score];
	
	// if the current score is higher than highestScore, update the AppDelegate profile.
	if (score > [UIAppDelegate.currentUser.highestScore score]) {
		
		NSLog(@"saving highest score : %d", score);
		[UIAppDelegate.currentUser.highestScore setScore: score];
	}
	
	// if current topic is higher than lastTopicCompleted (highest topic achieved yet) then update the AppDelegate profile.
	if (UIAppDelegate.currentUser.currentTopic.topic > UIAppDelegate.currentUser.lastTopicCompleted.topic) {
		
		[UIAppDelegate.currentUser setLastTopicCompleted: UIAppDelegate.currentUser.currentTopic];
		
		// and save settings
		[GlobalAdmin saveSettings];
	}
	
	// if score is higher than set limit for difficulty, then raise the difficulty
	if (score > DIFFICULTY_LIMIT * diff && diff < DIFFICULTY_HARDEST) {
		
		// raise difficulty by one
		[[UIAppDelegate.currentUser currentTopic] setDifficulty: diff + 1];
		
		// and save settings
		[GlobalAdmin saveSettings];
		
		
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
		[self loseScenario];
	}
	
	// if the current topic is the highest we've done so far, update the highest difficulty.
	if ([UIAppDelegate.currentUser.currentTopic topic] == [UIAppDelegate.currentUser.lastTopicCompleted topic] &&
		diff > [UIAppDelegate.currentUser.lastTopicCompleted difficulty]) {
		
		// then update the highestDifficulty in the AppDelegate profile
		[UIAppDelegate.currentUser.lastTopicCompleted setDifficulty: diff];
		
		// save settings
		[GlobalAdmin saveSettings];
	}
	
	// if the score is higher than the set limit for topic
	if (score > DIFFICULTY_HARDEST * DIFFICULTY_LIMIT) {
		
		// if we haven't yet exhaused all our topics, progress to the next topic
		if ([UIAppDelegate.currentUser.currentTopic nextTopic]) {
			
			// update the profile's lastTopicCompleted if this one is higher
			if (UIAppDelegate.currentUser.currentTopic.topic > UIAppDelegate.currentUser.lastTopicCompleted.topic) {
				
				[UIAppDelegate.currentUser setLastTopicCompleted: UIAppDelegate.currentUser.currentTopic];
			}
			else {};	// avoid nested ambiguities.
			
			// save settings
			[GlobalAdmin saveSettings];
			
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
}

// update the score label to the current score value
-(void) updateScoreLabel {
	
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", [UIAppDelegate.currentUser.score score]];
	[scoreLabel setText:inputString];
	[inputString release];
}

// begin lose scenario
-(void) loseScenario {
	
	// first save settings to plist
	[GlobalAdmin saveSettings];
	
	// reset score, shield and lives
	[self resetValues];
	
	[self nextScreen];
}

// begin win scenario
-(void) winScenario {
	
	// first save settings to plist
	[GlobalAdmin saveSettings];
	
	[self nextScreen];
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
