//
//  HelpScreenController.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//Somehowthis screen should accept some kind of text DEPENDING on what page called it
//so then we can populate the help label with the help instructions .....????
//OR will it be more elaborate than that.


#import <UIKit/UIKit.h>
#import "Ball.h"

@interface HelpScreenController : UIViewController {
	IBOutlet UILabel *help;
}
@property (nonatomic,retain) IBOutlet UILabel *help;

- (IBAction) BackScreen;
- (IBAction) Quit;


@end
