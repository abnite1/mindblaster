//
//  UserProfile.m
//  MindBlaster
//
//  Created by John Kehler on 3/6/10.
//  Restructured by yaniv haramati on 12/03/10
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//  


#import "UserProfile.h"

@implementation UserProfile
@synthesize currentTopic, lastTopicCompleted, 
			userName, profilePic, score, highestScore, email;

// updates the highestScore if the player has surpassed it
-(IBAction) checkHighestScore {
	
	// if the current score is higher than highestScore
	if ([score score] > [highestScore score]) {
		
		// update the highest score
		[highestScore setScore: [score score]];
		
	}
}

// returns a string representation of the profile's current user attributes
-(void) userLog {
	
	// for testing, show selected topic properties:
	NSLog(@"userName is: %@ \n", userName);
	NSLog(@"email is: %@ \n", email);
	NSLog(@"currentTopic.topic is: %d \n", currentTopic.topic);
	NSLog(@"currentTopic.difficulty is: %d \n", currentTopic.difficulty);
	NSLog(@"currentTopic.description is: %@ \n", currentTopic.description);
	NSLog(@"lastTopicCompleted.topic is: %d \n", lastTopicCompleted.topic);
	NSLog(@"lastTopicCompleted.diffficulty is: %d \n", lastTopicCompleted.difficulty);
	NSLog(@"lastTopicCompleted.description is: %@ \n", lastTopicCompleted.description);
	NSLog(@"score is: %d \n", score.score);
	NSLog(@"highestScore is: %d \n", highestScore.score);
}

@end