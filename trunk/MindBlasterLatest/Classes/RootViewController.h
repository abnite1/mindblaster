//
//  RootViewController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.

/*
 *	first application view, displays the moving space animation and allows the user to load a game or starta new one.
 */


#import <UIKit/UIKit.h>
#import "BackgroundAnimation.h"
#import "HelpScreenController.h"
#import "CharacterScreenController.h"
#import "GlobalAdmin.h"
#import "NetworkController.h"
#import "MindBlasterAppDelegate.h"
#import "WebController.h"

@interface RootViewController : UIViewController  {
	IBOutlet BackgroundAnimation *bgAnimation;
	IBOutlet UIButton *continueButton;
}

- (IBAction) nextScreen;
- (IBAction) loadGame;
- (IBAction) helpScreen;
- (IBAction) continueSelected;
- (IBAction) webScreen;



@end
