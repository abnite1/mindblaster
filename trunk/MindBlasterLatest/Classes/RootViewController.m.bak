//
//  RootViewController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "CharacterScreenController.h"
#import "LoadGameScreenController.h"
#import "HelpScreenController.h"
#import "Ball.h"

@implementation RootViewController
@synthesize mBall;

-(IBAction) HelpScreen
{
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}
- (IBAction) NextScreen
{
    // Navigation logic may go here -- for example, create and push another view controller.
	CharacterScreenController *characterView = [[CharacterScreenController alloc] initWithNibName:@"CharacterScreenController" bundle:nil];
	[self.navigationController pushViewController:characterView animated:YES];
	[characterView release];
}
- (IBAction) LoadGame
{
    // Navigation logic may go here -- for example, create and push another view controller.
	LoadGameScreenController *loadGameView = [[LoadGameScreenController alloc] initWithNibName:@"LoadGameScreenController" bundle:nil];
	[self.navigationController pushViewController:loadGameView animated:YES];
	[loadGameView release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:TRUE animated: NO ];
	
	[NSTimer scheduledTimerWithTimeInterval:0.001 target:self
								   selector:@selector(moveBall) userInfo:nil repeats:YES];
	[mBall setSpeedX:0.2 Y:0.2];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)moveBall
{
	[mBall move];
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


// override to allow orientations other than the default portrait orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
    [super dealloc];
	[mBall dealloc];
}


@end

