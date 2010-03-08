//
//  Question.m
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Question.h"


@implementation Question
@synthesize question, questionLabel;

-(IBAction)setLabel:(NSString*)labelString labelPtr:(UILabel*)label {
	questionLabel = label;
	[label setText:labelString];
}
@end
