//
//  HelpScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Modified by Yaniv Haramati on 3/28/10 to respond to each parent-screen individually.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HelpScreenController.h"


@implementation HelpScreenController
@synthesize text;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[text setEditable:NO];
	
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
 
	[text setText: @"INTRO SCREEN HELP\n\n"
	 
					 "New Game -	Create a new account and start a new game\n\n"
	 
					 "Load Game -	Load existing account and game"];
}

// change label to respond to parent
-(void) respondToTopic {
	[text setText: @"TOPIC SCREEN HELP\n\n"
	 
					"Touch the symbol of the topic you want to practice here:\n\n"
	 
					"+		- addition\n"
					"-		- subtrction\n"
					"x		- multiplication\n"
					"/		- division\n\n"
	 
					"OK - Play the topic you chose\n"
					"BACK - Go back and choose another name/email"];
}

// change label to respond to parent
-(void) respondToCharacter {
	[text setText: @"CHARACTER SCREEN HELP\n\n"
	 
					"Touch the character you wish to be\n\n"
	 
					"BACK - Go back to the intro screen"];
}

// change label to respond to parent
-(void) respondToDifficulty {
	[text setText: @"DIFFICULTY SCREEN HELP\n\n"
					
					"Touch the button of the difficulty you will play\n\n"
					
					"EASIEST	- the questions only have numbers between 0 and 10\n\n"
	 
					"EASY		- the questions only have numbers between 0 and 20\n\n"
	 
					"HARD		- the questions only have numbers between 0 and 30\n\n"
	 
					"HARDEST	- the questions only have numbers between 0 and 40\n\n"
	 
					"OK - Play the difficulty you chose\n"
					"BACK - Go back and change you topic you chose"];
}

// change label to respond to parent
-(void) respondToUsername {
	[text setText: @"USERNAME SCREEN HELP\n\n"
					
					"Touch the empty boxes to type in your name and email address\n\n"
	 
					"OK - continue and use the name and email you typed in\n\n"
	 
					"BACK - Go back and choose another profile picture"];
}

// change label to respond to parent
-(void) respondToNetwork {
	[text setText: @"LOADGAME SCREEN HELP\n\n"
	 
	 			"UPLOAD		- Save your progress to the website (to keep it safe, or to download it to your friends iPhone)\n\n"
	 
	 "DOWNLOAD	- Get your profile from the website (NOTE: the current profile on this iPhone will be lost)\n\n"
	 
	 "BACK - Go back to the intro screen"];
}

// change label to respond to parent
-(void) respondToGameScreen {
	[text setText: @"GAMESCREEN HELP\n\n"
	 
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
					"If you shoot blank asteroids you get XX points.\n"
					"If you shoot the correct asteroid you get XX points\n"
					"If you shoot the wrong asteroid you lose XX points and if you have less than 0 points you lose the game\n\n"
					
					"For every XX points you will go to the next difficulty.\n"
					"For every XX points you will go to the next topic.\n"
					];
}

// change label to respond to parent
-(void) respondToGameOver {
	[text setText: @"GAMEOVER SCREEN HELP\n\n"
	
					"TRY AGAIN		- play the game again from the last topic and difficulty you achieved\n"
					"CHANGE TOPIC	- go to the topic screen and choose another topic to play\n"
					"MAIN MENU		- go back to the intro screen"];
}


- (void)dealloc {
    [super dealloc];
}


@end
