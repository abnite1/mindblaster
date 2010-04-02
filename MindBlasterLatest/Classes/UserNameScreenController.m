//
//  UserNameScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//	modified by yaniv haramati to abide by coding standards
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserNameScreenController.h"


@implementation UserNameScreenController

@synthesize name,email, okButton;


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

// user entered name
-(IBAction) nameEntered {
	
	NSLog(@"name: %@", name.text);
	NSLog(@"email: %@", email.text);
	
	NSLog(@"empty string? %d, %d", YES,  [name.text isEqualToString:@""]);
	// enable OK button if both text fields have been input
	if (name.text != nil && email.text != nil && 
		! [name.text isEqualToString:@""] && 
		! [email.text isEqualToString:@""]) {
		
		[okButton setEnabled: YES];
		okButton.hidden = NO;
		
	}
}

// user entered name
-(IBAction) emailEntered {
	
	NSLog(@"name: %@", name.text);
	NSLog(@"email: %@", email.text);
	
	// enable OK button if both text fields have been input
	if (name.text != nil && email.text != nil && 
		! [name.text isEqualToString:@""] && 
		! [email.text isEqualToString:@""]) {
		
		[okButton setEnabled: YES];
		okButton.hidden = NO;
		
	}
}

//navigate to topic selection
-(IBAction) nextScreen {

	// set the AppDelegate user name
	[UIAppDelegate.currentUser setUserName:[name text]];
	[UIAppDelegate.currentUser setEmail: [email text]];
	
	// Navigation logic may go here -- for example, create and push another view controller.
	TopicScreenController *topicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:topicView animated:YES];
	[topicView release];
}


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
	
	[self.navigationController setTitle: @"usernameView"];
	
	// initialize the edit field
	name.text = nil;
	email.text = nil;
	
	// disable the ok button and hide it until username and email are input
	[okButton setEnabled: NO];
	okButton.hidden = YES;
	
	[self.navigationController setNavigationBarHidden:TRUE animated: NO ];
	
	[NSTimer scheduledTimerWithTimeInterval:0.03 target:self
								   selector:@selector(animateBackground) userInfo:nil repeats:YES];
	[background setSpeedX:0.2 Y:0.2];
	
}

// delegate function that runs every time the view returns from "back" of another screen
- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
	NSLog(@"username view will appear.");
}


// delegate function that runs every time the view returns from "back" of another screen
- (void)viewDidAppear:(BOOL)animated {
    
	[super viewDidAppear:animated];
	NSLog(@"username view did appear.");
	[self.navigationController setTitle: @"usernameView"];
	
}

- (void) viewWillDisappear:(BOOL)animated {
	
	// play button click
	[MindBlasterAppDelegate playButtonClick];
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
