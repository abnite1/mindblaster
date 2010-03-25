//
//  MindBlasterAppDelegate.m
//
//  Created by Steven Verner on 2/21/10.
//	modified by john kehler (see .h)
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MindBlasterAppDelegate.h"
#import "GlobalAdmin.h"

@implementation MindBlasterAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize currentUser;


// executed when user quit the app
- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	// the AppDelegate profile
	currentUser = [[UserProfile alloc] init];

	
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	
	// Save userprofile to plist
	[GlobalAdmin saveSettings];
}

-(void) didStartNetworking {
	
}

-(void) didStopNetworking {
	
}

// release memory
- (void)dealloc {
	[navigationController release];
	[currentUser release];
	[window release];
	[super dealloc];
}


@end

