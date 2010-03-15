//
//  DifficultyScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//	restructured by yaniv haramati on 10/03/10 to integrate the user profile created by john.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundAnimation.h"
#import "GameScreenController.h"
#import "UserProfile.h"

@interface DifficultyScreenController : UIViewController {
	
	IBOutlet UILabel *difficultyDescription;
	IBOutlet BackgroundAnimation *background;
}
@property (nonatomic,retain) IBOutlet UILabel *difficultyDescription;


-(IBAction) nextScreen;
-(IBAction) selectedEasiest;
-(IBAction) selectedEasy;
-(IBAction) selectedHard;
-(IBAction) selectedHardest;
-(IBAction) backScreen;
-(IBAction) helpScreen;
-(void) animateBackground;

@end
