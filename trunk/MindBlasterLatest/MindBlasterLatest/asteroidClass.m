//
//  asteroidClass.m
//  MindBlaster
//
//  Created by Steven Verner on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "asteroidClass.h"


@implementation asteroidClass

-(void)setAsteroidDirection:(int)x:(int)y;
{
	asteroidDirection = CGPointMake(x,y);

}
-(CGPoint)getAsteroidDirection;
{
	return asteroidDirection;
}
-(void)setAsteroidType:(int)type;
{
	asteroidType = type;
}

-(int)getAsteroidType;
{
	return asteroidType;
}

@end

