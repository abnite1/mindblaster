//
//  LoadGameScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  modified by yaniv haramati on 14/03/10 to abide by coding standards
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


/*
 *	this view is responsible for connecting to the web server in order to upload/download a user profile
 *  currently only provides a stub link to 2 mock accounts. to be implemented in phase II.
 */

#import <UIKit/UIKit.h>
#import "BackgroundAnimation.h"
#import "TopicScreenController.h"
#import "HelpScreenController.h"
#import "MindBlasterAppDelegate.h"

@interface LoadGameScreenController : UIViewController {
	
	IBOutlet BackgroundAnimation *background;
}
-(IBAction)upload;
-(IBAction)download;
- (IBAction) backScreen;
- (IBAction) helpScreen;
-(void)animateBackground; 

//save data on "ApplicationWillTerminate"
//http://cocoadevcentral.com/articles/000059.php


@end
