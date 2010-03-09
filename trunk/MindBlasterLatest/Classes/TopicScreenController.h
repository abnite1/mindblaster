//
//  TopicScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"

@interface TopicScreenController : UIViewController {
	IBOutlet UILabel *label;
}
@property (nonatomic,retain) IBOutlet UILabel *label;

-(IBAction) NextScreen;
-(IBAction) TopicOne;
-(IBAction) TopicTwo;
-(IBAction) TopicThree;
-(IBAction) TopicFour;
- (IBAction) BackScreen;
- (IBAction) HelpScreen;

@end
