//
//  RootViewController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "AnotherView.h"

@implementation RootViewController

- (IBAction) NextScreen
{
    // Navigation logic may go here -- for example, create and push another view controller.
	AnotherView *anotherViewController = [[AnotherView alloc] initWithNibName:@"AnotherView" bundle:nil];
	[self.navigationController pushViewController:anotherViewController animated:YES];
	[anotherViewController release];
}

/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }
 */

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
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}



//////////
/*
 // Override to support row selection in the table view.
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
 // Navigation logic may go here -- for example, create and push another view controller.
 AnotherView *anotherViewController = [[AnotherView alloc] initWithNibName:@"AnotherView" bundle:nil];
 [self.navigationController pushViewController:anotherViewController animated:YES];
 [anotherViewController release];
 }
 */




- (void)dealloc {
    [super dealloc];
}


@end

