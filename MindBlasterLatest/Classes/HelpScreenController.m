//
//  HelpScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Modified by Yaniv Haramati on 3/28/10 to respond to each screen individually with a respondToScreenname function.
//  Help scripts added by John Kehler.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HelpScreenController.h"


@implementation HelpScreenController
@synthesize text, titleLabel;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[text setEditable:NO];
	
	NSLog(@"parent: %@", [self.navigationController title]);
	
	// identify the parent and respond accordingly
	NSString *parent = [self.navigationController title];
	
	if ([parent isEqualToString: @"rootView"]) {
		[titleLabel setText: @"Main Menu"];
		[self respondToRoot];
	}
	else if ([parent isEqualToString: @"topicView"]) {
		[titleLabel setText: @"Topic Selection Menu"];
		[self respondToTopic];
	}
	else if ([parent isEqualToString: @"characterView"]) {
		[titleLabel setText: @"Character Selection Menu"];
		[self respondToCharacter];
	}
	else if ([parent isEqualToString: @"difficultyView"]) {
		[titleLabel setText: @"Difficulty Selection Menu"];
		[self respondToDifficulty];
	}
	else if ([parent isEqualToString: @"usernameView"]) {
		[titleLabel setText: @"User Name Selection Menu"];
		[self respondToUsername];
	}
	else if ([parent isEqualToString: @"networkView"]) {
		[titleLabel setText: @"Load/Save Game Menu"];
		[self respondToNetwork];
	}
	else if ([parent isEqualToString: @"gameScreenView"]) {
		[titleLabel setText: @"Game Screen"];
		[self respondToGameScreen];
	}
	else if ([parent isEqualToString: @"gameOverView"]) {
		[titleLabel setText: @"Gameover Menu"];
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
	
	[[UIApplication sharedApplication] setStatusBarHidden: YES animated: NO];
	
}

- (void) viewWillDisappear:(BOOL)animated {
	
	// play button click
	[MindBlasterAppDelegate playButtonClick];
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
 
	[text setText: @"\n\n"
	 
					 "[Continue] (with existing profile).\n\n"
	 
					 "[New Game] -	Create a new profile and start a new game.\n\n"
	 
					 "[Load Game] -	Load or a save your profile online."];
}

// change label to respond to parent
-(void) respondToTopic {
	[text setText: @"\n\n"
	 
					"Choose a topic by touching any of the available options then press OK to continue.\n\n"
	 
					"[+]		Addition\n"
					"[-]		Subtrction\n"
					"[x]		Multiplication\n"
					"[/]		Division\n\n"
	 
					"[OK] - Continue to the next menu.\n"
					"[BACK] - Go back to the previous menu."];
}

// change label to respond to parent
-(void) respondToCharacter {
	[text setText: @"\n\n"
	 
					"Select your profile character by touching any of the available pictures.\n\n"
	 
					"[BACK] - Go back to the previous menu."];
}

// change label to respond to parent
-(void) respondToDifficulty {
	[text setText: @"\n\n"
					
					"Select a difficulty by touching any of the available options then press OK to continue. \n\n"
					
					"[EASIEST]	- Operand range between 0 and 10.\n\n"
	 
					"[EASY]		- Operand range between 0 and 20.\n\n"
	 
					"[HARD]		- Operand range between 0 and 30.\n\n"
	 
					"[HARDEST]	- Operand range between 0 and 40.\n\n"
	 
					"[OK] - Continue to the next menu.\n"
					"[BACK] - Go back to the previous menu."];
}

// change label to respond to parent
-(void) respondToUsername {
	[text setText: @"\n\n"
					
					"Touch the empty text boxes to enter your profile name and email then press OK to continue.\n\n"
	 
					"[OK] - Continue to the next menu.\n"
					
					"[BACK] - Go back to the previous menu."];
}

// change label to respond to parent
-(void) respondToNetwork {
	[text setText: @"\n\n"
	 
	 			"[UPLOAD]		- Save your progress to the website.\n\n"
	 
				"[DOWNLOAD]	- Get your profile from the website. \n\n"
	 
				"[BACK] - Return to the previous menu."];
}

// change label to respond to parent
-(void) respondToGameScreen {
	[text setText: @"\n\n"
	 
					"----- SCREEN LAYOUT -----\n\n"
	 
					"The top of the screen (from left to right) shows your CHARACTER PICTURE, CURRENT DIFFICULTY, PAUSE BUTTON, LIVES REMAINING and YOUR SCORE.  Below your LIVES"
					"REMAINING is your SHIELD BAR which shows how much shields you have on your current life\n\n"
	 
					"In the center of your screen is your SHIP\n\n"
	 
					"The left side is the ROTATION WHEEL, which rotates your ship\n\n"
	 
					"The right side is the FIRE BUTTON, which fires your ships lasers\n\n"
	 
					"The bottom center is the QUESTION you have to answer and under that is how much time you've spent on the current topic.\n\n"
	 
					"The top right is the help button, which you obviously know or you wouldn't be reading this\n\n"
	
					"----- HOW TO PLAY -----\n\n"
	 
					"You should shoot the asteroid that has the answer to the QUESTION shown in the bottom middle.\n"
					"If you get hit by asteroids, you will lose shield power.  When you have no shields getting hit by an asteroid will make you lose the game.\n"
					"If you shoot blank asteroids you get 1 points.\n"
					"If you shoot the correct asteroid you get 10 points\n"
					"If you shoot the wrong asteroid you lose 5 points and if you have less than 0 points you lose the game\n\n"
					
					"For every 100 points you will go to the next difficulty.\n"
					"For every 400 points you will go to the next topic.\n"
					];
}

// change label to respond to parent
-(void) respondToGameOver {
	[text setText: @"\n\n"
	
					"[TRY AGAIN]		- Returns to the game, just where you left off with full lives and shield.\n"
					"[CHANGE TOPIC]	- Go to the topic selection menu and choose another topic.\n"
					"[MAIN MENU]		- Go back to the main menu"];
}


- (void)dealloc {
    [super dealloc];
}


@end
