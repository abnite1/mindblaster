//
//  Questions.h
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"


@interface Questions : NSObject {
	NSMutableArray *questions;
	Question *question;
}
@property (nonatomic,retain) Question *question;

@end
