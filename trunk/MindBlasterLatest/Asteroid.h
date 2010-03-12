//
//  Asteroid.h
//  MindBlaster
//
//  Created by Steven Verner on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// asteroidType constants
static const int CORRECT_ASTEROID = 0;
static const int INCORRECT_ASTEROID = 1;
static const int BLANK_ASTEROID = 2;

// asteroid size constants
static const int ASTEROID_SIZE_X = 32;
static const int ASTEROID_SIZE_Y = 30;

@interface Asteroid : NSObject {


	int		asteroidType;					// constant types defined at the top of the class
	CGPoint asteroidDirection;				// direction of the asteroid's movement
	CGPoint asteroidPosition;				// position of the asteroid
//	IBOutlet UIImageView *asteroidIcon;		// UIImage of the asteroid
	UIImageView *asteroidIcon;
	IBOutlet UILabel *asteroidLabel;		// label correct/incorret answers
	CGPoint asteroidSize;
}

@property (nonatomic) int asteroidType;
@property (nonatomic) CGPoint asteroidSize;
@property (nonatomic) CGPoint asteroidPosition;
@property (nonatomic) CGPoint asteroidDirection;
//@property (nonatomic,retain) IBOutlet UIImageView *asteroidIcon;
@property (nonatomic,retain) UIImageView *asteroidIcon;
@property (nonatomic,retain) IBOutlet UILabel *asteroidLabel;

-(id) initWithElements:(UIImageView*)icon :(UILabel*)label;
//-(id) init;
-(void)setAsteroidDirection:(int)x :(int)y;
-(void)setAsteroidPosition:(int)x :(int)y;
-(IBAction)move;
-(void)bounceOffBoundaries;
-(void)dealloc;



@end



