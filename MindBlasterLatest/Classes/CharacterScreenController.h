//
//  CharacterScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import <CoreData/CoreData.h>
#import "UserNameScreenController.h"
#import "HelpScreenController.h"
#import "MindBlasterAppDelegate.h"

@interface CharacterScreenController : UIViewController {

    IBOutlet UIButton *charOne;
	IBOutlet UIButton *charTwo;
	IBOutlet UIButton *charThree;
	IBOutlet UIButton *charFour;
}
@property (nonatomic, retain) UIButton *charOne;
@property (nonatomic, retain) UIButton *charTwo;
@property (nonatomic, retain) UIButton *charThree;
@property (nonatomic, retain) UIButton *charFour;


- (IBAction) CharacterOne;
- (IBAction) CharacterTwo;
- (IBAction) CharacterThree;
- (IBAction) CharacterFour;
- (IBAction) BackScreen;
- (IBAction) HelpScreen;

@end
