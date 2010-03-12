//
//  UserNameScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserNameScreenController.h"
#import "TopicScreenController.h"
#import "HelpScreenController.h"
#import "Ball.h"
#import "UserProfile.h"
#import "MindBlasterAppDelegate.h"

@implementation UserNameScreenController
@synthesize txtName;
//TEST
//@synthesize temp;

-(IBAction) MakeKeyboardGoAway //not working?
{
	[txtName resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(IBAction) HelpScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

//So this method should save txtName to the user data profile.
-(IBAction) NextScreen
{

	//NSLog(@"Checking: The name was chosen as: %@ \n",[txtName text]);
	[(UIAppDelegate.currentUser) setUserName:[txtName text]];
	//NSLog(@"The current name is set to: %@ \n", [UIAppDelegate.currentUser getName]);
	
	
	// Navigation logic may go here -- for example, create and push another view controller.
	TopicScreenController *topicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:topicView animated:YES];
	[topicView release];
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
	 //TEMP
	//[temp setImage:[(UIAppDelegate.currentUser) getPic] forState:0];
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
