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

@implementation GameScreenController

@synthesize asteroid0, asteroid1, asteroid2, asteroid3, asteroid4, asteroid5, asteroid6, asteroid7, asteroid8, asteroid9;
@synthesize asteroids;
@synthesize rotationBall;
@synthesize bullet0, bullet1, bullet2, bullet3, bullet4, bullet5;
@synthesize bullets;

-(IBAction) FireButton{
	NSLog(@"shipX = %f,   shipY = %f", shipDirectionX, shipDirectionY);
	bulletPos[0] = CGPointMake(shipDirectionX,shipDirectionY);
}

-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    //NSLog(@"X: %f",location.x);
    //NSLog(@"Y: %f",location.y);
	
	
	double x,y;
	double radius = 24;
	double radiusSquared = radius*radius;
	double xcenter = 50;
	double ycenter = 252;
	
	
	if(location.x>22 && location.x<80 && location.y>226 && location.y<285)
	{
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
		
		rotationBall.center = CGPointMake(x,y); 
		shipDirectionX = (x - xcenter);
		shipDirectionY = (y - ycenter);
		NSLog(@"MOVEMENT???   shipX = %f,   shipY = %f", shipDirectionX, shipDirectionY);
		
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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touchesMoved");
	UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    //NSLog(@"X: %f",location.x);
    //NSLog(@"Y: %f",location.y);
	
	
	double x,y;
	double radius = 24;
	double radiusSquared = radius*radius;
	double xcenter = 50;
	double ycenter = 252;
	
	
	if(location.x>22 && location.x<80 && location.y>226 && location.y<285)
	{
		
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
		
		rotationBall.center = CGPointMake(x,y); 
		shipDirectionX = (x - xcenter);
		shipDirectionY = (y - ycenter);
		NSLog(@"MOVEMENT???   shipX = %f,   shipY = %f", shipDirectionX, shipDirectionY);

	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touchesEnded");
}


-(void) onTimer {

	int asteroidXSize = 32;
	int asteroidYSize = 30;
	
	UIImageView *tempAsteroid;
	UIImageView *tempBullet;
	
	int i =0;
	for( i = 0; i <= 9; i++)
	{
		tempAsteroid = [asteroids objectAtIndex:i];
		
		tempAsteroid.center = CGPointMake(tempAsteroid.center.x+asteroidPos[i].x,tempAsteroid.center.y+asteroidPos[i].y);
		
		if( (tempAsteroid.center.x > 480 -asteroidXSize/2 && asteroidPos[i].x > 0)
		   || ( tempAsteroid.center.x < (0 +asteroidXSize/2)   && asteroidPos[i].x < 0) )
			asteroidPos[i].x = -asteroidPos[i].x;
		if( (tempAsteroid.center.y > 293 -asteroidYSize/2  && asteroidPos[i].y > 0)
		   || (  tempAsteroid.center.y < (0 +asteroidYSize/2)  && asteroidPos[i].y < 0) )
			asteroidPos[i].y = -asteroidPos[i].y;	
	}
	for( i = 0; i <= 0; i++)
	{

		tempBullet = [bullets objectAtIndex:i];
		
		tempBullet.center = CGPointMake(tempBullet.center.x+bulletPos[i].x,tempBullet.center.y+bulletPos[i].y);
		
		if( (tempBullet.center.x > 486 )|| ( tempBullet.center.x < -6 ) )
		{
			bulletPos[i].x = 0;
			bulletPos[i].y = 0;
			tempBullet.center = CGPointMake(200,120);
		}
		if( (tempBullet.center.y > 300 )|| ( tempBullet.center.y < -6 ) )
		{
			bulletPos[i].x = 0;
			bulletPos[i].y = 0;
			tempBullet.center = CGPointMake(200,120);
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	shipDirectionX = 18;
	shipDirectionY = -15;
	NSLog(@"Post load:   shipX = %f,   shipY = %f", shipDirectionX, shipDirectionY);


	asteroids = [[NSMutableArray alloc] initWithObjects: asteroid0,asteroid1,asteroid2,asteroid3,asteroid4,asteroid5,asteroid6,asteroid7,asteroid8,asteroid9,nil];
	
	
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
	
	
	bullets = [[NSMutableArray alloc] initWithObjects: bullet0,bullet1,bullet2,bullet3,bullet4,bullet5,nil];
	
	bulletPos[0] = CGPointMake(0,0);
	bulletPos[1] = CGPointMake(3,0);
	bulletPos[2] = CGPointMake(3,3);
	bulletPos[3] = CGPointMake(3,4);
	bulletPos[4] = CGPointMake(3,5);
	bulletPos[5] = CGPointMake(-3,-3);
	bulletPos[6] = CGPointMake(3,-3);
	
	[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	
	
    [super viewDidLoad];

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
