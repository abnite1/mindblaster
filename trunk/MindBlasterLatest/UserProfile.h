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
#import "Score.h"


@interface UserProfile : NSObject {
	NSString *userName;
	UIImage *profilePic;
	Score *score;
	int highestScore;
	Topic *currentTopic;
	Topic *lastTopicCompleted;			
	NSString *email;
	
}
@property (nonatomic, retain) Topic *currentTopic;
@property (nonatomic,retain) Topic *lastTopicCompleted;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) UIImage *profilePic;
@property (nonatomic,retain) Score *score;
@property (nonatomic) int highestScore;
		   

@end
