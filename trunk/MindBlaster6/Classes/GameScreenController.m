//
//  GameScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameScreenController.h"
#import "GameOverScreenController.h"
#import "HelpScreenController.h"
#import "Ball.h"
#import "MindBlasterAppDelegate.h"
#import "UserProfile.h"

@implementation GameScreenController

@synthesize ship;

@synthesize asteroid0, asteroid1, asteroid2, asteroid3, asteroid4, asteroid5, asteroid6, asteroid7, asteroid8, asteroid9;
@synthesize asteroids;  //this is the vector which will hold all of the above asteroid objects


@synthesize rotationBall;
@synthesize bullet0, bullet1, bullet2, bullet3, bullet4, bullet5;
@synthesize bullets; //this is the vector which will hold all of the above bullet objects

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	/************* This will load profile settings ****************/
	//for now just print the settings to the log!
	NSLog(@"UserName is set to: %@ \n",[UIAppDelegate.currentUser getName]);
	NSLog(@"Diff is set to: %d \n",[UIAppDelegate.currentUser getDiff]);
	NSLog(@"Stage is set to: %d \n",[UIAppDelegate.currentUser getStage]);
	NSLog(@"Score is set to: %d \n",[UIAppDelegate.currentUser getScore]);
	
		
	/**************** done loading settings ******************/
	
	
	int i;  //used as a counter 
	
	//values used to describe the direction the ship is facing, derived from the rotation wheel
	shipDirectionX = 18;  
	shipDirectionY = -15;
	//NSLog(@"Post load:   shipX = %f,   shipY = %f", shipDirectionX, shipDirectionY);
	
	//incrementor which denotes the next bullet to be fired, the 0th bullet is fired first
	bulletsFired = 0;
	
	//define asteroids array to hold the 10 asteroid UIImageViews, each of which is assigned to a pre-defined asteroid image in the view controller
	asteroids = [[NSMutableArray alloc] initWithObjects: asteroid0,asteroid1,asteroid2,asteroid3,asteroid4,asteroid5,asteroid6,asteroid7,asteroid8,asteroid9,nil];
	
	//sets the initial asteroid movement vectors:
	asteroidPos[0]=CGPointMake(3,3);
	asteroidPos[1]=CGPointMake(4,4);
	asteroidPos[2]=CGPointMake(3,2);
	asteroidPos[3]=CGPointMake(3,3);
	asteroidPos[4]=CGPointMake(6,4);
	asteroidPos[5]=CGPointMake(2,3);
	asteroidPos[6]=CGPointMake(1,6);
	asteroidPos[7]=CGPointMake(2,5);
	asteroidPos[8]=CGPointMake(1,4);
	asteroidPos[9]=CGPointMake(4,3);
	
	//define bullets array to hold the 6 bullet UIImageViews, each of which is assigned to a pre-defined asteroid image in the view controller
	bullets = [[NSMutableArray alloc] initWithObjects: bullet0,bullet1,bullet2,bullet3,bullet4,bullet5,nil];
	
	//sets the intial bullet movement vectors
	bulletPos[0] = CGPointMake(0,0);
	bulletPos[1] = CGPointMake(3,0);
	bulletPos[2] = CGPointMake(3,3);
	bulletPos[3] = CGPointMake(3,4);
	bulletPos[4] = CGPointMake(3,5);
	bulletPos[5] = CGPointMake(-3,-3);
	bulletPos[6] = CGPointMake(3,-3);
	
	UIImageView *tempBullet;  //temperary UIImageView allows manipulation of the elements of the bullets array
	for(i = 0; i <= 5;  i++)
	{
		tempBullet = [bullets objectAtIndex:i];
		tempBullet.center = CGPointMake(0,500); //set all bullets starting location as off-screen so they don't destroy any asteroids yet
	}
	[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	
    [super viewDidLoad];
}


-(IBAction) FireButton{
	UIImageView *tempBullet; //temperary UIImageView allows manipulation of the elements of the asteroids array
	
	tempBullet = [bullets objectAtIndex:bulletsFired]; 
	//assigns element of bullets array to tempBullet to allow manipulation of that element
	
	//NSLog(@"shipX = %f,   shipY = %f", shipDirectionX, shipDirectionY); 
	//sets the bullet being fired's movement vector to the vector defined by the direction in which the ship is pointing
	bulletPos[bulletsFired] = CGPointMake(shipDirectionX,shipDirectionY); 
	//tempBullet.center = CGPointMake(200,120); 
	tempBullet.center = CGPointMake(242,167);
	tempBullet.hidden = NO; 
	
	if(bulletsFired == 5)   //there are only six bullets so once all 6 have been fired start at 0 again
		bulletsFired = 0;
	else
		bulletsFired++;


}

//this function is called every 0.05 seconds, and updates the game screen
-(void) onTimer {

	int asteroidXSize = 32;
	int asteroidYSize = 30;
	
	UIImageView *tempAsteroid;
	UIImageView *tempBullet;
	
	int i =0;
	int i2 = 0;
	
	//updates asteroid movement for each of the 10 asteroids, 0-9
	for( i = 0; i <= 9; i++)
	{
		tempAsteroid = [asteroids objectAtIndex:i];
		
		//moves asteroid
		tempAsteroid.center = CGPointMake(tempAsteroid.center.x+asteroidPos[i].x,tempAsteroid.center.y+asteroidPos[i].y);
		
		//bounces asteroid if asteroid hits left or right of screen
		if( (tempAsteroid.center.x > 480 -asteroidXSize/2 && asteroidPos[i].x > 0)
		   || ( tempAsteroid.center.x < (0 +asteroidXSize/2)   && asteroidPos[i].x < 0) )
			asteroidPos[i].x = -asteroidPos[i].x;
		
		//bounces asteroid if asteroid hits top or bottom of screen
		if( (tempAsteroid.center.y > 293 -asteroidYSize/2  && asteroidPos[i].y > 0)
		   || (  tempAsteroid.center.y < (0 +asteroidYSize/2)  && asteroidPos[i].y < 0) )
			asteroidPos[i].y = -asteroidPos[i].y;	
	}
	
	//updates the bullet movement for each of the 6 bullets and checks for collisions with asteroids 
	//in which case both bullet and asteroid are destroyed
	for( i = 0; i <= 5; i++)
	{

		tempBullet = [bullets objectAtIndex:i];
		
		//moves bullet
		tempBullet.center = CGPointMake(tempBullet.center.x+bulletPos[i].x,tempBullet.center.y+bulletPos[i].y);
		
		//if bullet is off-screen then destroy the bullet by setting its movement to 0 and setting its location to 0,500, far off screen,
		//and finally hiding the bullet
		if( (tempBullet.center.x > 486 )|| ( tempBullet.center.x < -6 ) || (tempBullet.center.y > 300 )|| ( tempBullet.center.y < -6 ))
		{
			bulletPos[i].x = 0;
			bulletPos[i].y = 0;
			tempBullet.center = CGPointMake(0,500);
			tempBullet.hidden = YES;
		}
		
		//checks if the current bullet has collided with any of the 10 asteroids on the screen
		for( i2 = 0; i2 <= 9; i2++)
		{
			tempAsteroid = [asteroids objectAtIndex:i2];
			
			//if there is a collision then destroy both asteroid and bullet, hide the bullet and move it off screen and
			//move the asteroid to just above and to the left of the screen so it can move back into the screen area
			//as a new asteroid
			if(  ((tempBullet.center.x < tempAsteroid.center.x + 20) && (tempBullet.center.x > tempAsteroid.center.x - 20))
			     &&((tempBullet.center.y < tempAsteroid.center.y + 20) && (tempBullet.center.y > tempAsteroid.center.y - 20)) )
			{
				tempAsteroid.center = CGPointMake(-10,-10);
				tempBullet.center = CGPointMake(0,500);
				tempBullet.hidden = YES;
				bulletPos[i] = CGPointMake(0,0);
				NSLog(@"bulletx = %f    bullety = %f    astx = %f     asty  = %f", tempBullet.center.x, tempBullet.center.y,  tempAsteroid.center.x , tempAsteroid.center.y );
			}
		}
	}
	
}


-(IBAction) HelpScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}
-(IBAction) NextScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	GameOverScreenController *gamesOverScreenView = [[GameOverScreenController alloc] initWithNibName:@"GameOverScreenController" bundle:nil];
	[self.navigationController pushViewController:gamesOverScreenView animated:YES];
	[gamesOverScreenView release];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// rotate ship according to rotation wheel angle
-(IBAction) rotateByAngle:(CGFloat)angle {
	ship.transform = CGAffineTransformMakeRotation(angle);
}


/*This function is called when a touch on the screen is first detected
 */
-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	
    UITouch *touch = [[event allTouches] anyObject];  //records touch as touch object
    CGPoint location = [touch locationInView:touch.view]; //records touch's location
    //NSLog(@"X: %f",location.x);
    //NSLog(@"Y: %f",location.y);
	
	
	double x,y;
	double radius = 24;  //radius of rotation wheel
	double radiusSquared = radius*radius; //radius squared
	double xcenter = 50; //center of rotation wheel, x coordinate
	double ycenter = 252; //center of rotation wheel, y coordinate
	
	//if location of a touch is in the area of the rotation wheel, update the 
	//rotation wheel
	if(location.x>22 && location.x<80 && location.y>226 && location.y<285)
	{
		
		//code to approximate the closest point on the rotation wheel to the point
		//where the user touched the screen (they usually will not touch the 
		//rotation wheel right on so an approximation is necessary:
		
		if(location.y < ycenter-radius)
			location.y = ycenter-radius;
		else if (location.y > ycenter+radius )
			location.y = ycenter+radius ;
		
		if(location.x < xcenter-radius)
			location.x = xcenter-radius;
		else if (location.x > xcenter+radius )
			location.x = xcenter+radius ;
		
		if(location.y >= ycenter)
			y = sqrt( radiusSquared - (xcenter- location.x )*(xcenter- location.x ) ) + ycenter; 
		else
		{
			y = -sqrt( radiusSquared - (xcenter- location.x )*(xcenter- location.x ) ) + ycenter; 
		}
		
		y = (y + location.y)/2.0;
		//NSLog(@"inter2 Y: %f",y);
		
		if(location.x >= xcenter)
			x = sqrt(radiusSquared - (ycenter - y)*(ycenter - y) ) + xcenter;
		else
			x = -sqrt(radiusSquared - (ycenter - y)*(ycenter - y) ) + xcenter;
		
		//NSLog(@"X: %f",x);
		//NSLog(@"Y: %f",y);
		
		
		// get the radian angle of rotation (0 <-> 2 pi) based on point of contact with the wheel
		CGPoint arcTop = CGPointMake(xcenter, ycenter - radius);	// point of reference for angle formula
		CGFloat rotationAngle =  2 * atan2(location.y - arcTop.y, location.x - arcTop.x);
		[self rotateByAngle: rotationAngle];
		//NSLog(@"Angle: %f", rotationAngle); // for debug
	
		//[ship rotateByAngle: rotationAngle];
		
		//rotation ball is moved to the approximation of the closest point on the
		//rotation wheel to the point where to user actually touched the screen
		rotationBall.center = CGPointMake(x,y); 
		
		//shipDirection (used for ship rotation and firing direction) is updated
		shipDirectionX = (x - xcenter);
		shipDirectionY = (y - ycenter);
	}
	
    //---get all touches on the screen---
	/*
	 NSSet *allTouches = [event allTouches];
	 
	 
	 switch ([allTouches count])
	 {
	 //---single touch---
	 case 1: {
	 //---get info of the touch---
	 UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
	 
	 //---compare the touches---
	 switch ([touch tapCount])
	 {
	 //---single tap---
	 case 1: {
	 
	 } break;
	 //---double tap---	
	 case 2: {	
	 
	 } break;	
	 }
	 
	 }  break;	
	 
	 }	
	 */
}

/*This function is called when a finger is dragged on the screen
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
    UITouch *touch = [[event allTouches] anyObject];  //records touch as touch object
    CGPoint location = [touch locationInView:touch.view]; //records touch's location
    //NSLog(@"X: %f",location.x);
    //NSLog(@"Y: %f",location.y);
	
	
	double x,y;
	double radius = 24;  //radius of rotation wheel
	double radiusSquared = radius*radius; //radius squared
	double xcenter = 50; //center of rotation wheel, x coordinate
	double ycenter = 252; //center of rotation wheel, y coordinate
	
	//if location of a touch is in the area of the rotation wheel, update the 
	//rotation wheel
	if(location.x>22 && location.x<80 && location.y>226 && location.y<285)
	{
		
		//code to approximate the closest point on the rotation wheel to the point
		//where the user touched the screen (they usually will not touch the 
		//rotation wheel right on so an approximation is necessary:
		
		if(location.y < ycenter-radius)
			location.y = ycenter-radius;
		else if (location.y > ycenter+radius )
			location.y = ycenter+radius ;
		
		if(location.x < xcenter-radius)
			location.x = xcenter-radius;
		else if (location.x > xcenter+radius )
			location.x = xcenter+radius ;
		
		if(location.y >= ycenter)
			y = sqrt( radiusSquared - (xcenter- location.x )*(xcenter- location.x ) ) + ycenter; 
		else
		{
			y = -sqrt( radiusSquared - (xcenter- location.x )*(xcenter- location.x ) ) + ycenter; 
		}
		
		y = (y + location.y)/2.0;
		//NSLog(@"inter2 Y: %f",y);
		
		if(location.x >= xcenter)
			x = sqrt(radiusSquared - (ycenter - y)*(ycenter - y) ) + xcenter;
		else
			x = -sqrt(radiusSquared - (ycenter - y)*(ycenter - y) ) + xcenter;
		
		//NSLog(@"X: %f",x);
		//NSLog(@"Y: %f",y);
		
		//rotation ball is moved to the approximation of the closest point on the
		//rotation wheel to the point where to user actually touched the screen
		rotationBall.center = CGPointMake(x,y); 
		
		//shipDirection (used for ship rotation and firing direction) is updated
		shipDirectionX = (x - xcenter);
		shipDirectionY = (y - ycenter);
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touchesEnded");
}



// override to allow orientations other than the default portrait orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
