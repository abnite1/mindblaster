//
//  GameOverScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  modified by yaniv haramati on 14/03/10 to include space background and font and color matching the root view
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 *	this is where the game handles gameover scenarios. alerts and animations relating to a game win or lose should be 
 *	implemented here.
 *	at present, there are only menu options to return to the game or go back to the root view.
 *
 *  known issue: returning from game over the score is still negative, should be reset.
 */

#import <UIKit/UIKit.h>
#import "BackgroundAnimation.h"
#import "TopicScreenController.h"
#import "RootViewController.h"

@interface GameOverScreenController : UIViewController {
	
	IBOutlet BackgroundAnimation *background;
}

-(IBAction) tryAgain;  
-(IBAction) changeTopic;
-(IBAction) quit;
- (IBAction) helpScreen;
-(void)animateBackground; 

@end
