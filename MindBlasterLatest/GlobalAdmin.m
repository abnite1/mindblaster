//
//  GlobalAdmin.m
//  MindBlaster
//
//  Created by John Kehler on 3/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GlobalAdmin.h"
#import "MindBlasterAppDelegate.h"

@implementation GlobalAdmin

// returns the absolute path of the UserProfile.plist
// from the relative Document directory
+(NSString *)getPath {
	
	// get the relative ~/Documents path and append our property file name to it
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* docDir = [paths objectAtIndex:0];
	NSString *path = [docDir stringByAppendingPathComponent:@"UserProfile.plist"];
	
	//NSLog(@"The path is: %@ \n",path);
	return path;
}

// initialize AppDelegate profile to default settings
+(void)initProfile {
	
	// initialize user name
	[UIAppDelegate.currentUser setUserName:@"blank"];
	
	// initialize email
	[UIAppDelegate.currentUser setEmail:@"blank"]; 
	
	// initialize current score
	Score *zero = [[Score alloc] initWithScore: 0];
	[UIAppDelegate.currentUser setScore: zero];
	
	// initialize highest score
	[UIAppDelegate.currentUser setHighestScore: zero];
	
	[zero release];
	
	// set the current topic (difficulty is set to EASIEST with this init function)
	Topic *topic = [[Topic alloc] initWithTopic: TOPIC_ADDITION];
	[topic initOperator];
	[topic initDescription];

	// set the current and lastCompleted topics to their base value
	[UIAppDelegate.currentUser setCurrentTopic: topic];
	[UIAppDelegate.currentUser setLastTopicCompleted: topic];
	
	[topic release];
	
	NSLog(@"AppDelegate profile initialized.");
	
	if (! [self saveSettings]) NSLog(@"Failed to save settings after initializing AppDelegate profile.");
	else NSLog(@"Profile initialized and saved to plist");
}

// save AppDelegate settings to property list
+(BOOL)saveSettings {
	
	// set up mutable dictionary to write to
	NSString *path = [self getPath];
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] init];
	
	
	// check if the AppDelegate profile is set before attempting to save it to plist
	if([UIAppDelegate.currentUser userName] == NULL && [[UIAppDelegate.currentUser score] score] == 0)
	{
		NSLog(@"There is not a valid AppDelegate profile to save.\n");
		return NO;
	}
	
	// save the user name
    [prefs setObject: [UIAppDelegate.currentUser userName] forKey: @"UserName"];
	
	// save the profile email
	[prefs setObject: [UIAppDelegate.currentUser email] forKey: @"Email"];
	
	// save the user profile pic
	[prefs setObject: [NSNumber numberWithInt: [UIAppDelegate.currentUser profilePic]]
				  forKey: @"Picture"];
	
	// save the score
	[prefs setObject: [NSNumber numberWithInt: [UIAppDelegate.currentUser.score score]] 
				  forKey: @"Score"];
	
	// save the current score as highest score if it's greater than the one in the plist profile
	int score = [UIAppDelegate.currentUser.score score];
	int highestScore = [[prefs objectForKey: @"HighestScore"] intValue];
	if (score >= highestScore) {
		
		[prefs setObject: [NSNumber numberWithInt: [UIAppDelegate.currentUser.highestScore score]] 
					forKey: @"HighestScore"];
		[UIAppDelegate.currentUser.highestScore setScore: score];
	}
	
	// save the current topic and the current topic difficulty
	[prefs setObject: [NSNumber numberWithInt: [UIAppDelegate.currentUser.currentTopic topic]] 
				  forKey: @"CurrentTopic"];
	
	[prefs setObject: [NSNumber numberWithInt: [UIAppDelegate.currentUser.currentTopic difficulty]] 
				  forKey: @"CurrentTopicDifficulty"];
	
	// save the lastCompletedTopic (highest topic completed) and difficulty
	[prefs setObject: [NSNumber numberWithInt: [UIAppDelegate.currentUser.lastTopicCompleted topic]] 
				  forKey: @"HighestTopic"];
	
	[prefs setObject: [NSNumber numberWithInt: [UIAppDelegate.currentUser.lastTopicCompleted difficulty]] 
				  forKey: @"HighestTopicDifficulty"];
	
	
	// for debug
	NSLog(@"Writetofile path is: %@ \n", path);
	
	// write the dictionary values to the .plist file
    if( ! [prefs writeToFile: path atomically: YES]) {
		
		NSLog(@"ERROR while trying to write profile to .plist\n");
		return NO;
	}
	
	// successfully written to file
	return YES;
}

// read a profile from .plist and return YES.
// @return NO if it doesn't exist.
+(BOOL)loadSettings {

	// get te ~/Documents/ path
	NSString *path = [self getPath];
	
	// if userProfile.plist doesn't exist in the ~/Documents/ directory
	if (! [[NSFileManager defaultManager] fileExistsAtPath: path]) {
		NSLog(@"No profile exists\n");
		return NO;
	}else
		NSLog(@"The profile exists\n");
	
	// read the plist into a dictionary
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile: path];

	// if we can access the profile
	// load all its properties to the UIAppDelegate
	if (prefs) {
		
		// load the user name
		[UIAppDelegate.currentUser setUserName: [prefs objectForKey: @"UserName"]];
		
		// load email
		[UIAppDelegate.currentUser setEmail: [prefs objectForKey: @"Email"]];
		
		// load profile pic
		[UIAppDelegate.currentUser setProfilePic: [[prefs objectForKey: @"Picture"] intValue]];
		
		// load the current score 
		Score *scoreCurrent = [[Score alloc] initWithScore: [[prefs objectForKey: @"Score"] intValue]];
		[UIAppDelegate.currentUser setScore: scoreCurrent];
		
		// load the highest score
		Score *scoreHighest = [[Score alloc] initWithScore:  [[prefs objectForKey: @"HighestScore"] intValue]];
		[UIAppDelegate.currentUser setHighestScore: scoreHighest];
		
		[scoreCurrent release];
		[scoreHighest release];
		
		// load the current topic
		int top = [[prefs objectForKey: @"CurrentTopic"] intValue];
		int diff = [[prefs objectForKey: @"CurrentTopicDifficulty"] intValue];
		Topic *topic = [[Topic alloc] initWithTopic: top];
		[topic setDifficulty: diff];
		[UIAppDelegate.currentUser setCurrentTopic: topic];
		
		// load the highest topic completed	
		int topInt = [[prefs objectForKey: @"HighestTopic"] intValue];
		int diffInt = [[prefs objectForKey: @"HighestTopicDifficulty"] intValue];
		[topic setTopic: topInt];
		[topic setDifficulty: diffInt];
		[UIAppDelegate.currentUser setLastTopicCompleted: topic];
		
		[topic release];
		
		// all settings successfully loaded to AppDelegate
		return YES;
   }
	
	// if we can't read the profile plist, return with error.
	else {
		
		NSLog(@"ERROR couldn't read UserProfile.plist \n");
		return NO;
	}	
}

// returns the picture at array location
+(id) getPic:(int)position {
	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	
	NSArray *pics = [[NSArray alloc] initWithObjects: 
					 [UIImage imageWithContentsOfFile: [path stringByAppendingPathComponent:@"boy.png"]], 
					 [UIImage imageWithContentsOfFile: [path stringByAppendingPathComponent:@"girl.png"]], 
					 [UIImage imageWithContentsOfFile: [path stringByAppendingPathComponent:@"dog.png"]],
					 [UIImage imageWithContentsOfFile: [path stringByAppendingPathComponent:@"cat.png"]], nil];
	
	return [pics objectAtIndex: position];
}

// returns the save and load URL
+(NSString*)getURL {
	
	// read the general settings plist into a dictionary
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalPath = [path stringByAppendingPathComponent: @"ApplicationSettings.plist"];
	NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
	
	return (NSString*)[plistData objectForKey:@"WebURL"];
}

// returns the DB upload update url
+(NSString*)getUploadUpdateURL {
	
	// read the general settings plist into a dictionary
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalPath = [path stringByAppendingPathComponent: @"ApplicationSettings.plist"];
	NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile: finalPath];
	NSString *result = [plistData objectForKey:@"UploadUpdateURL"];
	NSLog(@"dbUploadUpdateURL: %@", result);
	return [plistData objectForKey:@"UploadUpdateURL"];
}

// returns the DB download update url
+(NSString*)getDownloadUpdateURL {
	
	// read the general settings plist into a dictionary
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalPath = [path stringByAppendingPathComponent: @"ApplicationSettings.plist"];
	NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile: finalPath];
	
	NSString *result = [plistData objectForKey:@"DownloadUpdateURL"];
	//NSLog(@"user email: %@", [UIAppDelegate.currentUser email]);
	//NSString *result = [tempString stringByAppendingPathComponent: [UIAppDelegate.currentUser email]];
	NSLog(@"dbDownloadUpdateURL: %@", result);
	return result;
}


@end
