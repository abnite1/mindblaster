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

@interface CharacterScreenController : UIViewController {
	UIImage *profilePic;
	
}
@property(nonatomic, retain) UIImage *profilePic;

- (IBAction) CharacterOne;
- (IBAction) CharacterTwo;
- (IBAction) CharacterThree;
- (IBAction) CharacterFour;
- (IBAction) BackScreen;
- (IBAction) HelpScreen;

@end
