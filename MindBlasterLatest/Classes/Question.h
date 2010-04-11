//
//  Question.h
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Modified by yaniv haramati on 12/03/10
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 *	responsible for the role of generating questions and answers
 *  and defining the reward/penalty for hitting an asteroid containing either.
 *  there is an issue that while a hard/hardest difficulty setting increases the range of randomness, 
 *  it does not guarantee a difficult question, and you may and probably will encounter questions such as 30-1 = ?
 *  on the hardest setting, which is absurd.
 *	therefore, we need to modify the generating algorithm to have an acceptable difference between the two operands
 *  to ensure consistency with the difficulty setting.
 *
 *  
 */

#import <Foundation/Foundation.h>
#import "MindBlasterAppDelegate.h"

static const int INCORRECT_ANSWER_PENALTY = 5;
static const int CORRECT_ANSWER_REWARD = 10;
static const int BLANK_REWARD = 1;

@interface Question : NSObject {
	
	int operand1, operand2, answer;
	
	IBOutlet UILabel *questionLabelOutletPointer;
	IBOutlet UILabel *answerLabelOutletPointer;
	
}

@property (nonatomic,retain) IBOutlet UILabel *questionLabelOutletPointer;
@property (nonatomic,retain) IBOutlet UILabel *answerLabelOutletPointer;
@property (nonatomic) int answer;

-(IBAction)generateCorrectAnswer;
-(IBAction)setQuestion;
-(IBAction)setQuestionUnitTest;
@end
