//
//  MindBlasterAppDelegate.m
//
//  Created by Steven Verner on 2/21/10.
//	modified by john kehler (see .h)
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MindBlasterAppDelegate.h"
#import "GlobalAdmin.h"

//@interface MindBlasterAppDelegate ()

//@end

@implementation MindBlasterAppDelegate

@synthesize networkingCount;
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
	
	NSLog(@"start of AppDelegate didStartNetworking");
	self.networkingCount += 1;
	NSLog(@"end of AppDelegate didStartNetworking");
}

-(void) didStopNetworking {
	
	NSLog(@"start of AppDelegate didStopNetworking");
	assert(self.networkingCount > 0);
    self.networkingCount -= 1;
	
	NSLog(@"end of AppDelegate didStopNetworking");
}

// release memory
- (void)dealloc {
	[navigationController release];
	[currentUser release];
	[window release];
	[super dealloc];
}


@end

