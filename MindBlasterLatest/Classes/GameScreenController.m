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

@synthesize background, profilePic, difficultyLabel;

@synthesize shipIcon, ship;
@synthesize asteroid0, asteroid1, asteroid2, asteroid3, asteroid4, asteroid5, asteroid6, asteroid7, asteroid8, asteroid9;
//@synthesize asteroidIcons;  //this is the vector which will hold all of the above asteroid objects

@synthesize rotationBall;

@synthesize bullet0, bullet1, bullet2, bullet3, bullet4, bullet5;
//@synthesize bullets; //this is the vector which will hold all of the above bullet objects

@synthesize question, questionLabel, scoreLabel;
@synthesize solutionLabel0,solutionLabel1,solutionLabel2,solutionLabel3,solutionLabel4,solutionLabel5;
//@synthesize solutionLabels; //this is the vector which will hold all of the above solution objects


// animate the space background
-(void)animateBackground
{
	[background move];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"started viewDidLoad");
		
	asteroidIcons = [[NSMutableArray alloc] initWithObjects: asteroid0, asteroid1, asteroid2, asteroid3,
					 asteroid4, asteroid5, asteroid6, asteroid7, asteroid8, asteroid9,nil];
	NSLog(@"allocated asteroidIcons");

	solutionLabels  = [[NSMutableArray alloc] initWithObjects: solutionLabel0, solutionLabel1, solutionLabel2, 
									 solutionLabel3, solutionLabel4, solutionLabel5, nil];
	
	asteroids = [[NSMutableArray alloc] init];
	
	NSLog(@"allocated solutionLabels");
	// set the gamescreen label for the selected difficulty
	[self setDifficultyLabel];
	
	// create a temp object for the initialization
	Asteroid *asteroid;

	NSLog(@"allocated asteroids");
	
	// for all 6 correct/incorrect solution asteroids in the array, attach an image andd a label

	for (int i = 0; i < 10; i++) {
		
		if (i < 6) {
			
			// for the first 6 asteroids attach an image and a label
			[asteroids addObject: [[Asteroid alloc] initWithElements: 
											 [asteroidIcons objectAtIndex: i]: 
											 [solutionLabels objectAtIndex: i]]];
		}
	
		// for all remaining 4 blank asteroids in the array, attach an image but no label
		else {
			NSLog(@"allocating non labled asteroids");
			asteroid = [[Asteroid alloc] init];
			[asteroid setAsteroidIcon: [asteroidIcons objectAtIndex: i]];
			[asteroid setAsteroidSize: CGPointMake(ASTEROID_SIZE_X,ASTEROID_SIZE_Y)];
			[asteroids addObject: asteroid];
			//[asteroid release];
		}
	}
	

	for (int i = 0; i < 10; i++) {
		int x = [[asteroids objectAtIndex: i] asteroidPosition].x;
		NSLog(@"class at index %d : %f", i, x);
	}
	
	

 
	bullets = [[NSMutableArray alloc] initWithObjects: bullet0,bullet1,bullet2,bullet3,bullet4,bullet5,nil];
	
	
	// reset the position of the bullets to be offscreen
	[self initializeBulletPosition];
	

	//load the profile pic!
	[profilePic setImage:[UIAppDelegate.currentUser profilePic] forState:0];
	//[temp setImage:[(UIAppDelegate.currentUser) getPic] forState:0];

	
	[NSTimer scheduledTimerWithTimeInterval:0.001 target:self
									   selector:@selector(animateBackground) userInfo:nil repeats:YES];
	[background setSpeedX:0.09 Y:0.09];
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	//[background move];
	
	
	// create game objects
	ship = [[Ship alloc] init];				// create the ship object
	[ship setIcon: shipIcon];				// connect the ship icon to the Ship object so it can be rotated
	
	// move everything.
	[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];

	[self setQuestion];						// set the initial question
	NSLog(@"after question");
	
	// set the score initially to 0
	score = 0;  
	
	//values used to describe the direction the ship is facing, derived from the rotation wheel
	shipDirectionX = 0;  
	shipDirectionY = -15;
	//NSLog(@"Post load:   shipX = %f,   shipY = %f", shipDirectionX, shipDirectionY);
	
	//incrementor which denotes the next bullet to be fired, the 0th bullet is fired first
	bulletsFired = 0;
		
    [super viewDidLoad];
}

// sets the initial location of bullets on screen
-(void)initializeBulletPosition {

	NSLog(@"starting initializeBulletPosition");
	UIImageView *tempBullet;  //temperary UIImageView allows manipulation of the elements of the bullets array
	for(int i = 0; i < 6;  i++)
	{
		tempBullet = [bullets objectAtIndex:i];
		tempBullet.center = CGPointMake(0,500); //set all bullets starting location as off-screen so they don't destroy any asteroids yet
	}
	
	NSLog(@"finished initializeBulletPosition");
}


// handle bullet animation and interaction with asteroids
-(IBAction) fireButton{
	UIImageView *tempBullet; //temperary UIImageView allows manipulation of the elements of the asteroids array
	
	tempBullet = [bullets objectAtIndex:bulletsFired]; 
	//assigns element of bullets array to tempBullet to allow manipulation of that element
	
	//sets the bullet being fired's movement vector to the vector defined by the direction in which the ship is pointing
	bulletPos[bulletsFired] = CGPointMake(shipDirectionX,shipDirectionY); 

	tempBullet.center = CGPointMake(242,167);
	tempBullet.hidden = NO; 
	
	if(bulletsFired == 5)   //there are only six bullets so once all 6 have been fired start at 0 again
		bulletsFired = 0;
	else
		bulletsFired++;
}

// sets the label for the question according to the profile settings
-(IBAction) setQuestion {
	
	NSLog(@"starting setQuestion");
	question = [[Question alloc] init];						// create a new question object
	question.questionLabelOutletPointer = questionLabel;	// connect the local outlet to the object outlet

	//set the question on the screen
	NSLog(@"Calling SetQuestion for question class\n");
	[question setQuestion];

	// set the answers on the asteroid labels
	NSLog(@"Calling setAnswer on self, next function\n");
	[self setAnswer];
	//[question release];
}

// sets the answers on the asteroid labels
-(void)setAnswer {
	
	// define the solution set of labels on asteroids
	NSLog(@"starting setAnswer");	
		 
	// determine the correct_answer asteroid randomly and set its value and type
	int randomCorrectAsteroid = arc4random() % 5;	 // from 0 to 5
	NSString *inputString = [[NSString alloc] initWithFormat:@"%d",(int)[question answer]];
	[[[asteroids objectAtIndex: randomCorrectAsteroid] asteroidLabel] setText: inputString];
		

	// set asteroid type
	[[asteroids objectAtIndex: randomCorrectAsteroid] setAsteroidType:CORRECT_ASTEROID];
	[inputString release];
				
	NSLog(@"inside setAnswer and random correct asteroid index is : %d", randomCorrectAsteroid);
	
	// sort through the incorrect_answer asteroids and set their value and type and direction
	for(int asteroidIndex = 0; asteroidIndex < 6; asteroidIndex++)
	{
		if (asteroidIndex != randomCorrectAsteroid) {
			
			// set wrong answer equal to some random value of + [1-7] from the correct answer

			// that isn't the correct answer
			int wrongAnswer = 0;
			do {
					wrongAnswer = [question answer] + (arc4random() % 7 * pow(-1, (int)(arc4random() % 7)));
			} while (wrongAnswer == [question answer]);
			NSString *inputString = [[NSString alloc] initWithFormat:@"%d",wrongAnswer];
			[[[asteroids objectAtIndex: asteroidIndex] asteroidLabel] setText: inputString];
			
			// and set the incorrect type
			[[asteroids objectAtIndex: asteroidIndex] setAsteroidType:INCORRECT_ASTEROID];
			
			// then send it on a random path
			[[asteroids objectAtIndex: asteroidIndex] 
			 setAsteroidDirection:((arc4random() %30 ) / 5  -3) :((arc4random() % 30) / 5 -3)];
			[inputString release];
			//[[asteroids objectAtIndex: asteroidIndex] move];
		}
	}

	
	// set the blank type on a random path
	for (int asteroidIndex = 6; asteroidIndex < 10; asteroidIndex++) {
		
		[[asteroids objectAtIndex: asteroidIndex] setAsteroidType:BLANK_ASTEROID];
		[[asteroids objectAtIndex: asteroidIndex] 
				setAsteroidDirection:((arc4random() %30 ) / 5  -3) :((arc4random() % 30) / 5 -3)];
		[[asteroids objectAtIndex: asteroidIndex] move];
	}
	NSLog(@"end of answer");
}

// updates the difficulty label to the current difficulty in the user profile
-(IBAction) setDifficultyLabel {
	NSLog(@"start setDifficultyLabel");
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
	NSLog(@"finished setDifficultyLabel");
	
}

// this function is the general animation selector for gamescreen, 
// which updates the screen frequently as defined in the caller object
-(void) onTimer {


	UIImageView *tempBullet;

	
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
		tempBullet.center = CGPointMake(tempBullet.center.x+bulletPos[bulletIndex].x,
										tempBullet.center.y+bulletPos[bulletIndex].y);
		
		//if bullet is off-screen then destroy the bullet by setting its movement to 0 and setting its location to 0,500, far off screen,
		//and finally hiding the bullet
		if( (tempBullet.center.x > 486 )|| ( tempBullet.center.x < -6 ) 
		   || (tempBullet.center.y > 300 ) || ( tempBullet.center.y < -6 ))
		{
			bulletPos[bulletIndex].x = 0;
			bulletPos[bulletIndex].y = 0;
			
			tempBullet.center = CGPointMake(0,500);
			tempBullet.hidden = YES;
		}
		
		//for every asteroid (10 asteroids) check for collision with the bullet
		for( int asteroidIndex = 0; asteroidIndex < 10; asteroidIndex++)
		{
			
			//if there is a collision then destroy both asteroid and bullet, hide the bullet and move it off screen and
			//move the asteroid to just above and to the left of the screen so it can move back into the screen area
			//as a new asteroid
			
			// if we collide with ANY of the 10 asteroids
			if(  ((tempBullet.center.x < [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].center.x + 20 ) 
				  && (tempBullet.center.x > [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].center.x - 20))
			     &&((tempBullet.center.y < [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].center.y + 20) 
					&& (tempBullet.center.y > [[asteroids objectAtIndex: asteroidIndex] asteroidIcon].center.y - 20)) )
			{
				NSLog(@"asteroid position: %f",[[asteroids objectAtIndex:asteroidIndex]asteroidIcon].center.x);
				NSLog(@"bullet position: %f", tempBullet.center.x);
				
				// destroy asteroid and bullet by hiding them off screen
				[[asteroids objectAtIndex: asteroidIndex] setAsteroidPosition: CGPointMake(-10,-10)];
				tempBullet.center = CGPointMake(0,500);
				tempBullet.hidden = YES;
				bulletPos[bulletIndex] = CGPointMake(0,0);
			}
			// if we have no collision, check the next bullet.
			else continue;
				
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
			
			// no need to check the other asteroids if we made a hit.
			break;
		}
	}
}
					

// what to do when a bullet collides with the correct_answer asteroid
-(void) hitCorrectAsteroid: (int) index {
	
	NSLog(@"hit correct asteroid.");
	
	// update the scoreboard 
	score = score + CORRECT_ANSWER_REWARD;
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", score ];
	[scoreLabel setText: inputString];
	[inputString release];
	
	// check if gameover
	[self checkScore];
	
	// reset question and asteroid labels
	[self setQuestion];
}

// hit wrong asteroid
-(void) hitWrongAsteroid:(int)index {
	
	NSLog(@"hit incorrect asteroid.");
	
	// decrement score by 2 and update the scoreboard
	score = score - INCORRECT_ANSWER_PENALTY;
	NSString *inputString = [[NSString alloc] initWithFormat: @"Score: %d", score ];
	[scoreLabel setText: inputString];
	[inputString release];
	
	// check if game is over
	[self checkScore];
	
	// set the next question
	[self setQuestion];
}

// hit a blank asteroid
-(void) hitBlankAsteroid:(int)index {
	NSLog(@"hit blank asteroid.");
	
	// increase score by 1 and update the scoreboard
	score = score + BLANK_REWARD;
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", score ];
	[scoreLabel setText:inputString];
	[inputString release];
	
	// update the location of the asteroid to a random point on the screen
	[[asteroids objectAtIndex: index] setAsteroidPosition: (arc4random() % 500 - 50) : (arc4random() % 300 - 20)];
	
	// check if game is over
	[self checkScore];
}

// raise the difficulty if the user reached the limit and as long as it's not already on hardest
// if it's lower than 0 then the game is over (lose scenario)
// if it's over the limit of the hardest difficulty then the game is over (win scenario)
-(void) checkScore {
	
	//int diff = [UIAppDelegate.currentUser currentDifficulty];
	int diff = [[UIAppDelegate.currentUser currentTopic] difficulty];
	
	// update the profile's lastTopicCompleted if this one is higher
	if (UIAppDelegate.currentUser.currentTopic.topic > UIAppDelegate.currentUser.lastTopicCompleted.topic) {
		
		[UIAppDelegate.currentUser setLastTopicCompleted: UIAppDelegate.currentUser.currentTopic];
	}
	
	// if score is higher than set for difficulty, then raise the difficulty
	if (score > DIFFICULTY_LIMIT * diff && diff < DIFFICULTY_HARDEST) {
		//[UIAppDelegate.currentUser setCurrentDifficulty: diff + 1];
		[[UIAppDelegate.currentUser currentTopic] setDifficulty: diff + 1];
		
		// reset the label
		[self setDifficultyLabel];
	}
	
	// if negative score, game is over (lose)
	if (score < 0 ) {

		// reset the score
		score = 0;
		[self updateScoreLabel];

		
		// initiate lose scenario
		[self loseScenario];
	}
	
	// if score is over the max limit, game is over (win)
	if (score > DIFFICULTY_HARDEST * DIFFICULTY_LIMIT) {
		
		// if we haven't yet exhaused all our topics, progress to the next topic
		if ([UIAppDelegate.currentUser.currentTopic nextTopic]) {
			
			// update the profile's lastTopicCompleted if this one is higher
			if (UIAppDelegate.currentUser.currentTopic.topic > UIAppDelegate.currentUser.lastTopicCompleted.topic) {
				
				[UIAppDelegate.currentUser setLastTopicCompleted: UIAppDelegate.currentUser.currentTopic];
			}
			else {};	// avoid nested ambiguities.
			
			
			// reset the score
			score = 0;
			
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
	
	NSString *inputString = [[NSString alloc] initWithFormat:@"Score: %d", score ];
	[scoreLabel setText:inputString];
	[inputString release];
}

// begin lose scenario
-(void) loseScenario {
	GameOverScreenController *gameOverScreenView = [[GameOverScreenController alloc] initWithNibName:@"GameOverScreenController" bundle:nil];
	[self.navigationController pushViewController:gameOverScreenView animated:YES];
	[gameOverScreenView release];
}

// begin win scenario
-(void) winScenario {
	GameOverScreenController *gameOverScreenView = [[GameOverScreenController alloc] initWithNibName:@"GameOverScreenController" bundle:nil];
	[self.navigationController pushViewController:gameOverScreenView animated:YES];
	[gameOverScreenView release];
}



-(IBAction) helpScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}
-(IBAction) nextScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	GameOverScreenController *gamesOverScreenView = [[GameOverScreenController alloc] initWithNibName:@"GameOverScreenController" bundle:nil];
	[self.navigationController pushViewController:gamesOverScreenView animated:YES];
	[gamesOverScreenView release];
}

/*
// rotate ship according to rotation wheel angle
-(IBAction) rotateByAngle:(CGFloat)angle {
	ship.transform = CGAffineTransformMakeRotation(angle);
}
 */


/*This function is called when a touch on the screen is first detected
 */
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	UITouch *touch = [[event allTouches] anyObject];  //records touch as touch object
    CGPoint location = [touch locationInView:touch.view]; //records touch's location
	
	double x,y;
	double radius = 24;  //radius of rotation wheel
	double radiusSquared = radius*radius; //radius squared
	double xcenter = 50; //center of rotation wheel, x coordinate
	double ycenter = 252; //center of rotation wheel, y coordinate
	
	//if location of a touch is in the area of the rotation wheel, update the 
	//rotation wheel
	if(location.x > 22 && location.x < 80 && location.y > 226 && location.y < 285) {
		
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
			y = sqrt( radiusSquared - (xcenter- location.x )*(xcenter- location.x ) ) + ycenter; 
		else
		{
			y = -sqrt( radiusSquared - (xcenter- location.x )*(xcenter- location.x ) ) + ycenter; 
		}
		
		y = (y + location.y)/2.0;
		//NSLog(@"inter2 Y: %f",y);
		
		if(location.x >= xcenter)
			x = sqrt(radiusSquared - (ycenter - y)*(ycenter - y) ) + xcenter;
		else
			x = -sqrt(radiusSquared - (ycenter - y)*(ycenter - y) ) + xcenter;
		
		//rotation ball is moved to the approximation of the closest point on the
		//rotation wheel to the point where to user actually touched the screen
		rotationBall.center = CGPointMake(x,y); 
		
		//shipDirection (used for ship rotation and firing direction) is updated
		shipDirectionX = (x - xcenter);
		shipDirectionY = (y - ycenter);
		
		
		// get the radian angle of rotation (0 <-> 2 pi) based on point of contact with the wheel	
		CGFloat rotationAngle = atan2( shipDirectionY,shipDirectionX) + M_PI_2;
		[ship rotate: rotationAngle];
		
	}
		
}
/*This function is called when a finger is dragged on the screen */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{ 
	UITouch *touch = [[event allTouches] anyObject];  //records touch as touch object
    CGPoint location = [touch locationInView:touch.view]; //records touch's location
    //NSLog(@"X: %f",location.x);
    //NSLog(@"Y: %f",location.y);
	
	
	double x,y;
	double radius = 24;  //radius of rotation wheel
	double radiusSquared = radius*radius; //radius squared
	double xcenter = 50; //center of rotation wheel, x coordinate
	double ycenter = 252; //center of rotation wheel, y coordinate
	
	//if location of a touch is in the area of the rotation wheel, update the 
	//rotation wheel
	if(location.x > 22 && location.x < 80 && location.y > 226 && location.y < 285)
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
			y = sqrt( radiusSquared - (xcenter- location.x )*(xcenter- location.x ) ) + ycenter; 
		else
		{
			y = -sqrt( radiusSquared - (xcenter- location.x )*(xcenter- location.x ) ) + ycenter; 
		}
		
		y = (y + location.y) / 2.0;
		
		if(location.x >= xcenter)
			x = sqrt(radiusSquared - (ycenter - y)*(ycenter - y) ) + xcenter;
		else
			x = -sqrt(radiusSquared - (ycenter - y)*(ycenter - y) ) + xcenter;

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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touchesEnded");
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
	[question release];
    [super dealloc];
}


@end
