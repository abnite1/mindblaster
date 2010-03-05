//
//  RootViewController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.

/*
	So the basic concept would seem to be all the different screen and options
 simply edit a configuration struct which 
 everytime a game starts it checks the status of the configuration struct for details
 and loads those details.
 Therefore same procedure, varied results.
*/


//Issues:

//1. When go to help - changetopic - back --the screen changes to portrait.....???

//

#import <UIKit/UIKit.h>
#import "Ball.h"

@interface RootViewController : UIViewController {
	IBOutlet Ball* mBall;
}
@property(retain, nonatomic) IBOutlet Ball* mBall;

- (IBAction) NextScreen;
- (IBAction) LoadGame;
- (IBAction) HelpScreen;


@end
