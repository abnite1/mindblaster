//
//  Question.h
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject {

	int operand1, operand2, answer;
	IBOutlet UILabel *questionLabelOutletPointer;
	IBOutlet UILabel *answerLabelOutletPointer;
}

@property (nonatomic,retain) IBOutlet UILabel *questionLabelOutletPointer;
@property (nonatomic,retain) IBOutlet UILabel *answerLabelOutletPointer;

-(IBAction)generateCorrectAnswer;
-(IBAction)setQuestion:(NSString*)topic difficulty:(int)diff;
@end
