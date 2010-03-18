//
//  LoadGameScreenController.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoadGameScreenController.h"



@implementation LoadGameScreenController

-(IBAction) helpScreen {
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

// this leads to another screen where the player loads a profile from the web server
// currently only a stub for the implementation to follow in phase II
-(IBAction) upload {
		// Navigation logic may go here -- for example, create and push another view controller.
	
	//temporarily this loads userprofile with data, to unlock higher levels.
	[UIAppDelegate.currentUser setUserName:@"Blanka"];
	Score *score = [Score new];
	[score setScore:9999];
	[UIAppDelegate.currentUser setScore:score];
	[UIAppDelegate.currentUser setEmail:@"jka37@sfu.ca"];
	Topic *current = [Topic new];
	[current setTopic:3];
	[current setDifficulty:3];
	Topic *last = [Topic new];
	[last setTopic:4];
	[last setDifficulty:4];
	[UIAppDelegate.currentUser setCurrentTopic:current];
	[UIAppDelegate.currentUser setLastTopicCompleted:last];
	
	TopicScreenController *topicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:topicView animated:YES];
	[topicView release];
}
-(IBAction) download {

	//SETUP A DISTINCT USERPROFILE
	UserProfile *temp = [UserProfile new];
	[temp setUserName:@"Ryu"];
	Score *score = [Score new];
	[score setScore:9999];
	[temp setScore:score];
	[temp setEmail:@"jka37@sfu.ca"];
	Topic *current = [Topic new];
	[current setTopic:3];
	[current setDifficulty:3];
	Topic *last = [Topic new];
	[last setTopic:4];
	[last setDifficulty:4];
	[temp setCurrentTopic:current];
	[temp setLastTopicCompleted:last];
	
	//SAVE IT TO PLIST
	NSMutableDictionary * prefs;
    prefs = [[NSMutableDictionary alloc] init];
    [prefs setObject:[temp userName] forKey:@"userName"];
	//try the pic later..
    [prefs setObject:[temp score] forKey:@"score"];
	[prefs setObject:[temp currentTopic] forKey:@"currentTopic"];
	[prefs setObject:[temp lastTopicCompleted] forKey:@"lastTopicCompleted"];
	[prefs setObject:[temp email] forKey:@"email"];
	
    // save our buddy list to the user's home directory/Library/Preferences.
    [prefs writeToFile:[@"~/userProfile.plist"
						stringByExpandingTildeInPath] atomically: TRUE];
	NSLog(@"Plist written\n");
	
	//release temp profile
	[temp release];
	
	
	//READ IT BACK TO PROFILE
	NSDictionary *prefs2;
    prefs2 = [NSDictionary dictionaryWithContentsOfFile: 
			 [@"~/userProfile.plist" 
			  stringByExpandingTildeInPath]];
	
	if (prefs2) {
		[UIAppDelegate.currentUser setUserName: [prefs2 objectForKey:@"userName"]];
		[UIAppDelegate.currentUser setScore:[prefs2 objectForKey:@"score"]];
		[UIAppDelegate.currentUser setCurrentTopic:[prefs2 objectForKey:@"currentTopic"]];
		[UIAppDelegate.currentUser setLastTopicCompleted:[prefs2 objectForKey:@"lastTopicCompleted"]];
		[UIAppDelegate.currentUser setEmail:[prefs2 objectForKey:@"email"]];
    } else {
		NSLog(@"ERROR with the plist\n");
	}	
	
	//CONFIRM IT CHANGED!!!
	NSLog(@"The name from the plist is %@ \n",[UIAppDelegate.currentUser userName]);
	NSLog(@"Score from plist: %d \n",[[UIAppDelegate.currentUser score] score]);
	NSLog(@"CurrentTopic is: %d \n",[[UIAppDelegate.currentUser currentTopic] topic]);
	NSLog(@"LastTopicCompleted is: %d \n",[[UIAppDelegate.currentUser lastTopicCompleted] topic]);
	NSLog(@"Email is : %@ \n",[UIAppDelegate.currentUser email]);
	
   	TopicScreenController *topicView = [[TopicScreenController alloc] initWithNibName:@"TopicScreenController" bundle:nil];
	[self.navigationController pushViewController:topicView animated:YES];
	[topicView release];
}

// go back to the previous screen
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
