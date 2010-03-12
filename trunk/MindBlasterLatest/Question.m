//
//  Question.m
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Question.h"


@implementation Question
@synthesize questionLabelOutletPointer, answerLabelOutletPointer, answer;

// set the question
-(IBAction)setQuestion{
	
	srand(clock());
	// base range =  (0 - 10), add +10 to max positive range for every added difficulty level.
	int diff = [UIAppDelegate.currentUser currentDifficulty];
	
	// get random operators
	operand1 = random() % (10 * diff); 	
	operand2 = random() % (10 * diff);

	char *operator = [UIAppDelegate.currentUser.currentTopic operator];

	// calculate the answer
	if ( operator == (char*) '+' )  {
		
		answer = operand1 + operand2;
	}
	
	// the max value should be on the left for subtraction
	else if ( operator == (char*) '-' ) {
		
		int maxVal = MAX (operand1, operand2);
		int minVal = MIN (operand1, operand2);
		operand1 = maxVal;
		operand2 = minVal;
		answer = operand1 - operand2;
	} 
	
	// both operands should be less than 10 for  multiplication
	else if ( operator == (char*) 'X' ) {
		
		operand1 /= diff;	// we don't want it to be too hard for now.
		operand2 /= diff;	// we dont' want it to be too hard for now.
		answer = operand1 * operand2;
	}
	
	// there should always be an integer solution for division
	// and we cannot divide by 0
	else if ( operator == (char*) '/' ) {

		// round it up to an integer solution and arrange max val to be first
		if (operand1 == 0) operand1++;
		if (operand2 == 0) operand2++;
		int maxVal = MAX (operand1, operand2);
		int minVal = MIN (operand1, operand2);
		operand1 = maxVal;
		operand2 = minVal;
		int remainder = operand1 % operand2;
		operand2 = remainder + operand2;
		answer = operand1 / operand2;
	}
	
	NSLog(@"op1: %d, op2: %d : Answer: %d",operand1, operand2, answer);
	// set the string question for the label
	NSString *numericQuestion = [[NSString alloc] initWithFormat:@"%d %c %d = ?",
								 operand1,operator,operand2];
	// set the label
	[questionLabelOutletPointer setText:numericQuestion];

	// release all allocated objects
	[numericQuestion release];
}

// for debug and testing
-(IBAction)generateCorrectAnswer {
	NSLog(@"%d",answer);
}


@end
