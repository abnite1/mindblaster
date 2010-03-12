//
//  Question.h
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MindBlasterAppDelegate.h"

static const int INCORRECT_ANSWER_PENALTY = 4;
static const int CORRECT_ANSWER_REWARD = 10;
static const int BLANK_REWARD = 2;

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
@end
