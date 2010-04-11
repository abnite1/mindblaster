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

//this function is unit tested visually as visual confirmation is needed that the ship icon is rotating
//the compiler cannot verify this
-(void) rotate: (CGFloat)angle {
	
	bulletIcon.transform = CGAffineTransformMakeRotation(angle);
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
-(void) moveUnitTest {
	
	[self move];
	CGPoint tempBulletPoint = bulletIcon.center ;
	
	bulletDirection.x = 2;
	bulletDirection.y = 3;
	
	[self move];
	
	if( tempBulletPoint.x != (bulletIcon.center.x -2) || tempBulletPoint.x!=(bulletIcon.center.x -3) )
		NSLog(@"UNIT TEST PASSED; class: Bullet; function move");	
	else
		NSLog(@"UNIT TEST FAILED; class: Bullet; function move; bulletIcon did not move correctly " );	
	
	
}
@end
