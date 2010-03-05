//
//  GameOverScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameOverScreenController.h"
#import "HelpScreenController.h"
//#import "UserNameViewController.h"
#import "Ball.h"
#import "RootViewController.h"
#import "TopicScreenController.h"



@implementation GameOverScreenController

//new game with same settings as the game that just finished - simply navigates BACK one to gamescreen
-(IBAction) TryAgain  //new game with same settings as the game that just finished
{
	[self.navigationController popViewControllerAnimated:TRUE];	
}

-(IBAction) ChangeTopic  //new game with same settings as the game that just finished
{
	//[self.navigationController popToViewController: topicView animated YES];	
	TopicScreenController *TopicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:TopicView	animated:YES];
	[TopicView release];
}
-(IBAction) Quit
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction) HelpScreen
{
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
