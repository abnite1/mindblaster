//
//  WebController.h
//  MindBlaster
//
//  Created by yaniv haramati on 06/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalAdmin.h"


@interface WebController : UIViewController {
	
	//CGRect webFrame;
	IBOutlet UIWebView *webView;
	
}

-(void) showWebView;
-(IBAction) goBack:(id)sender;
-(IBAction) reload:(id)sender;
@end
