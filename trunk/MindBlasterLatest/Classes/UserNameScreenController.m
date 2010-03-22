//
//  UserNameScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//	modified by yaniv harmati to abide by coding standards
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserNameScreenController.h"
#import "Topic.h"


@implementation UserNameScreenController
@synthesize name;


// hide the keyboard after name is entered
-(IBAction) makeKeyboardGoAway {
	[name resignFirstResponder];
}

// show the text field after the keyboard is gone
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

// navigate to the help screen
-(IBAction) helpScreen {
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

//navigate to topic selection
-(IBAction) nextScreen {


	//[self initUserProfileSettings];
	//then obviously set the name to what theychose.
	[UIAppDelegate.currentUser setUserName:[name text]];
	
	// Navigation logic may go here -- for example, create and push another view controller.
	TopicScreenController *topicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:topicView animated:YES];
	[topicView release];
}

// initializes the default topic to ADDITION
//THIS IS NOW HANDLED AT CHARCTER SCREEN CONTROLLER, by calling the GlobalAdmin function "initProfile"
/*
-(void) initUserProfileSettings {
	//NSLog(@"Checking: The name was chosen as: %@ \n",[name text]);
	[(UIAppDelegate.currentUser) setUserName:[name text]];
	//NSLog(@"The current name is set to: %@ \n", [UIAppDelegate.currentUser getName]);
	
	// set the last topic completed to the first choice
	[UIAppDelegate.currentUser setLastTopicCompleted:[[Topic alloc] initWithTopic: TOPIC_ADDITION]];
}*/

- (IBAction) backScreen {
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
