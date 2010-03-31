//
//  HelpScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Modified by Yaniv Haramati on 3/28/10 to respond to each parent individually.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HelpScreenController.h"


@implementation HelpScreenController
@synthesize help;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSLog(@"parent: %@", [self.navigationController title]);
	
	// identify the parent and respond accordingly
	NSString *parent = [self.navigationController title];
	
	if ([parent isEqualToString: @"rootView"]) {
		[self respondToRoot];
	}
	else if ([parent isEqualToString: @"topicView"]) {
		[self respondToTopic];
	}
	else if ([parent isEqualToString: @"characterView"]) {
		[self respondToCharacter];
	}
	else if ([parent isEqualToString: @"difficultyView"]) {
		[self respondToDifficulty];
	}
	else if ([parent isEqualToString: @"usernameView"]) {
		[self respondToUsername];
	}
	else if ([parent isEqualToString: @"networkView"]) {
		[self respondToNetwork];
	}
	else if ([parent isEqualToString: @"gameScreenView"]) {
		[self respondToGameScreen];
	}
	else if ([parent isEqualToString: @"gameOverView"]) {
		[self respondToGameOver];
	}
	
}

// delegate function that runs every time the view returns from "back" of another screen
- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
	NSLog(@"help view will appear.");
}


// delegate function that runs every time the view returns from "back" of another screen
- (void)viewDidAppear:(BOOL)animated {
    
	[super viewDidAppear:animated];
	NSLog(@"help view did appear.");
	[self.navigationController setTitle: @"helpView"];
	
}

- (IBAction) backScreen {
	[self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction) quit {
	[self.navigationController popToRootViewControllerAnimated:YES];
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

// change label to respond to parent
-(void) respondToRoot {
	[help setText: @"replace with script for root"];
}

// change label to respond to parent
-(void) respondToTopic {
	[help setText: @"replace with script for topic"];
}

// change label to respond to parent
-(void) respondToCharacter {
	[help setText: @"replace with script for character"];
}

// change label to respond to parent
-(void) respondToDifficulty {
	[help setText: @"replace with script for difficulty"];
}

// change label to respond to parent
-(void) respondToUsername {
	[help setText: @"replace with script for username"];
}

// change label to respond to parent
-(void) respondToNetwork {
	[help setText: @"replace with script for network"];
}

// change label to respond to parent
-(void) respondToGameScreen {
	[help setText: @"replace with script for gamescreen"];
}

// change label to respond to parent
-(void) respondToGameOver {
	[help setText: @"replace with script for gameover"];
}


- (void)dealloc {
    [super dealloc];
}


@end
