//
//  Bullet.m
//  MindBlaster
//
//  Created by yaniv haramati on 19/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"


@implementation Bullet

@synthesize bulletIcon, bulletPosition, bulletDirection;

// set the bullet position
-(void)setBulletPosition:(int)x :(int)y {
	
	
	CGPoint newPosition = CGPointMake(x,y);
	
	// set position
	bulletPosition = newPosition;
	
	// move icon
	[bulletIcon setCenter: newPosition];
	
}

// set the bullet direction vector
-(void)setBulletDirection:(int)x :(int)y {
	
	bulletDirection = CGPointMake(x,y);
}

// move the bullet in a straight path along its direction vector
-(IBAction)move {
	
	// define the new target point
	CGPoint newPosition = CGPointMake(bulletPosition.x + bulletDirection.x, 
									  bulletPosition.y + bulletDirection.y);
	
	// move the icon and the label
	[self setBulletPosition: newPosition.x :newPosition.y];
	
	bulletIcon.center = CGPointMake(bulletPosition.x + bulletDirection.x, 
									  bulletPosition.y + bulletDirection.y);

}

@end
