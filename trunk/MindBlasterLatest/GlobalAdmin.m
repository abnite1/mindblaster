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

+(NSString *)getPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [NSString stringWithFormat:@"%@%@",[paths objectAtIndex:0],@"/userProfile.plist"];
	NSLog(@"The path is: %@ \n",path);
	return path;
}

+(void)initProfile
{
	[UIAppDelegate.currentUser setUserName:@"blank"];
	[UIAppDelegate.currentUser setEmail:@"blank"]; 
	[UIAppDelegate.currentUser setHighestScore:0];
	[UIAppDelegate.currentUser setScore:[[Score alloc] initWithScore:0]];
	Topic *temp = [Topic new];
	[temp setDifficulty:DIFFICULTY_EASIEST];
	[temp setTopic:TOPIC_ADDITION];
	[temp setDescription:@"blank"];
	[UIAppDelegate.currentUser setLastTopicCompleted:temp];
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
	
	//score
	NSNumber *score = [NSNumber numberWithInt:[[UIAppDelegate.currentUser score] score]];
	[prefs setObject:score forKey:@"score"];
	NSNumber *highestScore = [NSNumber numberWithInt:[UIAppDelegate.currentUser highestScore]];
	[prefs setObject:highestScore forKey:@"highestScore"];
	[prefs setObject:[UIAppDelegate.currentUser email] forKey:@"email"];
	
	//profilepicture:
/*	if([UIAppDelegate.currentUser profilePic] != NULL)
	{//profile pic is causing it to fail to write (even when NOT null)
		NSData *profilePicData = UIImagePNGRepresentation([UIAppDelegate.currentUser profilePic]);
		[prefs setObject:profilePicData forKey:@"profilePic"];
		[profilePicData release];
		//[prefs setObject:[UIAppDelegate.currentUser profilePic] forKey:@"profilePic"];
	}else
		NSLog(@"there is no profile pic associated with this account.\n");
	*/
	
	
	//WRITE TO plist
	NSString *path = [self getPath];
	NSLog(@"Writetofile path is: %@ \n",path);
    if([prefs writeToFile:[path
						   stringByExpandingTildeInPath] atomically: TRUE] == YES)
	{
		NSLog(@"Plist written\n");
		[prefs release];
		//[path release];  ****** I KNOW ITS MESSED UP BUT I DID TRIAL AND ERROR SEVERAL TIMES, if i release path, it crashes ...???? WHY
		return YES;
	}else{
		NSLog(@"ERROR Plist not written\n");
	  // [path release];
		[prefs release];
	}
	return NO;
	
}

+(BOOL)readFromFile
{
	//READ IT BACK TO PROFILE
	NSDictionary *prefs2;
	NSString *path = [self getPath];
	//CHECKING IF FILE EXISTS: this works (doesn't crash)
	if([[NSFileManager defaultManager] fileExistsAtPath:[path stringByExpandingTildeInPath]] == NO)
	{
		NSLog(@"No profile exists\n");
		//[paths release];
		//[path release];
		return NO;
	}else
		NSLog(@"The profile exists\n");
	
	prefs2 = [NSDictionary dictionaryWithContentsOfFile:[path stringByExpandingTildeInPath]];

	if (prefs2) {
		[UIAppDelegate.currentUser setUserName: [[NSString alloc] initWithString:[prefs2 objectForKey:@"userName"]]];
		
		NSNumber *lastTopicCompletedDiff = [prefs2 objectForKey:@"lastTopicCompletedDiff"];
		NSNumber *lastTopicCompletedTopic = [prefs2 objectForKey:@"lastTopicCompletedTopic"];	
		[[UIAppDelegate.currentUser lastTopicCompleted] setDescription:[prefs2 objectForKey:@"lastTopicCompletedDescription"]];
		//READ THE OPERATOR AND DESCRIPTIONS
		Topic *lastTopic = [Topic new];
		[lastTopic setDifficulty:[lastTopicCompletedDiff intValue]];
		[lastTopic setTopic:[lastTopicCompletedTopic intValue]];
		[UIAppDelegate.currentUser setLastTopicCompleted:lastTopic];

		/*[UIAppDelegate.currentUser setLastTopicCompleted:[[Topic alloc] initWithTopic:[[prefs2 objectForKey:@"lastTopicCompletedTopic"] intValue]]];	// possible memory leak
		NSString *msg = [[NSString alloc] initWithFormat:[prefs2 objectForKey:@"lastTopicCompletedDescription"]];
		[UIAppDelegate.currentUser.lastTopicCompleted setDescription:msg];
		//[label setText:msg];
		[msg release];*/
		//[UIAppDelegate.currentUser.currentTopic setOperator:(char*)'+'];

		//MUST READ PROFILE PICTURE
		//UIImage *profilePic = [UIImage new];
		//[profilePic initWithData:[prefs2 objectForKey:@"profilePic"]];
		//[UIAppDelegate.currentUser setProfilePic:profilePic];
		//[profilePic release];
		
		//score
		Score *score = [Score new];
		[score setScore: [[prefs2 objectForKey:@"score"] intValue]];
		[UIAppDelegate.currentUser setScore:score];
		[UIAppDelegate.currentUser setHighestScore:[[prefs2 objectForKey:@"highestScore"] intValue]];
		[UIAppDelegate.currentUser setEmail:[[NSString alloc] initWithString:[prefs2 objectForKey:@"email"]]];
		return YES;
    } else {
		NSLog(@"ERROR with the plist\n");
		return NO;
	}	
	
}

@end
