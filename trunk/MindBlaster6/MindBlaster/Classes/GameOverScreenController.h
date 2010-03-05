//
//  GameOverScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"

@interface GameOverScreenController : UIViewController {
}
-(IBAction) TryAgain;  //new game with same settings as the game that just finished
//it will got back to the normal game nib screen, but will keep the parameters ofgameplay same.

-(IBAction) ChangeTopic;
-(IBAction) Quit;
- (IBAction) HelpScreen;

@end
