//
//  Topic.m
//  MindBlaster
//
//  Created by yaniv haramati on 10/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Topic.h"


@implementation Topic


@synthesize difficulty, topic, description, operator;

// initializer that sets a new topic. 

// USE THE DEFINED CONSTANTS IN Topic.h
- (id)initWithTopic:(int)newTopic {
	
    if ( self = [super init] ) {

		// set the topic
        topic = newTopic;
		
		difficulty = DIFFICULTY_EASIEST;
		
		// set the operator appropriately
		[self initOperator];
    }
	
    return self;
	
}

// sets the operator according to the topic type
-(void) initOperator {
	
	// set the operator
	if (topic == TOPIC_ADDITION) operator = (char*)'+';
	else if (topic == TOPIC_SUBTRACTION) operator = (char*)'-';
	else if (topic == TOPIC_MULTIPLICATION) operator = (char*)'X';
	else if (topic == TOPIC_DIVISION) operator = (char*)'/';
}

// switches to the next topic
// returns NO if already at the max, YES otherwise.
-(BOOL) nextTopic {
	
	if (topic == MAX_TOPICS)
		return NO;

	// otherwise increment topic type and reset difficulty
	difficulty = DIFFICULTY_EASIEST;
	topic++;
	
	// also reset the operator
	[self initOperator];
	
	// switch made successfully
	return YES;
	
}
@end
