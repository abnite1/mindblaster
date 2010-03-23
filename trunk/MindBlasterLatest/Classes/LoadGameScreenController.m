//
//  LoadGameScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoadGameScreenController.h"
#import "GlobalAdmin.h"


@implementation LoadGameScreenController

-(IBAction) helpScreen {
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

// this leads to another screen where the player loads a profile from the web server
// currently only a stub for the implementation to follow in phase II
-(IBAction) upload {
	
	/******* THIS IS JUST FOR TESTING - it creates a userprofile with all categories filled out *********/
	
	//temporarily this loads userprofile with data, to unlock higher levels.
	[UIAppDelegate.currentUser setUserName:@"Blanka"];
	Score *score = [Score new];
	[score setScore:9999];
	[UIAppDelegate.currentUser setScore:score];
	//[[UIAppDelegate.currentUser score] setScore:9999];
	[UIAppDelegate.currentUser setEmail:@"johnnythejew@hotmail.com"];
	[UIAppDelegate.currentUser setHighestScore:10000];
	Topic *current = [Topic new];
	[current setTopic:TOPIC_MULTIPLICATION];
	[current setDifficulty:DIFFICULTY_HARD];
	[current setDescription:@"blank"];
	Topic *last = [Topic new];
	[last setTopic:TOPIC_DIVISION];
	[last setDifficulty:DIFFICULTY_HARDEST];
	[last setDescription:@"blank"];
	[UIAppDelegate.currentUser setCurrentTopic:current];
	[UIAppDelegate.currentUser setLastTopicCompleted:last];

	[score release];
	[current release];
	[last release];
	
	NSLog(@"Current Username is: %@ \n",[UIAppDelegate.currentUser userName]);
	NSLog(@"Current email is: %@ \n",[UIAppDelegate.currentUser email]);
	NSLog(@"LasttopicDiff is: %d \n",[[UIAppDelegate.currentUser lastTopicCompleted] difficulty]);
	NSLog(@"lasttopictopic is: %d \n",[[UIAppDelegate.currentUser lastTopicCompleted] topic]);
	NSLog(@"Score is: %d \n",[[UIAppDelegate.currentUser score] score]);
	NSLog(@"HighestScore is: %d \n",[UIAppDelegate.currentUser highestScore]);
/*	
	TopicScreenController *topicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:topicView animated:YES];
	[topicView release];
 */
}
-(IBAction) download {

	//GlobalAdmin *admin = [GlobalAdmin new];
	[GlobalAdmin writeToFile];

	//[admin release];
	
   	TopicScreenController *topicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:topicView animated:YES];
	[topicView release];
}

// go back to the previous screen
- (IBAction) backScreen {
	[self.navigationController popViewControllerAnimated:TRUE];
}


// animate the space background
-(void)animateBackground {
	[background move];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
