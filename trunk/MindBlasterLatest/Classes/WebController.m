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
	
	CGRect webFrame = CGRectMake(0, 44.0, 480.0, 298.0); 
	//UIWebView * webView = [[UIWebView alloc] initWithFrame: webFrame]; 
	webView =  [[UIWebView alloc] initWithFrame: webFrame];
	[webView setBackgroundColor: [UIColor whiteColor]]; 
	//[webView autoresizesSubviews];
	
	// get the user email if a profile exists and an email has been entered
	NSString * email;
	if ([UIAppDelegate currentUser] != nil && [UIAppDelegate.currentUser email] != nil) {
		
		email = [[NSString alloc] initWithString: [UIAppDelegate.currentUser email]];
	}
	else {
		
		email = [[NSString alloc] initWithString: @""];
	}
	
	// combine the email with the php url 
	NSString * urlString = [[NSString alloc] initWithFormat: @"%@%@", 
							[GlobalAdmin getStatsURL], email];
	[email release];
	
	// set-up the url
	NSString *urlAddress = [[NSString alloc] initWithString: urlString];
	[urlString release];
	
	NSURL *url = [NSURL URLWithString: urlAddress]; 
	[urlAddress release];
	
	// make the request
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL: url]; 
	[webView loadRequest: urlRequest]; 
	[[self view] addSubview: webView]; 
	[webView release]; 
}

// navigate to the previous page
-(IBAction) goBack:(id)sender {
	
	NSLog(@"webview url: %@", [webView.request.URL path]);
	
	// if there's no connection or if it's the homepage go back to root menu
	if (![GlobalAdmin connectedToNetwork] || [[webView.request.URL path] isEqual: @"/showuser.php"]) {
		
		NSLog(@"home page");
		// navigate to the help menu
		[self.navigationController popViewControllerAnimated:TRUE];
	}
	// otherwise navigate back
	else {
		
		[webView goBack];
	}
}

// refresh the current page
-(IBAction) reload:(id)sender {
	[webView reload];
}


- (void)dealloc {
    [super dealloc];
}


@end
