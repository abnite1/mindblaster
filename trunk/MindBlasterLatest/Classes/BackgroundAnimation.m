//
//  BackgroundAnimation.m
//  MindBlaster
//
//  Created by John Kehler on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BackgroundAnimation.h"

@implementation BackgroundAnimation

- (void)setSpeedX:(int)xSpeed Y:(int)ySpeed {
	
	mXSpeed=xSpeed;
	mYSpeed=ySpeed;
}

/*
 * Moves the background space animation, creating the illusion of moving through space.
 */
- (void)move {
	self.center=CGPointMake(self.center.x + mXSpeed, self.center.y + mYSpeed);
	if (!CGRectContainsRect(self.superview.frame, self.frame))
		
		self.transform=CGAffineTransformMakeRotation (mAngle);
	mAngle+=0.001;   
}
@end

