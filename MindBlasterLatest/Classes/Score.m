//
//  Score.m
//  MindBlaster
//
//  Created by John Kehler on 3/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Score.h"


@implementation Score
@synthesize score;

- (id)initWithScore:(int)newScore {
	
    if ( self = [super init] ) {
		
		// set the topic
        score = newScore;
		
		//difficulty = DIFFICULTY_EASIEST;
		
		// set the operator appropriately
		//[self initOperator];
    }
	
    return self;
	
}

@end
