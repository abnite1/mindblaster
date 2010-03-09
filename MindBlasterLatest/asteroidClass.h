//
//  asteroidClass.h
//  MindBlaster
//
//  Created by Steven Verner on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface asteroidClass : NSObject {


	int		asteroidType;			//0 represents the correct solution asteroid, 1 means its an incorrect solution asteroid and 2 means its a blank asteroid
	CGPoint asteroidDirection;  //direction of the asteroid's movement
}

@property (nonatomic) int asteroidType;
@property (nonatomic) CGPoint asteroidDirection;


-(void)setAsteroidDirection:(int)x:(int)y;


@end



