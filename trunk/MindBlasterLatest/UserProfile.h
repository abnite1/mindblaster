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

static const int PICTURE_BOY	= 0;
static const int PICTURE_GIRL	= 1;
static const int PICTURE_DOG	= 2;
static const int PICTURE_CAT	= 3;


@interface UserProfile : NSObject {
	
	NSString	*userName;
	int			profilePic;
	Score		*score;
	Score		*highestScore;
	Topic		*currentTopic;
	Topic		*lastTopicCompleted;			
	NSString	*email;
	
}
@property (nonatomic, retain)	Topic		*currentTopic;
@property (nonatomic, retain)	Topic		*lastTopicCompleted;
@property (nonatomic, retain)	NSString	*userName;
@property (nonatomic, retain)	NSString	*email;
@property (nonatomic)			int			profilePic;
@property (nonatomic, retain)	Score		*highestScore;
@property (nonatomic, retain)	Score		*score;

-(IBAction) checkHighestScore;		   

@end
