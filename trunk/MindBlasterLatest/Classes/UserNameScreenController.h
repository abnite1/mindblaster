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

@interface UserNameScreenController : UIViewController {
	IBOutlet UITextField *name;
	IBOutlet BackgroundAnimation *background;
	

}

//TEST
//@property(nonatomic, retain) IBOutlet UIButton *temp;
@property (nonatomic,retain) IBOutlet UITextField *name;
- (IBAction) makeKeyboardGoAway;
- (IBAction) nextScreen;
- (IBAction) backScreen;
- (IBAction) helpScreen;


@end
