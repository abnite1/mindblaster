//
//  WebController.h
//  MindBlaster
//
//  Created by yaniv haramati on 06/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebController : UIViewController {

	//CGRect webFrame;
	//IBOutlet UIWebView *webView;
	IBOutlet UIButton *back;
}
@property (nonatomic, retain) IBOutlet UIButton *back;

-(void) showWebView;
-(IBAction)backScreen;

@end
