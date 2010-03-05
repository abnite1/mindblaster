//
//  DifficultyScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"

@interface DifficultyScreenController : UIViewController {
	IBOutlet UILabel *difficultyDescription;
}
@property (nonatomic,retain) IBOutlet UILabel *difficultyDescription;

-(IBAction) NextScreen;
-(IBAction) DiffOne;
-(IBAction) DiffTwo;
-(IBAction) DiffThree;
-(IBAction) DiffFour;
- (IBAction) BackScreen;
- (IBAction) HelpScreen;

@end
