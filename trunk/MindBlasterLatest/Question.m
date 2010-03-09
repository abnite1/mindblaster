//
//  Question.m
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Question.h"


@implementation Question
@synthesize questionLabelOutletPointer;
@synthesize answerLabelOutletPointer;

// set the question
-(IBAction)setQuestion:(NSString*)topic difficulty:(int)diff{
	
	// base range =  (0 - 10), add +10 to max positive range for every added difficulty level.
	operand1 = random() % 10 * diff; 	
	operand2 = random() % 10 * diff;
	
	
	// get the answer
	if ([topic caseInsensitiveCompare:@"+"]) answer = operand1 + operand2;
	if ([topic caseInsensitiveCompare:@"-"]) answer = operand1 - operand2;
	if ([topic caseInsensitiveCompare:@"*"]) answer = operand1 * operand2;
	if ([topic caseInsensitiveCompare:@"/"]) answer = operand1 / operand2;
	
	
	// set the string question for the label
	NSString *numericQuestion = [[NSString alloc] initWithFormat:@"%d %@ %d = ?",operand1,topic,operand2];
	[questionLabelOutletPointer setText:numericQuestion];
	
	// release all allocated objects
	[numericQuestion release];
}

-(IBAction)generateCorrectAnswer {
	NSLog(@"%d",answer);
}


@end
