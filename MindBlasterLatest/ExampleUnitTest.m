//
//  ExampleUnitTest.m
//  MindBlaster
//
//  Created by John Kehler on 3/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "ExampleUnitTest.h"
#import "UserProfile.h"

@implementation ExampleUnitTest

-(void) testOne
{
	UserProfile *example = [UserProfile new];
	int score = [example score];
	UserProfile *another = NULL;
	
	STAssertNotNil(another,@"Yeah i made it break");
	
}


@end
