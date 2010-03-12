//
//  CharacterScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CharacterScreenController.h"

@implementation CharacterScreenController
@synthesize charOne;
@synthesize charTwo;
@synthesize charThree;
@synthesize charFour;

-(IBAction) HelpScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

/*
 The following will save an image to the user profile data.
 */
- (IBAction) CharacterOne
{
	//passing the character pic "currentImage" from the button "charOne" 
	//into and setting the profile accounts picture with "setPic" setter function
	//CONFIRMED THIS WORKS!!!
	//use "[temp setImage:[(UIAppDelegate.currentUser) getPic] forState:0];"
	//to set it to a button, where "temp" is a IBOutlet UIButton connected to button
	//in interface builder.
	[(UIAppDelegate.currentUser) setProfilePic:[charOne currentImage]];
	//NSLog(@"Ponter to picture is: %x \n",[(UIAppDelegate.currentUser) getPic]);
	
    // Navigation logic may go here -- for example, create and push another view controller.
	UserNameScreenController *userNameView = [[UserNameScreenController alloc] initWithNibName:@"UserNameScreenController" bundle:nil];
	[self.navigationController pushViewController:userNameView animated:YES];
	[userNameView release];
}
- (IBAction) CharacterTwo
{
	[(UIAppDelegate.currentUser) setProfilePic:[charTwo currentImage]];
	
    // Navigation logic may go here -- for example, create and push another view controller.
	UserNameScreenController *userNameView = [[UserNameScreenController alloc] initWithNibName:@"UserNameScreenController" bundle:nil];
	[self.navigationController pushViewController:userNameView animated:YES];
	[userNameView release];
}
- (IBAction) CharacterThree
{
	[(UIAppDelegate.currentUser) setProfilePic:[charThree currentImage]];
	
    // Navigation logic may go here -- for example, create and push another view controller.
	UserNameScreenController *userNameView = [[UserNameScreenController alloc] initWithNibName:@"UserNameScreenController" bundle:nil];
	[self.navigationController pushViewController:userNameView animated:YES];
	[userNameView release];
}
- (IBAction) CharacterFour
{
	[(UIAppDelegate.currentUser) setProfilePic:[charFour currentImage]];
	
    // Navigation logic may go here -- for example, create and push another view controller.
	UserNameScreenController *userNameView = [[UserNameScreenController alloc] initWithNibName:@"UserNameScreenController" bundle:nil];
	[self.navigationController pushViewController:userNameView animated:YES];
	[userNameView release];
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
