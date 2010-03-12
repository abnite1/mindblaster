//
//  TopicScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TopicScreenController.h"

@implementation TopicScreenController
@synthesize label;

-(IBAction) HelpScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}
- (IBAction) BackScreen
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

//These will store in some location which game module will be used.
//This location will be accessed when the game is being loaded.

// addition
-(IBAction) firstTopicSelected
{
	[UIAppDelegate.currentUser setCurrentTopic:[[Topic alloc] initWithTopic:TOPIC_ADDITION]];	// possible memory leak

	NSString *msg = [[NSString alloc] initWithFormat:@"Addition."];
	[UIAppDelegate.currentUser.currentTopic setDescription:msg];
	[label setText:msg];
	[msg release];
	[UIAppDelegate.currentUser.currentTopic setOperator:(char*)'+'];
}

// subtraction
-(IBAction) secondTopicSelected
{
	[UIAppDelegate.currentUser setCurrentTopic:[[Topic alloc] initWithTopic:TOPIC_SUBTRACTION]];	// possible memory leak

	NSString *msg = [[NSString alloc] initWithFormat:@"Subtraction."];
	[UIAppDelegate.currentUser.currentTopic setDescription:msg];
	[label setText:msg];
	[msg release];
	[UIAppDelegate.currentUser.currentTopic setOperator:(char*)'-'];
}

// multiplication
-(IBAction) thirdTopicSelected
{
	[UIAppDelegate.currentUser setCurrentTopic:[[Topic alloc] initWithTopic:TOPIC_MULTIPLICATION]];		// possible memory leak
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Multiplication."];
	[UIAppDelegate.currentUser.currentTopic setDescription:msg];
	[label setText:msg];
	[msg release];
	[UIAppDelegate.currentUser.currentTopic setOperator:(char*)'X'];
}

// division
-(IBAction) fourthTopicSelected
{
	[UIAppDelegate.currentUser setCurrentTopic:[[Topic alloc] initWithTopic:TOPIC_DIVISION]];		// possible memory leak
	
	NSString *msg = [[NSString alloc] initWithFormat:@"Division."];
	[UIAppDelegate.currentUser.currentTopic setDescription:msg];
	[label setText:msg];
	[msg release];
	[UIAppDelegate.currentUser.currentTopic setOperator:(char*)'/'];
}

-(IBAction) NextScreen
{
	//DEBUGGING
	//NSLog(@"The topic now set to %d \n",[UIAppDelegate.currentUser getStage]);
	
	
	// Navigation logic may go here -- for example, create and push another view controller.
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Topic";
    [super viewDidLoad];

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
