//
//  MindBlasterAppDelegate.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MindBlasterAppDelegate.h"


@implementation MindBlasterAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize currentUser;


#pragma mark -
#pragma mark Application lifecycle





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


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[currentUser release];
	[window release];
	[super dealloc];
}


@end

