//
//  UserNameScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"

@interface UserNameScreenController : UIViewController {
	IBOutlet UITextField *txtName;
	
	//TEST
	//IBOutlet UIButton *temp;
}
@property(nonatomic, retain) IBOutlet UITextField *txtName;
//TEST
//@property(nonatomic, retain) IBOutlet UIButton *temp;
		  
- (IBAction) MakeKeyboardGoAway;
- (IBAction) NextScreen;
- (IBAction) BackScreen;
- (IBAction) HelpScreen;


@end