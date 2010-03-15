//
//  TopicScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//	restructured by yaniv haramati on 14/03/10 to abide by coding standard.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 *	select-a-topic view for the player.s selected topic goes into the user profile and affects teh type of questions generated 
 *  during gametime.
 */


#import <UIKit/UIKit.h>
#import "Topic.h"
#import "DifficultyScreenController.h"
#import "HelpScreenController.h"
#import "MindBlasterAppDelegate.h"
#import "BackgroundAnimation.h"

@interface TopicScreenController : UIViewController {
	IBOutlet UILabel *label;
	IBOutlet BackgroundAnimation *background;
}
@property (nonatomic,retain) IBOutlet UILabel *label;

-(IBAction) nextScreen;
-(IBAction) firstTopicSelected;
-(IBAction) secondTopicSelected;
-(IBAction) thirdTopicSelected;
-(IBAction) fourthTopicSelected;
- (IBAction) backScreen;
- (IBAction) helpScreen;
-(void)animateBackground;
@end
