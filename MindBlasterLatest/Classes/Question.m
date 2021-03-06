//
//  Question.m
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Modified by yaniv haramati 
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Question.h"


@implementation Question
@synthesize questionLabelOutletPointer, answerLabelOutletPointer, answer;

// set the question

-(IBAction)setQuestion{
	
	// base range =  (0 - 10), add +10 to max positive range for every added difficulty level.
	//int diff = [UIAppDelegate.currentUser currentDifficulty];
	int diff = [[UIAppDelegate.currentUser currentTopic] difficulty];
	
	// get random nonzero operands
	operand1 = 1 + arc4random() % (10 * diff); 	
	operand2 = 1 + arc4random() % (10 * diff);
	
	// get the current topic in order to determine operator type
	int topicType = [UIAppDelegate.currentUser.currentTopic topic];
	
	// get the operator
	char* operator = [UIAppDelegate.currentUser.currentTopic operator];
	
	// calculate the answer based on topic type
	if (topicType == TOPIC_ADDITION) {
		
		answer = operand1 + operand2;
	}
	
	// the max value should be on the left for subtraction
	else if (topicType == TOPIC_SUBTRACTION) {
		
		int maxVal = MAX (operand1, operand2);
		int minVal = MIN (operand1, operand2);
		operand1 = maxVal;
		operand2 = minVal;
		answer = operand1 - operand2;
	} 
	
	// both operands should be less than 10 for  multiplication
	else if ( topicType == TOPIC_MULTIPLICATION ) {
		
		operand1 /= diff;	// we don't want it to be too hard for now.
		operand2 /= diff;	// we dont' want it to be too hard for now.
		answer = operand1 * operand2;
	}
	
	// there should always be an integer solution for division
	// and we cannot divide by 0
	else if ( topicType == TOPIC_DIVISION ) {
		
		operand1 = 1 + arc4random() % (2 * diff); 	
		operand2 = 1 + arc4random() % (10 * diff);
		
		answer = operand1 * operand2;
		operand1 = answer;
		answer = operand1 / operand2;
		
	}
	
	// set the string question for the label
	NSString *numericQuestion = [[NSString alloc] initWithFormat:@"%d %c %d = ?",
								 operand1,operator,operand2];
	// set the label
	[questionLabelOutletPointer setText:numericQuestion];
	
	// release all allocated objects
	[numericQuestion release];
}

-(IBAction)setQuestionUnitTest{
	int topicType = [UIAppDelegate.currentUser.currentTopic topic];
	BOOL unitTestPassed =TRUE;
	int counter =0;
	int testOperand1, testOperand2;
	testOperand1 = operand1;
	testOperand2 = operand2;
	
	[self setQuestion];
	
	while (testOperand1 == operand1 && testOperand2 == operand2  && counter<50)
	{
		[self setQuestion];
		counter++;
	}
	if(testOperand1 == operand1 && testOperand2 == operand2)
	{
		NSLog(@"UNIT TEST FAILED; class: Question; function setQuestion; operand1 and operand2 failed to change after 50 resets, warning it is possible this a highly unlikely fluke. Retest.");
		unitTestPassed = FALSE;
	}
	if(operand1+operand2 != answer && topicType == TOPIC_ADDITION)
	{
		NSLog(@"UNIT TEST FAILED; class: Question; function setQuestion; answer!= operand1 + operand2 for topicType = TOPIC_ADDITION");
		unitTestPassed = FALSE;
	}
	if(operand1-operand2 != answer && topicType == TOPIC_SUBTRACTION)
	{
		NSLog(@"UNIT TEST FAILED; class: Question; function setQuestion; answer!= operand1 + operand2 for topicType = TOPIC_ADDITION");
		unitTestPassed = FALSE;
	}
	if(operand1*operand2 != answer && topicType == TOPIC_MULTIPLICATION)
	{
		NSLog(@"UNIT TEST FAILED; class: Question; function setQuestion; answer!= operand1 + operand2 for topicType = TOPIC_ADDITION");
		unitTestPassed = FALSE;
	}
	if(operand1/operand2 != answer && topicType == TOPIC_DIVISION)
	{
		NSLog(@"UNIT TEST FAILED; class: Question; function setQuestion; answer!= operand1 + operand2 for topicType = TOPIC_ADDITION");
		unitTestPassed = FALSE;
	}
	if(unitTestPassed == TRUE)
		NSLog(@"UNIT TEST PASSED; class: Question; function setQuestion");
	
}

// for debug and testing
-(IBAction)generateCorrectAnswer {
	NSLog(@"answer: %d",answer);
}



@end
