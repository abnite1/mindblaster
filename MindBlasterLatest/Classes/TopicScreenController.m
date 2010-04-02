//
//  TopicScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  restructured by yaniv haramati on 13/03/10
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TopicScreenController.h"
#import "GlobalAdmin.h"
@implementation TopicScreenController
@synthesize label;
@synthesize addition;
@synthesize subtraction;
@synthesize multiplication;
@synthesize division;

-(IBAction) helpScreen {
	
	// navigate to the help screen
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

// navigate back to the previous screen
- (IBAction) backScreen {
	
	[self.navigationController popViewControllerAnimated:TRUE];
	
}


// addition selected
-(IBAction) firstTopicSelected {
	
	// create a new topic
	Topic *topic = [[Topic alloc] initWithTopic: TOPIC_ADDITION];
	NSString *msg = [[NSString alloc] initWithFormat:@"Addition."];
	[topic setDescription: msg];
	
	// set an appropriate UI label
	[label setText:msg];
	
	// update the AppDelegate profile
	[UIAppDelegate.currentUser setCurrentTopic: topic];

	[msg release];
	[topic release];
}

// subtraction selected
-(IBAction) secondTopicSelected {
	
	// create a new topic
	Topic *topic = [[Topic alloc] initWithTopic: TOPIC_SUBTRACTION];
	NSString *msg = [[NSString alloc] initWithFormat:@"Subtraction."];
	[topic setDescription: msg];
	
	// set an appropriate UI label
	[label setText:msg];
	
	// update the AppDelegate profile
	[UIAppDelegate.currentUser setCurrentTopic: topic];
	
	[msg release];
	[topic release];
}

// multiplication selected
-(IBAction) thirdTopicSelected {

	// create a new topic
	Topic *topic = [[Topic alloc] initWithTopic: TOPIC_MULTIPLICATION];
	NSString *msg = [[NSString alloc] initWithFormat:@"Multiplication."];
	[topic setDescription: msg];
	
	// set an appropriate UI label
	[label setText:msg];
	
	// update the AppDelegate profile
	[UIAppDelegate.currentUser setCurrentTopic: topic];
	
	[msg release];
	[topic release];
}

// division selected
-(IBAction) fourthTopicSelected {

	// create a new topic
	Topic *topic = [[Topic alloc] initWithTopic: TOPIC_DIVISION];
	NSString *msg = [[NSString alloc] initWithFormat:@"Division."];
	[topic setDescription: msg];
	
	// set an appropriate UI label
	[label setText:msg];
	
	// update the AppDelegate profile
	[UIAppDelegate.currentUser setCurrentTopic: topic];
	
	[msg release];
	[topic release];
}

// navigate to difficulty selection
-(IBAction) nextScreen {	
	
	// navigate to difficulty selection view
	DifficultyScreenController *difficultyView = [[DifficultyScreenController alloc] initWithNibName:@"DifficultyScreenController" bundle:nil];
	[self.navigationController pushViewController:difficultyView animated:YES];
	[difficultyView release];
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

// default to the first topic selection, start the sapce background animation
- (void)viewDidLoad {
	
	[self.navigationController setTitle: @"topicView"];
	
	// default to the first topic
	[self firstTopicSelected];
	
	// display a current profile representation. 
	[UIAppDelegate.currentUser userLog];
	

	//block and hide any locked topics
	//NSLog(@"Last Topic Completed is currently set to: %d \n",[[UIAppDelegate.currentUser lastTopicCompleted] topic]);
	//purposely don't do break so excecute all rest as well

	switch([[UIAppDelegate.currentUser lastTopicCompleted] topic]) {
		
		case 0:		// addition
			[subtraction setEnabled: NO];
			subtraction.hidden = YES;
			
		case 1:		// subtraction
			[multiplication setEnabled:NO];
			multiplication.hidden = YES;
			
		case 2:		// multiplication
			[division setEnabled:NO];
			division.hidden = YES;
			
		default:
			break;
	}
	/*
	 The locking aspect was tested as follows:
	  LoadGame loaded a userprofile with Topics 2,3,4 locked and diff 1,2,3 unlocked on that topic
	  This was evident in choice availability on topic and diff screens.
	  Then diffscreen changed the topics available to 1,2,3 (only 4 locked) 
	  Went back to topicscreen to see if changes took effect:
		Changes only took effect if got back from GameOver (quit -> mainmenu) OR changetopic
		If went straight back to topic from diff, viewdidload did not run and didn't take effect.
		This shouldn't cause any problems.
	*/

	[self.navigationController setNavigationBarHidden:TRUE animated: NO ];
	
	[NSTimer scheduledTimerWithTimeInterval:0.03 target:self
								   selector:@selector(animateBackground) userInfo:nil repeats:YES];
	[background setSpeedX:0.2 Y:0.2];
	[super viewDidLoad];
}

// delegate function that runs every time the view returns from "back" of another screen
- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
	NSLog(@"topic view will appear.");
}

- (void) viewWillDisappear:(BOOL)animated {
	
	// play button click
	[MindBlasterAppDelegate playButtonClick];
}


// delegate function that runs every time the view returns from "back" of another screen
- (void)viewDidAppear:(BOOL)animated {
    
	[super viewDidAppear:animated];
	NSLog(@"topic view did appear.");
	[self.navigationController setTitle: @"topicView"];
	
}

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

// override to allow orientations other than the default portrait orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
    [super dealloc];
}


@end
