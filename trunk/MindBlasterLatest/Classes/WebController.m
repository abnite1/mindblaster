//
//  WebController.m
//  MindBlaster
//
//  Created by yaniv haramati on 06/04/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebController.h"


@implementation WebController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void) viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	[[UIApplication sharedApplication] setStatusBarHidden: YES animated: NO];
	NSLog(@"web view did appear.");
	[self.navigationController setTitle: @"webView"];
	
	[self showWebView];

}

-(void) showWebView {
	CGRect webFrame = CGRectMake(0.0, 0.0, 460.0, 320.0); 
	UIWebView * webView = [[UIWebView alloc] initWithFrame: webFrame]; 
	[webView setBackgroundColor: [UIColor whiteColor]]; 
	NSString *urlAddress = [[NSString alloc] initWithString: @"http://mindblaster.byethost16.com/"]; 
	NSURL *url = [NSURL URLWithString: urlAddress]; 
	[urlAddress release];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL: url]; 
	[webView loadRequest: urlRequest]; 
	[[self view] addSubview: webView]; 
	[webView release]; 
}


- (void)dealloc {
    [super dealloc];
}


@end
