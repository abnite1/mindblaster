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
	IBOutlet UIButton *okButton;
	

}


@property (nonatomic,retain) IBOutlet UITextField *name;
@property (nonatomic,retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UIButton *okButton;

- (IBAction) makeKeyboardGoAway;
- (IBAction) nextScreen;
- (IBAction) backScreen;
- (IBAction) helpScreen;
- (IBAction) nameEntered;
- (IBAction) emailEntered;
-(IBAction) playClick;


@end
