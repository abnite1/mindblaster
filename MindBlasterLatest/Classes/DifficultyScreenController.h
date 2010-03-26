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
	IBOutlet UIButton *easiest;
	IBOutlet UIButton *easy;
	IBOutlet UIButton *hard;
	IBOutlet UIButton *hardest;
}
@property (nonatomic,retain) IBOutlet UILabel *difficultyDescription;
@property (nonatomic,retain) IBOutlet UIButton *easiest;
@property (nonatomic,retain) IBOutlet UIButton *easy;
@property (nonatomic,retain) IBOutlet UIButton *hard;
@property (nonatomic,retain) IBOutlet UIButton *hardest;


-(IBAction) nextScreen;
-(IBAction) selectedEasiest;
-(IBAction) selectedEasy;
-(IBAction) selectedHard;
-(IBAction) selectedHardest;
-(IBAction) backScreen;
-(IBAction) helpScreen;
-(void) animateBackground;
-(void) defaultSelection;

@end
