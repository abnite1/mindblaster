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

@synthesize asteroidType,asteroidDirection, asteroidIcon, asteroidLabel, asteroidPosition, asteroidSize, asteroidSpeed;

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
	
	//NSLog(@"end of initWIthElements");
    return self;
	
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
-(void)setAsteroidDirection:(int)x :(int)y;
{
	asteroidDirection = CGPointMake(x,y);
}

// change position of all asteroid elements to a specified point
-(void)setAsteroidPosition:(int)x :(int)y;
{
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
	//[self bounceOffBoundaries];
	[self phaseToOtherSide];
		
	//NSLog(@"end of move");	
}

// bounce the asteroid off the walls
-(void) bounceOffBoundaries {
	
	// if it hits the side of the screen
	if( (asteroidIcon.center.x > 480 -asteroidSize.x / 2 && (asteroidDirection.x > 0) )
	   || ( asteroidIcon.center.x < (0 +asteroidSize.x / 2)   && (asteroidDirection.x < 0)) )
	{
		// invert the x direction
		[self setAsteroidDirection: -asteroidDirection.x :asteroidDirection.y];
	}
	
	// if it hits the top or bottom
	if( (asteroidIcon.center.y > 293 -asteroidSize.y / 2  && asteroidDirection.y > 0)
	   || (  asteroidIcon.center.y < (0 + asteroidSize.y / 2)  && asteroidDirection.y < 0) )
	{
		// invert the y direction
		[self setAsteroidDirection: asteroidDirection.x : -asteroidDirection.y];
	}
}

// asteroids phase to the other side of the screen when they hit the borders
-(void) phaseToOtherSide {
	
	// if it hits the right side of the screen
	if( asteroidPosition.x  > 480 + ASTEROID_SIZE_X ) {
		
		// change the x position to the other side of screen
		[self setAsteroidPosition: -ASTEROID_SIZE_X + 1 : asteroidPosition.y];
	}
	
	// if it hits the left side of the screen
	if ( asteroidPosition.x < 0 - ASTEROID_SIZE_X ) {
		
		// change the x position to the other side of screen
		[self setAsteroidPosition: 480 + ASTEROID_SIZE_X - 1 : asteroidPosition.y];	
	}
	
	// if it hits the upper side of the screen
	if( asteroidPosition.y  > 320 + ASTEROID_SIZE_Y ) {
		
		// change the x position to the other side of screen
		[self setAsteroidPosition: asteroidPosition.x : 0 - ASTEROID_SIZE_Y + 1 ];
	}
	
	// if it hits the bottom side of the screen
	if ( asteroidPosition.y < 0 - ASTEROID_SIZE_Y ) {
		
		// change the x position to the other side of screen
		[self setAsteroidPosition: asteroidPosition.x : 320 + ASTEROID_SIZE_Y -1];	
	}
}

// deallocate objects

-(void) dealloc {
	[asteroidIcon release];
	[asteroidLabel release];
	[super dealloc];
}
@end

