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


@implementation Asteroid

@synthesize asteroidType,asteroidDirection, asteroidIcon, asteroidLabel, asteroidPosition, asteroidSize, asteroidSpeed, animatedExplosion;

// constructor with copied icons and labels
- (id)initWithElements:(UIImageView*)icon :(UILabel*)label {
	
    if ( self = [super init] ) {
		
        asteroidIcon = icon;
		asteroidLabel = label;
		int x = icon.center.x;
		int y = icon.center.y;
		//NSLog(@"inside the asteroid initWIthElements constructor");
		[self setAsteroidPosition: x : y];
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
-(void)setAsteroidDirection:(int)x :(int)y {
	
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
	if ( asteroidDirection.x == 0 || asteroidDirection.y == 0 )
		[self setAsteroidDirection:((arc4random() %30 ) / 5  -3) :((arc4random() % 30) / 5 -3)];
		
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

