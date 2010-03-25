//
//  UserNameScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundAnimation.h"
#import "HelpScreenController.h"
#import "Topic.h"

@interface UserNameScreenController : UIViewController {
	IBOutlet UITextField *name;
	IBOutlet UITextField *email;
	IBOutlet BackgroundAnimation *background;
	

}


@property (nonatomic,retain) IBOutlet UITextField *name;
@property (nonatomic,retain) IBOutlet UITextField *email;

- (IBAction) makeKeyboardGoAway;
- (IBAction) nextScreen;
- (IBAction) backScreen;
- (IBAction) helpScreen;


@end
