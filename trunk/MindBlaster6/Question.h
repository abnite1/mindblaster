//
//  Question.h
//  MindBlaster
//
//  Created by yaniv haramati on 07/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject {
	NSString *question;
	UILabel *questionLabel;
	
}
@property (nonatomic,retain) NSString *question;
@property (nonatomic,retain) UILabel *questionLabel;

-(IBAction)setLabel:(NSString*)labelString labelPtr:(UILabel*)labelPtr;
@end
