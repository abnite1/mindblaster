//
//  NetworkController.h
//  MindBlaster
//
//  Created by yaniv haramati on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#include <CFNetwork/CFNetwork.h>
#include <netinet/in.h>
#import <UIKit/UIKit.h>
#import "GlobalAdmin.h"
#import "MindBlasterAppDelegate.h"
#import "HelpScreenController.h"
#import <SystemConfiguration/SCNetworkReachability.h>


enum {
    kSendBufferSize = 32768
};

@interface NetworkController : UIViewController {

    
	// for upload	
    NSOutputStream *					networkStreamOut;
    NSInputStream *						fileStreamIn;
    uint8_t								_buffer[kSendBufferSize];
    size_t								_bufferOffset;
    size_t								_bufferLimit;
	
	// for download
	NSInputStream *						networkStreamIn;
    NSOutputStream *					fileStreamOut;
	
	// for connection
	NSURLConnection *					connection;
	
	IBOutlet UIImageView *				imageView;
	IBOutlet UIActivityIndicatorView *	activityIndicator;
	IBOutlet UILabel *					statusLabel;

	IBOutlet UIWebView *				webView;
	IBOutlet UIButton *					uploadButton;
	IBOutlet UIButton *					downloadButton;

}


@property (nonatomic, retain) IBOutlet UILabel *					statusLabel;
@property (nonatomic, retain) IBOutlet UIWebView *					webView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *	activityIndicator;
@property (nonatomic, retain) NSInputStream *						networkStreamIn;
@property (nonatomic, retain) NSOutputStream *						networkStreamOut;
@property (nonatomic, retain) NSInputStream *						fileStreamIn;
@property (nonatomic, retain) NSOutputStream *						fileStreamOut;
@property (nonatomic, retain) NSURLConnection *						connection;
@property (nonatomic, retain) IBOutlet UIButton *					uploadButton;
@property (nonatomic, retain) IBOutlet UIButton *					downloadButton;


//@property (nonatomic, retain) IBOutlet UIBarButtonItem *           cancelButton;

-(IBAction)download;
-(IBAction)upload;
-(void)didStartNetworking;
-(void)didStopNetworking;
- (IBAction) helpScreen;
- (IBAction) backScreen;
-(void)updateDBUpload;
-(void)updateDBDownload;
-(void) failedConnectionResponse;
- (BOOL) connectedToNetwork;


@end