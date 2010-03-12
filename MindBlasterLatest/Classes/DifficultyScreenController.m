//
//  DifficultyScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DifficultyScreenController.h"

//#import "HelpScreenController.h"
//#import "Ball.h"
//#import "MindBlasterAppDelegate.h"
//#import "UserProfile.h"

@implementation DifficultyScreenController
@synthesize difficultyDescription;

-(IBAction) HelpScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}
-(IBAction) NextScreen
{
	//NSLog(@"The diff now set to %d \n",[UIAppDelegate.currentUser getDiff]);
	
	// Navigation logic may go here -- for example, create and push another view controller.
	GameScreenController *gamesScreenView = [[GameScreenController alloc] initWithNibName:@"GameScreenController" bundle:nil];
	[self.navigationController pushViewController:gamesScreenView animated:YES];
	[gamesScreenView release];
}

-(IBAction) selectedEasiest
{
	[UIAppDelegate.currentUser setCurrentDifficulty:DIFFICULTY_EASIEST];
	//NSLog(@"The difficulty setting is now: %d \n", [UIAppDelegate.currentUser getDiff]);
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,10]"];
	[difficultyDescription setText:msg];
	[msg release];
}
-(IBAction) selectedEasy
{
	[UIAppDelegate.currentUser setCurrentDifficulty:DIFFICULTY_EASY];
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,20]"];
	[difficultyDescription setText:msg];
	[msg release];
}
-(IBAction) selectedHard
{
	[UIAppDelegate.currentUser setCurrentDifficulty:DIFFICULTY_HARD];
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,30]"];
	[difficultyDescription setText:msg];
	[msg release];
}
-(IBAction) selectedHardest
{
	[UIAppDelegate.currentUser setCurrentDifficulty:DIFFICULTY_HARDEST];
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,40]"];
	[difficultyDescription setText:msg];
	[msg release];
}


- (IBAction) BackScreen
{
	[self.navigationController popViewControllerAnimated:TRUE];
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
