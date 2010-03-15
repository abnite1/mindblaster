//
//  MindBlasterAppDelegate.m
//
//  Created by Steven Verner on 2/21/10.
//	modified by john kehler (see .h)
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MindBlasterAppDelegate.h"


@implementation MindBlasterAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize currentUser;




- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    //GLOBAL USER PROFILE!
	currentUser = [[UserProfile alloc] init];
	
	
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


// release memory
- (void)dealloc {
	[navigationController release];
	[currentUser release];
	[window release];
	[super dealloc];
}


@end
