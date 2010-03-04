//
//  MindBlasterAppDelegate.m
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MindBlasterAppDelegate.h"
#import "RootViewController.h"

@implementation MindBlasterAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
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
	[window release];
	[super dealloc];
}


@end

