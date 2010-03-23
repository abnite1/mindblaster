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

+(void)initProfile
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
	char x='+';
	[temp setOperator:&x];
	[UIAppDelegate.currentUser setLastTopicCompleted:temp];
	
	[temp release];
	
	NSLog(@"Profile initialized\n");

}

+(BOOL)writeToFile
{
	NSMutableDictionary * prefs;
    prefs = [[NSMutableDictionary alloc] init];
	
	//IS THERE A PROFILE TO WRITE??
	if([UIAppDelegate.currentUser userName] == NULL && [[UIAppDelegate.currentUser score] score] == 0)
	{
		NSLog(@"There is not valid profile to save.\n");
		return NO;
	}
	
	
    [prefs setObject:[UIAppDelegate.currentUser userName] forKey:@"userName"];
	//last topic complete
	NSNumber *lastTopicCompletedDiff = [NSNumber numberWithInt:[[UIAppDelegate.currentUser lastTopicCompleted] difficulty]];
	NSNumber *LastTopicCompletedTopic = [NSNumber numberWithInt:[[UIAppDelegate.currentUser lastTopicCompleted] topic]];
	[prefs setObject:lastTopicCompletedDiff forKey:@"lastTopicCompletedDiff"];
	[prefs setObject:LastTopicCompletedTopic forKey:@"lastTopicCompletedTopic"];
	[prefs setObject:[[UIAppDelegate.currentUser lastTopicCompleted] description] forKey:@"lastTopicCompletedDescription"];
	
	//NEEDS FIXING!!!!
	NSNumber *operator = [NSNumber numberWithInt:(int)(*[[UIAppDelegate.currentUser lastTopicCompleted] operator])];
	//[operator initWithCharacters:(const unichar *)[[UIAppDelegate.currentUser lastTopicCompleted] operator] length:2];
	[prefs setObject:operator forKey:@"lastTopicCompletedOperator"];
	[operator release];
	
	
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
	{//profile pic is causing it to fail to write (even when NOT null)
		NSData *profilePicData = UIImagePNGRepresentation([UIAppDelegate.currentUser profilePic]);
		[prefs setObject:profilePicData forKey:@"profilePic"];
		[profilePicData release];
		//[prefs setObject:[UIAppDelegate.currentUser profilePic] forKey:@"profilePic"];
	}else
		NSLog(@"there is no profile pic associated with this account.\n");
	
	
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

+(BOOL)readFromFile
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
		[[UIAppDelegate.currentUser lastTopicCompleted] setDescription:[prefs2 objectForKey:@"lastTopicCompletedDescription"]];
		//READ THE OPERATOR AND DESCRIPTIONS
		Topic *lastTopic = [Topic new];
		[lastTopic setDifficulty:[lastTopicCompletedDiff intValue]];
		[lastTopic setTopic:[lastTopicCompletedTopic intValue]];
		[UIAppDelegate.currentUser setLastTopicCompleted:lastTopic];

		//MUST READ PROFILE PICTURE
		UIImage *profilePic = [UIImage new];
		[profilePic initWithData:[prefs2 objectForKey:@"profilePic"]];
		[UIAppDelegate.currentUser setProfilePic:profilePic];
		[profilePic release];
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
