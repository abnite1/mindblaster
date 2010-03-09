//
//  Ball.h
//  MindBlaster
//
//  Created by John Kehler on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ball : UIImageView {
	int mXSpeed;
	int mYSpeed;
	float mAngle;
}

-(void)move;
-(void)setSpeedX:(int)xSpeed Y:(int)ySpeed;

@end
