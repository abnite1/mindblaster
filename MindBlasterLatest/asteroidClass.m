//
//  asteroidClass.m
//  MindBlaster
//
//  Created by Steven Verner on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//

#import "asteroidClass.h"


@implementation asteroidClass

@synthesize asteroidType, asteroidDirection;


-(void)setAsteroidDirection:(int)x :(int)y;
{
	asteroidDirection = CGPointMake(x,y);
}



@end

