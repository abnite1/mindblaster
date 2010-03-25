//
//  UserProfile.m
//  MindBlaster
//
//  Created by John Kehler on 3/6/10.
//  Restructured by yaniv haramati on 12/03/10
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//  
//  steve's test

#import "UserProfile.h"

@implementation UserProfile
@synthesize currentTopic, lastTopicCompleted, 
			userName, profilePic, score, highestScore, email;

// updates the highestScore if the player has surpassed it
-(IBAction) checkHighestScore {
	
	// if the current score is higher than highestScore
	if ([score score] > highestScore) {
		
		// update the highest score
		highestScore = [score score];
		
	}
}

@end