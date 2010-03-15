//
//  CharacterScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Modifed slightly by yaniv haramati on 14/03/10 : added space background, moved all the imports to the .h class.
//	renamed variables and functions to be simple, descriptive, and according to the coding standard.
//  fixed broken xib.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 *	this is the character navigation screen where the player picks a profile picture among the (currently) 4 available.
 *  the selected picture link is stored in the user profile and appears on the gamescreen view
 */

#import <UIKit/UIKit.h>
#import "BackgroundAnimation.h"
#import <CoreData/CoreData.h>
#import "UserNameScreenController.h"
#import "HelpScreenController.h"
#import "MindBlasterAppDelegate.h"

@interface CharacterScreenController : UIViewController {

    IBOutlet UIButton *charOne;
	IBOutlet UIButton *charTwo;
	IBOutlet UIButton *charThree;
	IBOutlet UIButton *charFour;
	IBOutlet BackgroundAnimation *background;
}
@property (nonatomic, retain) UIButton *charOne;
@property (nonatomic, retain) UIButton *charTwo;
@property (nonatomic, retain) UIButton *charThree;
@property (nonatomic, retain) UIButton *charFour;


- (IBAction) firstCharacterSelected;
- (IBAction) secondCharacterSelected;
- (IBAction) thirdCharacterSelected;
- (IBAction) fourthCharacterSelected;
- (IBAction) backScreen;
- (IBAction) helpScreen;
//-(void)animateBackground;

@end
