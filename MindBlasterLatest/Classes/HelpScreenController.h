//
//  HelpScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 *	the help screen should provide view-specific help, by noticing where the user has navigated from and providing the appropriate
 *	help label describing available options in the view-of-origin.
 *	currently exists as a stub, screen-specific help labels should be added in phase II.
 *
 */


#import <UIKit/UIKit.h>
#import "BackgroundAnimation.h"
#import "TopicScreenController.h"

@interface HelpScreenController : UIViewController {
	IBOutlet UILabel *help;
}
@property (nonatomic,retain) IBOutlet UILabel *help;

- (IBAction) backScreen;
- (IBAction) quit;


@end
