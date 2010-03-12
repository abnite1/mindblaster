//
//  DifficultyScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "GameScreenController.h"
#import "UserProfile.h"

@interface DifficultyScreenController : UIViewController {
	IBOutlet UILabel *difficultyDescription;
}
@property (nonatomic,retain) IBOutlet UILabel *difficultyDescription;

-(IBAction) NextScreen;
-(IBAction) selectedEasiest;
-(IBAction) selectedEasy;
-(IBAction) selectedHard;
-(IBAction) selectedHardest;
-(IBAction) BackScreen;
-(IBAction) HelpScreen;

@end
