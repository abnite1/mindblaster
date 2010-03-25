//
//  Topic.m
//  MindBlaster
//
//  Created by yaniv haramati on 10/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Topic.h"


@implementation Topic


@synthesize difficulty, topic, operator;
@synthesize description;

// initializer that sets a new topic. 
- (id)initWithTopic:(int)newTopic {
	
    if ( self = [super init] ) {

		// set the topic
        topic = newTopic;
		
		// set difficulty
		difficulty = DIFFICULTY_EASIEST;
		
		// set the description
		[self initDescription];
		
		// set the operator appropriately
		[self initOperator];
    }
	
    return self;
	
}

// sets the operator according to the topic type
-(void) initOperator {
	
	// set the operator
	if (topic == TOPIC_ADDITION)			operator = (char*)'+';
	else if (topic == TOPIC_SUBTRACTION)	operator = (char*)'-';
	else if (topic == TOPIC_MULTIPLICATION) operator = (char*)'X';
	else if (topic == TOPIC_DIVISION)		operator = (char*)'/';
}

// sets the description according to the topic type
-(void) initDescription {
	
	NSString *desc; 
	// set the operator
	if (topic == TOPIC_ADDITION)			desc = [[NSString alloc] initWithString: @"Addition."];
	else if (topic == TOPIC_SUBTRACTION)	desc = [[NSString alloc] initWithString: @"Subtraction."];
	else if (topic == TOPIC_MULTIPLICATION) desc = [[NSString alloc] initWithString: @"Multiplication."];
	else if (topic == TOPIC_DIVISION)		desc = [[NSString alloc] initWithString: @"Division."];
	
	[desc release];
}

// switches to the next topic
// returns NO if already at the max, YES otherwise.
-(BOOL) nextTopic {
	
	if (topic == MAX_TOPICS)
		return NO;

	// otherwise increment topic type and reset difficulty
	difficulty = DIFFICULTY_EASIEST;
	topic++;
	
	// also set the operator to the new topic type
	[self initOperator];
	
	// and the description message
	[self initDescription];
	
	// switch made successfully
	return YES;
	
}
@end
