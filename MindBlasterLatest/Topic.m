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

        topic = newTopic;
    }
	
    return self;
	
}
@end
