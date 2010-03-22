//
//  Topic.h
//  MindBlaster
//
//  Created by yaniv haramati on 10/03/10 : constants, properties, function: initWithTopic.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 * the topic class represents a topic under the assumption that we may add more features and properties to topics in the future.
 * should possibly include top score (for each topic)
 */

#import <Foundation/Foundation.h>

#define _TOPIC_ADDITION 0;
#define _TOPIC_SUBTRACTION 1;
#define _TOPIC_MULTIPLICATION 2;
#define _TOPIC_DIVISION 3;
#define _DIFFICULTY_EASIEST 1;
#define _DIFFICULTY_EASY 2;
#define _DIFFICULTY_HARD 3;
#define _DIFFICULTY_HARDEST 4;



static const int TOPIC_ADDITION = 0;
static const int TOPIC_SUBTRACTION = 1;
static const int TOPIC_MULTIPLICATION = 2;
static const int TOPIC_DIVISION = 3;

// defined constants representing difficulty types
static const int DIFFICULTY_EASIEST = 1;
static const int DIFFICULTY_EASY	= 2;
static const int DIFFICULTY_HARD	= 3;
static const int DIFFICULTY_HARDEST = 4;

// this constant is the multiplier that determines the number of points necessary to transition to the next difficulty level
// during gameplay
static const int DIFFICULTY_LIMIT = 100;

// last topic number
static const int MAX_TOPICS = 3;

@interface Topic : NSObject {
	
	int difficulty;
	int topic;
	NSString *description;
	char *operator;
}

@property (nonatomic) int difficulty;
@property (nonatomic) int topic;
@property (nonatomic) char *operator;
@property (nonatomic,retain) NSString *description;

-(id)initWithTopic:(int)newTopic;
-(BOOL) nextTopic;
-(void) initOperator;

@end
