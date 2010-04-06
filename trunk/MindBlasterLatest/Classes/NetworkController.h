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
#import <CommonCrypto/CommonDigest.h>
#import "GlobalAdmin.h"
#import "MindBlasterAppDelegate.h"
#import "HelpScreenController.h"
#import <SystemConfiguration/SCNetworkReachability.h>

static const int DOWNLOAD = 0;
static const int UPLOAD = 1;

@interface NSString (md5)

+ (NSString *) md5:(NSString *)str;

@end


enum {
    kSendBufferSize = 32768
};

@interface NetworkController : UIViewController <UIAlertViewDelegate>{

    
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
	IBOutlet UIButton *					backButton;
	IBOutlet UIButton *					helpButton;
	
	IBOutlet UILabel *					titleLabel;
	IBOutlet UITextField *				emailDown;
	IBOutlet UITextField *				emailUp;
	int									connectionType;

}


@property (nonatomic, retain) IBOutlet UILabel *					statusLabel;
@property (nonatomic, retain) IBOutlet UILabel *					titleLabel;
@property (nonatomic, retain) IBOutlet UIWebView *					webView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *	activityIndicator;
@property (nonatomic, retain) NSInputStream *						networkStreamIn;
@property (nonatomic, retain) NSOutputStream *						networkStreamOut;
@property (nonatomic, retain) NSInputStream *						fileStreamIn;
@property (nonatomic, retain) NSOutputStream *						fileStreamOut;
@property (nonatomic, retain) NSURLConnection *						connection;


// buttons
@property (nonatomic, retain) IBOutlet UIButton *					uploadButton;
@property (nonatomic, retain) IBOutlet UIButton *					downloadButton;
@property (nonatomic, retain) IBOutlet UIButton *					backButton;
@property (nonatomic, retain) IBOutlet UIButton *					helpButton;

// text fields
@property (nonatomic, retain) IBOutlet UITextField *				emailDown;
@property (nonatomic, retain) IBOutlet UITextField *				emailUp;


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
- (BOOL) getEmailFromHiddenField;
-(IBAction) downloadRequested;
-(IBAction) uploadRequestedInitialAction;
-(IBAction) uploadRequested;
-(IBAction) playClick;
-(NSString*) emailToMD5: (NSString*) email;
-(BOOL) parseFolderCheckResponse: (NSData*)data;
-(IBAction)startIndicator;
-(void)uploadComplete;
-(IBAction) downloadRequestAlert;
-(void) disableButtons;
-(void) enableButtons;




@end