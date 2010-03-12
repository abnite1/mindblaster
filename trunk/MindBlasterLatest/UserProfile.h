//
//  UserProfile.h
//  MindBlaster
//
//  Created by John Kehler on 3/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"

static const int DIFFICULTY_EASIEST = 1;
static const int DIFFICULTY_EASY	= 2;
static const int DIFFICULTY_HARD	= 3;
static const int DIFFICULTY_HARDEST = 4;

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
