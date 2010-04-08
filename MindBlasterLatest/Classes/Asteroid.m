//
//  Asteroid.m
//  MindBlaster
//
//  Created by Steven Verner on 3/7/10.
//  Recreated by yaniv haramati on 12/3/10
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//

#import "Asteroid.h"
#import "MindBlasterAppDelegate.h"

@implementation Asteroid

@synthesize asteroidType,asteroidDirection, asteroidIcon, asteroidLabel, asteroidPosition, asteroidSize, asteroidSpeed, animatedExplosion;

// constructor with copied icons and labels
- (id)initWithElements:(UIImageView*)icon :(UILabel*)label {
	
    if ( self = [super init] ) {
		
        asteroidIcon = icon;
		asteroidLabel = label;
		//int x = icon.center.x;
		//int y = icon.center.y;
		//randomize the starting locations. //jkehler
			int x=460/2;
			int y=320/2;
			while(x > 100 && x < 360){
				x=arc4random()%460;
			}
			while(y > 100 && y < 220){
				y=arc4random()%320;
			}
			//[[asteroids objectAtIndex:index] setAsteroidPosition:xloc: yloc];
			//[[asteroids objectAtIndex:i] setAsteroidPosition:x:y];//reset all the asteroid positions.
			[self setAsteroidPosition: x : y];
		
		
		//NSLog(@"inside the asteroid initWIthElements constructor");
	//	[self setAsteroidPosition: x : y];
    }
	
	mAngle = 0.0f;
	
	//NSLog(@"end of initWIthElements");
    return self;
	
}

- (void)initWithElementsUnitTest:(UIImageView*)icon :(UILabel*)label {
	
	asteroidIcon = nil;
	asteroidLabel = nil;
	BOOL unitTestPassed = TRUE;
	if(icon==nil || label == nil)
		NSLog(@"UNIT TEST FAILED; class: Asteroid; function initWithElements; unit passed a nil UIImageView icon or UIILabel label");
	else
	{
		[self initWithElements:icon :label];
		if(asteroidIcon ==nil)
		{
			NSLog(@"UNIT TEST FAILED; class: Asteroid; function initWithElements; asteroidIcon not set");			
			unitTestPassed = FALSE;
		}
		if(asteroidLabel = nil)
		{
			NSLog(@"UNIT TEST FAILED; class: Asteroid; function initWithElements; asteroidLabel not set");			
			unitTestPassed = FALSE;
		}	

		if(unitTestPassed == TRUE)
			NSLog(@"UNIT TEST PASSED; class: Asteroid; function initWithElements");
	}
}

// begin an explosion animation at this location
-(void) beginExplosionAnimation: (CGPoint)location {
	
	
	
}

// standard constructor sets the asteroid png and size
/*
-(id) init {
	
	if ( self = [super init] ) {
		
		//asteroidIcon = [[UIImageView alloc] initWithImage: @"asteroid6.png"];
		//asteroidLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 1.0, 1.0)];
		//[self setAsteroidPosition: CGPointMake(450 - random() % 300, 250 - random() % 100)];
		//[self move];
		
	}
	return self;
}
 */


// change asteroid direction
//-(void)setAsteroidDirection:(int)x :(int)y {
-(void)setAsteroidDirection:(float)x : (float)y {
	
	asteroidDirection = CGPointMake(x,y);
}

-(void)setAsteroidDirectionUnitTest{
	
	BOOL unitTestPassed =TRUE;
	
	[self setAsteroidDirection:4:6];
	if(asteroidDirection.x != 4 && asteroidDirection.y != 6)
	{
		NSLog(@"UNIT TEST FAILED; class: Asteroid; function setAsteroidDirection; asteroidDirection not set correctly");			
		unitTestPassed = FALSE;
	}	
	[self setAsteroidDirection:-2:-5];
	if(asteroidDirection.x != -2 && asteroidDirection.y != -5)
	{
		NSLog(@"UNIT TEST FAILED; class: Asteroid; function setAsteroidDirection; asteroidDirection not set correctly");			
		unitTestPassed = FALSE;
	}	
	
	if(unitTestPassed == TRUE)
		NSLog(@"UNIT TEST PASSED; class: Asteroid; function setAsteroidDirection");
}

// change position of all asteroid elements to a specified point
-(void)setAsteroidPosition:(int)x :(int)y {
	CGPoint newPosition = CGPointMake(x,y);
	
	// set position
	asteroidPosition = newPosition;
	
	// move label
	[asteroidLabel setCenter: newPosition];
	
	// move icon
	[asteroidIcon setCenter: newPosition];
	
	//sets the initial movement vectors
	if ( asteroidDirection.x == 0 || asteroidDirection.y == 0 ){
		int xdir=0;
		int ydir=0;
		/*while(xdir == 0){
			xdir = arc4random()%ASTEROID_SPEED_FACTOR;
			if(arc4random()%3 < 2)//50% of the time will swap direction
				xdir*=-1;
		}*/
		
		//set a random xdirection between -5 and 5 not including 0.
		xdir = arc4random()%3 + 1;
		if(arc4random()%3<2)//50% chance to reverse direction.
			xdir*=-1;
		
	/*	while(ydir == 0 || ydir == xdir){ //second condition to reduce number of 45deg angles, too many of those head straight for ship.
			ydir = arc4random()%ASTEROID_SPEED_FACTOR;
			if(arc4random()%2 < 2)//50% of the time will swap direction
				ydir*=-1;
		}*/
		ydir = arc4random()%3 + 1;
		if(arc4random()%3<2)
			ydir*=-1;
		
		//BONUS SPEED OPTION AFTER YOU WIN, keep laying at increasing speed.
		if(UIAppDelegate.bonusSpeedGameEnable > 0){
				//speed up asteroids.
			ydir*=UIAppDelegate.bonusSpeedGameEnable;
			xdir*=UIAppDelegate.bonusSpeedGameEnable;
			[UIAppDelegate setBonusSpeedGameEnable:UIAppDelegate.bonusSpeedGameEnable + 1];
		}
		
		NSLog(@"x: %f, y: %f\n",xdir, ydir);
		[self setAsteroidDirection:xdir :ydir];
	//	NSLog(@"x: %f, y: %f\n",((float)(arc4random() %30 )) / 10  -1, ((float)(arc4random() %30 )) / 10  -1);
		//[self setAsteroidDirection:(((float)(arc4random() %30 )) / 10  -1) :(((float)(arc4random() % 30)) / 10 -1)];
		//[self setAsteroidDirection:((float)(arc4random()%30))/6 - 4
		//[self setAsteroidDirection:((arc4random()%(ASTEROID_SPEED_FACTOR*2))/(arc4random()%(ASTEROID_SPEED_FACTOR))):((arc4random()%(ASTEROID_SPEED_FACTOR*2))/(arc4random()%ASTEROID_SPEED_FACTOR))];
		//[self setAsteroidDirection:(((float)(arc4random()%30))/ASTEROID_SPEED_FACTOR + 0.2):(((float)(arc4random()%30))/ASTEROID_SPEED_FACTOR) + 0.2];
	}
		
}

// moves the asteroid along its direction vector
-(IBAction) move {
	//NSLog(@"beginning of move");
	
	// define the new target point
	CGPoint newPosition = CGPointMake(asteroidPosition.x + asteroidDirection.x, 
										  asteroidPosition.y + asteroidDirection.y);
		
	// move the icon and the label
	[self setAsteroidPosition: newPosition.x :newPosition.y];
		
	asteroidIcon.center = CGPointMake(asteroidPosition.x + asteroidDirection.x, 
									  asteroidPosition.y + asteroidDirection.y);
	asteroidLabel.center = CGPointMake(asteroidPosition.x + asteroidDirection.x, 
									  asteroidPosition.y + asteroidDirection.y);
	
	// rotate the icon
	asteroidIcon.transform=CGAffineTransformMakeRotation (mAngle);
	mAngle += ROTATION_COEFFICIENT;
	
	//[self bounceOffBoundaries];
	[self phaseToOtherSide];
		
	//NSLog(@"end of move");	
}
-(void) moveUnitTest {
	[self move];
	CGPoint tempAsteroidPoint = asteroidIcon.center ;
	CGPoint tempLabelCenter = asteroidLabel.center ;
	asteroidDirection.x = 2;
	asteroidDirection.y = 3;
	
	[self move];
	
	if( tempLabelCenter.x != (asteroidLabel.center.x -2) || tempAsteroidPoint.x!=(asteroidIcon.center.x -3) )
		NSLog(@"UNIT TEST PASSED; class: Asteroid; function move");	
	else
		NSLog(@"UNIT TEST FAILED; class: Asteroid; function move; asteroidLabel or asteroidIcon did not move correctly " );	
		
	
}
// bounce the asteroid off the walls
-(void) bounceOffBoundaries {
	
	// because we're always using the wideview
	int screenWidth = [[UIScreen mainScreen] bounds].size.height;
	int screenHeight = [[UIScreen mainScreen] bounds].size.width;
	
	// if it hits the side of the screen
	if( (asteroidIcon.center.x > screenWidth -asteroidSize.x / 2 && (asteroidDirection.x > 0) )
	   || ( asteroidIcon.center.x < (0 +asteroidSize.x / 2)   && (asteroidDirection.x < 0)) )
	{
		// invert the x direction
		[self setAsteroidDirection: -asteroidDirection.x :asteroidDirection.y];
	}
	
	// if it hits the top or bottom
	if( (asteroidIcon.center.y > screenHeight -asteroidSize.y / 2  && asteroidDirection.y > 0)
	   || (  asteroidIcon.center.y < (0 + asteroidSize.y / 2)  && asteroidDirection.y < 0) )
	{
		// invert the y direction
		[self setAsteroidDirection: asteroidDirection.x : -asteroidDirection.y];
	}
}

// asteroids phase to the other side of the screen when they hit the borders
-(void) phaseToOtherSide {
	
	// because we're always using the wide view
	int screenWidth = [[UIScreen mainScreen] bounds].size.height;
	int screenHeight = [[UIScreen mainScreen] bounds].size.width;
	
	// if it hits the right side of the screen //jkehler
	if( asteroidPosition.x  > screenWidth /*+ asteroidIcon.bounds.size.width*/ ) {
		
		// change the x position to the other side of screen
		[self setAsteroidPosition: /*-asteroidIcon.bounds.size.width +*/ 1 : asteroidPosition.y];
	}
	
	// if it hits the left side of the screen
	if ( asteroidPosition.x < 0 /*- asteroidIcon.bounds.size.width*/ ) {
		
		// change the x position to the other side of screen
		[self setAsteroidPosition: screenWidth /*+ asteroidIcon.bounds.size.width - 1*/ : asteroidPosition.y];	
	}
	
	// if it hits the upper side of the screen
	if( asteroidPosition.y  > screenHeight /*+ asteroidIcon.bounds.size.height*/ ) {
		
		// change the x position to the other side of screen
		[self setAsteroidPosition: asteroidPosition.x : 0 /*- asteroidIcon.bounds.size.height + 1*/ ];
	}
	
	// if it hits the bottom side of the screen
	if ( asteroidPosition.y < 0 /*- asteroidIcon.bounds.size.height*/ ) {
		
		// change the x position to the other side of screen
		[self setAsteroidPosition: asteroidPosition.x : screenHeight /*+ asteroidIcon.bounds.size.height -1*/];	
	}
}

// deallocate objects

-(void) dealloc {
	[asteroidIcon release];
	[asteroidLabel release];
	[super dealloc];
}
@end

