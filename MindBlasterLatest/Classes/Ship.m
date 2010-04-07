//
//  Ship.m
//  MindBlaster
//
//  Created by yaniv haramati on 05/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//
#import "Ship.h"


@implementation Ship
@synthesize shipIcon, pos, direction;


-(void)setIcon:(UIImageView*)icon {
	shipIcon = icon;
	direction = 0.0f;
	pos.x = icon.center.x;
	pos.y = icon.center.y;

}

-(void)setIconUnitTest:(UIImageView*)icon {
	shipIcon = nil;
	if (icon == nil)
		NSLog(@"UNIT TEST FAILED; class: Ship; function: setIcon; unit test passed a nil UIImage for icon");
	else
		[self setIcon: icon];
	
	if(shipIcon == nil  && icon != nil)
	{
		NSLog(@"UNIT TEST FAILED; class: Ship; function: setIcon; shipIcon not set");

	}
	else
		NSLog(@"UNIT TEST PASSED; class: Ship; function: setIcon");
}

//this function is unit tested visually as visual confirmation is needed that the ship icon is rotating
//the compiler cannot verify this
-(void) rotate: (CGFloat)angle {
	
	direction = angle;
	
	shipIcon.transform = CGAffineTransformMakeRotation(angle);
}

/*
-(IBAction)rotate {
	
	//direction += M_PI_4;
	[self rotateByAngle: direction];
}
 
 if([self checkCollisionOf: [asteroids objectAtIndex: 1] with : [asteroids objectAtIndex: 2]] == YES)
 {
 NSLog(@"UNIT TEST FAILED; function: checkCollisionOf; collision not detected properly3");
 unitTestPassed = FALSE;
 }
 if(unitTestPassed == TRUE)
 NSLog(@"UNIT TEST PASSED; function: checkCollisionOf");
 
 */

-(IBAction)fire {
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
