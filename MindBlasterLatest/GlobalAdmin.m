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

-(void)initProfile
{
	[UIAppDelegate.currentUser setUserName:@"blank"];
	[UIAppDelegate.currentUser setEmail:@"blank"]; 
	[UIAppDelegate.currentUser setHighestScore:0];
	Score *score = [Score new];
	[score setScore:0];
	[UIAppDelegate.currentUser setScore:score];
	[score release];
	Topic *temp = [Topic new];
	[temp setDifficulty:DIFFICULTY_EASIEST];
	[temp setTopic:TOPIC_ADDITION];
	[temp setDescription:@"blank"];
	//char x='+';
	//[temp setOperator:&x];
	[UIAppDelegate.currentUser setLastTopicCompleted:temp];
	
	[temp release];
	
	NSLog(@"Profile initialized\n");

}

-(BOOL)writeToFile
{
	//SAVE IT TO PLIST
	NSMutableDictionary * prefs;
    prefs = [[NSMutableDictionary alloc] init];
	
	if([UIAppDelegate.currentUser userName] == NULL && [[UIAppDelegate.currentUser score] score] == 0)
	{
		NSLog(@"There is not valid profile to save.\n");
		return NO;
	}
	
    [prefs setObject:[UIAppDelegate.currentUser userName] forKey:@"userName"];
	
//	//last topic complete
	NSNumber *lastTopicCompletedDiff = [NSNumber numberWithInt:[[UIAppDelegate.currentUser lastTopicCompleted] difficulty]];
	NSNumber *LastTopicCompletedTopic = [NSNumber numberWithInt:[[UIAppDelegate.currentUser lastTopicCompleted] topic]];
	[prefs setObject:lastTopicCompletedDiff forKey:@"lastTopicCompletedDiff"];
	[prefs setObject:LastTopicCompletedTopic forKey:@"lastTopicCompletedTopic"];
	[prefs setObject:[[UIAppDelegate.currentUser lastTopicCompleted] description] forKey:@"lastTopicCompletedDescription"];
	//MUST WRITE THE OPERATOR
	[lastTopicCompletedDiff release];
	[LastTopicCompletedTopic release];
 
	//score
	NSNumber *score = [NSNumber numberWithInt:[[UIAppDelegate.currentUser score] score]];
	[prefs setObject:score forKey:@"score"];
	[score release];
	NSNumber *highestScore = [NSNumber numberWithInt:[UIAppDelegate.currentUser highestScore]];
	[prefs setObject:highestScore forKey:@"highestScore"];
	[highestScore release];
	
	[prefs setObject:[UIAppDelegate.currentUser email] forKey:@"email"];
	
	//profilepicture:
	if([UIAppDelegate.currentUser profilePic] != NULL)
	{
		[prefs setObject:[UIAppDelegate.currentUser profilePic] forKey:@"profilePic"];
	}else
		NSLog(@"there is no profile pic associated with this account.\n");
	
	
	//CHECK THAT NO ELEMENTS OF DICTIONARY ARE NULL
	
    // save our buddy list to the user's home directory/Library/Preferences.
    if([prefs writeToFile:[@"~/Documents/userProfile.plist"
						   stringByExpandingTildeInPath] atomically: TRUE] == YES)
	{
		NSLog(@"Plist written\n");
		return YES;
	}else
		NSLog(@"ERROR Plist not written\n");
	return NO;
	
}

-(BOOL)readFromFile
{
	//READ IT BACK TO PROFILE
	NSDictionary *prefs2;
    prefs2 = [NSDictionary dictionaryWithContentsOfFile: 
			  [@"~/Documents/userProfile.plist" 
			   stringByExpandingTildeInPath]];
	
	if (prefs2) {
		[UIAppDelegate.currentUser setUserName: [prefs2 objectForKey:@"userName"]];
		
		NSNumber *lastTopicCompletedDiff = [prefs2 objectForKey:@"lastTopicCompletedDiff"];
		NSNumber *lastTopicCompletedTopic = [prefs2 objectForKey:@"lastTopicCompletedTopic"];	
		Topic *lastTopic = [Topic new];
		[lastTopic setDifficulty:[lastTopicCompletedDiff intValue]];
		[lastTopic setTopic:[lastTopicCompletedTopic intValue]];
		[UIAppDelegate.currentUser setLastTopicCompleted:lastTopic];

		//score
		Score *score = [Score new];
		[score setScore: [[prefs2 objectForKey:@"score"] intValue]]
		;
		[UIAppDelegate.currentUser setScore:score];
		[score release];
		//highestscore
		[UIAppDelegate.currentUser setHighestScore:[[prefs2 objectForKey:@"highestScore"] intValue]];
		
		[UIAppDelegate.currentUser setEmail:[prefs2 objectForKey:@"email"]];
		
		[lastTopicCompletedDiff release];
		[lastTopicCompletedTopic release];
		return YES;
    } else {
		NSLog(@"ERROR with the plist\n");
		return NO;
	}	
	
}

@end
