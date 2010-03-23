//
//  GameOverScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  modified by yaniv haramati on 14/03/10 (see .h)
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameOverScreenController.h"
#import "GlobalAdmin.h"

/*
 * this screen appears when the player either wins the game (over 400 points at hardest level) or loses the game
 * (under 0 points at any level). the player may choose to try again, or return to the root menu
 * like in any other screen, the help menu is availble here as well.
 */


@implementation GameOverScreenController

//new game with same settings as the game that just finished - simply navigates BACK one to gamescreen
// this should also reset the scoreboard in the phase II
-(IBAction) tryAgain {
	[self.navigationController popViewControllerAnimated:TRUE];	
}



//new game with same settings as the game that just finished

-(IBAction) changeTopic  {
	//[self.navigationController popToViewController: topicView animated YES];	
	TopicScreenController *TopicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:TopicView	animated:YES];
	[TopicView release];
}

// navigate back to main menu
-(IBAction) quit {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

// navigate to the help screen
-(IBAction) helpScreen {
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
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

// animate the space background
-(void)animateBackground {
	[background move];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//save profile to plist UNCOMMENT THIS ONCE gamescreen proplerly updates the userprofile with score andlasttopiccomplete.
	//[GlobalAdmin writeToFile];
	
	[self.navigationController setNavigationBarHidden:TRUE animated: NO ];
	
	[NSTimer scheduledTimerWithTimeInterval:0.001 target:self
								   selector:@selector(animateBackground) userInfo:nil repeats:YES];
	[background setSpeedX:0.2 Y:0.2];
}


// override to allow orientations other than the default portrait orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
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
