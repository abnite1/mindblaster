//
//  DifficultyScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DifficultyScreenController.h"
#import "Topic.h"

@implementation DifficultyScreenController
@synthesize difficultyDescription;
@synthesize easiest;
@synthesize easy;
@synthesize hard;
@synthesize hardest;

// navigate to the help screen
-(IBAction) helpScreen {
	
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

// navigate to GameScreen view
-(IBAction) nextScreen {
	
	// Navigation logic may go here -- for example, create and push another view controller.
	GameScreenController *gamesScreenView = [[GameScreenController alloc] initWithNibName:@"GameScreenController" bundle:nil];
	[self.navigationController pushViewController:gamesScreenView animated:YES];
	[gamesScreenView release];
}

// user selected easiest difficulty
-(IBAction) selectedEasiest {
	
	// set it in the profile
	[[UIAppDelegate.currentUser currentTopic] setDifficulty:DIFFICULTY_EASIEST];
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,10]"];
	[difficultyDescription setText:msg];
	[msg release];
}

// user selected easy difficulty
-(IBAction) selectedEasy {
	
	// set it in the profile
	[[UIAppDelegate.currentUser currentTopic] setDifficulty:DIFFICULTY_EASY];
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,20]"];
	[difficultyDescription setText:msg];
	[msg release];
}

// user selected hard difficulty
-(IBAction) selectedHard {
	
	// set it in the profile
	[[UIAppDelegate.currentUser currentTopic] setDifficulty:DIFFICULTY_HARD];

	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,30]"];
	[difficultyDescription setText:msg];
	[msg release];
}

// user selected hardest difficulty
-(IBAction) selectedHardest {
	
	// set it in the profile
	[[UIAppDelegate.currentUser currentTopic] setDifficulty:DIFFICULTY_HARDEST];

	
	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,40]"];
	[difficultyDescription setText:msg];
	[msg release];
}

// default selection is always easiest
-(void) defaultSelection {
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Range: [0,10]"];
	[difficultyDescription setText:msg];
	[msg release];
}


// navigate back to the previous screen
-(IBAction) backScreen {
	
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

// animate the space background
-(void)animateBackground {
	[background move];
}

// default to the easiest difficulty level, then set up the space background animation
- (void)viewDidLoad {
	[super viewDidLoad];
	
	// default to easiest
	[self defaultSelection];
	
	// disable and hide difficulty settings that haven't yet been unlocked.
	if([[UIAppDelegate.currentUser currentTopic] topic] == [[UIAppDelegate.currentUser lastTopicCompleted] topic]) {
		
		switch([[UIAppDelegate.currentUser lastTopicCompleted] difficulty]) {
				
			case 1:
				[easy setEnabled:NO];
				easy.hidden = YES;
			case 2:
				[hard setEnabled:NO];
				hard.hidden = YES;
			case 3:
				[hardest setEnabled:NO];
				hardest.hidden = YES;
			
			default:
				break;
		}

	} 
		 
	
	// start space animation
	[self.navigationController setNavigationBarHidden:TRUE animated: NO ];
	
	[NSTimer scheduledTimerWithTimeInterval:0.001 target:self
								   selector:@selector(animateBackground) userInfo:nil repeats:YES];
	[background setSpeedX:0.2 Y:0.2];

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
