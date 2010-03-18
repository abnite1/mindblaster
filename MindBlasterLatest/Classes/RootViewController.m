//
//  RootViewController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  modified by john kehler on early march : added space animation
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController



/*
 *	navigate to the help screen
 */
-(IBAction) helpScreen {
	
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

/*
 *	navigate to the next screen, which is character selection
 */
- (IBAction) nextScreen {
    // Navigation logic may go here -- for example, create and push another view controller.
	CharacterScreenController *characterView = [[CharacterScreenController alloc] initWithNibName:@"CharacterScreenController" bundle:nil];
	[self.navigationController pushViewController:characterView animated:YES];
	[characterView release];
}

/*
 *	navigate to the loadgame screen
 */
- (IBAction) loadGame {
    // Navigation logic may go here -- for example, create and push another view controller.
	LoadGameScreenController *loadGameView = [[LoadGameScreenController alloc] initWithNibName:@"LoadGameScreenController" bundle:nil];
	[self.navigationController pushViewController:loadGameView animated:YES];
	[loadGameView release];
}

// continute to topic selection with the current profile
- (IBAction) continueSelected {
	
	//Load the stored plist into the profile.
	
	
	// Navigation logic may go here -- for example, create and push another view controller.
	TopicScreenController *topicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:topicView animated:YES];
	[topicView release];
}

/*
 * perform these actions when view first loads:
 * animate the background space image
*/

- (void)viewDidLoad {
	
	///Check if profile exists, if so, fine
	//IF not, then hide the "Continue" button.
	
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:TRUE animated: NO ];
	
	[NSTimer scheduledTimerWithTimeInterval:0.01 target:self
								   selector:@selector(moveBackground) userInfo:nil repeats:YES];
	[bgAnimation setSpeedX:0.2 Y:0.2];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// selector function for the background animation
-(void)moveBackground {
	[bgAnimation move];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


 

/*
// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	 AnotherView *anotherViewController = [[AnotherView alloc] initWithNibName:@"AnotherView" bundle:nil];
	 [self.navigationController pushViewController:anotherViewController animated:YES];
	 [anotherViewController release];
}
*/


// override to allow orientations other than the default portrait orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
	[bgAnimation dealloc];
    [super dealloc];
}


@end
