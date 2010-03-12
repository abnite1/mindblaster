//
//  TopicScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "Topic.h"
#import "DifficultyScreenController.h"
#import "HelpScreenController.h"
#import "MindBlasterAppDelegate.h"

@interface TopicScreenController : UIViewController {
	IBOutlet UILabel *label;
}
@property (nonatomic,retain) IBOutlet UILabel *label;

-(IBAction) NextScreen;
-(IBAction) firstTopicSelected;
-(IBAction) secondTopicSelected;
-(IBAction) thirdTopicSelected;
-(IBAction) fourthTopicSelected;
- (IBAction) BackScreen;
- (IBAction) HelpScreen;

@end
