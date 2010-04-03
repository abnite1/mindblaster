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

// plays a menu button click
+ (void) playButtonClick {
	
	NSArray *buttonFile = [BUTTON_CLICK_1 componentsSeparatedByString: @"."];
	NSString *buttonFilePath = [[NSBundle mainBundle] pathForResource: [buttonFile objectAtIndex: 0] ofType: [buttonFile objectAtIndex: 1]];
	NSURL *audioFileURL = [NSURL fileURLWithPath: buttonFilePath];
	AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: audioFileURL error: nil];
	NSLog(@"playing button click");
	
	[audioPlayer prepareToPlay];
	[audioPlayer play];

}

// plays a menu button click
+ (void) playInsideClick {
	
	NSArray *buttonFile = [BUTTON_CLICK_3 componentsSeparatedByString: @"."];
	NSString *buttonFilePath = [[NSBundle mainBundle] pathForResource: [buttonFile objectAtIndex: 0] ofType: [buttonFile objectAtIndex: 1]];
	NSURL *audioFileURL = [NSURL fileURLWithPath: buttonFilePath];
	AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: audioFileURL error: nil];
	NSLog(@"playing button click");
	
	[audioPlayer prepareToPlay];
	[audioPlayer play];
	
}

// delegate function to take effect when player finishes playing
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	
	if (flag) NSLog(@"finished playing successfully.");
	else NSLog(@"Error while playing.");

	[player release];
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

