//
//  UserProfile.h
//  MindBlaster
//
//  Created by John Kehler on 3/6/10.
//  Restructured by yaniv haramati on 12/03/10 : removed properites and redundant get/set functions
//  that are automatically created by @synthesize
//  also added static constants.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 * The user profile is where the player's details and game progress information are stored
 * the player's chosen picture, last completed topic, highest score, last completed difficulty level, 
 * name and email.
 * changing information stored in the user profile can be done through the MindBlasterAppDelegate class
 */
#import <Foundation/Foundation.h>
#import "Topic.h"


// defined constants representing difficulty types
static const int DIFFICULTY_EASIEST = 1;
static const int DIFFICULTY_EASY	= 2;
static const int DIFFICULTY_HARD	= 3;
static const int DIFFICULTY_HARDEST = 4;

// this constant is the multiplier that determines the number of points necessary to transition to the next difficulty level
// during gameplay
static const int DIFFICULTY_LIMIT = 100;


@interface UserProfile : NSObject {
	NSString *userName;
	UIImage *profilePic;
	int score;
	Topic *currentTopic;
	Topic *lastTopicCompleted;			
	int currentDifficulty;
	NSString *email;
}
@property (nonatomic, retain) Topic *currentTopic;
@property (nonatomic,retain) Topic *lastTopicCompleted;
@property (nonatomic) int currentDifficulty;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) UIImage *profilePic;
@property (nonatomic) int score;
		   

@end
