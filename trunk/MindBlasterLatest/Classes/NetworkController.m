//
//  NetworkController.m
//  MindBlaster
//
//  Created by yaniv haramati on 21/03/10. 
//	Borrows heavily from the CFnetwork tutorial on the mac dev forum 
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NetworkController.h"


@interface NetworkController ()
// Properties that don't need to be seen by the outside world.


@property (nonatomic, readonly) BOOL              isSending;
//@property (nonatomic, retain)   NSOutputStream *  networkStream;
//@property (nonatomic, retain)   NSInputStream *   fileStream;
@property (nonatomic, readonly) uint8_t *         buffer;
@property (nonatomic, assign)   size_t            bufferOffset;
@property (nonatomic, assign)   size_t            bufferLimit;


@end

@implementation NetworkController

//@synthesize fileText;
//@synthesize connection    = _connection;

@synthesize fileStreamIn, fileStreamOut;
@synthesize fileStreamIn, fileStreamOut, networkStreamIn, networkStreamOut; 
@synthesize connection;
@synthesize statusLabel;
@synthesize activityIndicator, email;
@synthesize webView;
@synthesize uploadButton, downloadButton;


#pragma mark * Status management

// These methods are used by the core transfer code to update the UI.

// navigate back to the root menu
-(IBAction) backScreen {
	
	// navigate to the help menu
	[self.navigationController popViewControllerAnimated:TRUE];
}

// show the text field after the keyboard is gone
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[email resignFirstResponder];
	return YES;
}

// updates the DB by accessing the update php URL
-(void) updateDBUpload {
	
	NSURL *url = [NSURL URLWithString: [GlobalAdmin getUploadUpdateURL]];
	NSURLRequest *request = [NSURLRequest requestWithURL: url];
	
	// make sure connection established
	NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: YES];
	if (urlConnection ){
		NSLog(@"download script invoked.");
	}
	else {
		NSLog(@"download script failed to invoke.");
	}
	[urlConnection release];
	//[webView loadRequest: request];
	
}

// updates the DB by accessing the update php URL with email as parameter
-(void) updateDBDownload {
	
	// attach the email to the url
	NSString *urlWithEmail = [[NSString alloc] initWithFormat: @"%@%@", 
							  [GlobalAdmin getDownloadUpdateURL], email.text];
	NSLog(@"%@", urlWithEmail);
	
	NSURL *url = [NSURL URLWithString: urlWithEmail];
	[urlWithEmail release];
	NSURLRequest *request = [NSURLRequest requestWithURL: url];
	
	// make sure connection is established and wait for 20 seconds
	// to allow the server to enact the profile overwrite.
	NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: YES];
	if (urlConnection ){
		NSLog(@"download script invoked.");
	}
	else {
		NSLog(@"download script failed to invoke.");
	}
	[urlConnection release];
	
}

// delegate method for NSURLConnection
// activated once the script for either upload or download is finished loading, and download can begin
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"connection did finish loading");
	if (connectionType == DOWNLOAD) {
		
		NSLog(@"finished loading upload script");
		[self download];
	}
	if (connectionType == UPLOAD) {
		
		NSLog(@"finished loading upload script");
	}
		
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

// user pressed the download button
// get their email before progressing
-(IBAction) downloadRequested {
	
	if ( [self getEmailFromHiddenField]) {
		
		[UIAppDelegate.currentUser setEmail: email.text];
		[statusLabel setText: @""];
		[email setEnabled: NO];
		email.hidden = YES;
		connectionType = DOWNLOAD;
		[self updateDBDownload];
	}
	else
		[statusLabel setText: @"Must enter email."];
}

// prompt the user for an email address
// or notify them of failure
- (BOOL) getEmailFromHiddenField {

	
	// return YES if email has been already entered with a non empty value
	if (email.text != nil && ! [email.text isEqualToString:@""]) {
		
		return YES;
	}
	else  {
		
		[statusLabel setText: @"Enter your email address."];
		[email setEnabled: YES];
		email.hidden = NO;
		return NO;
	}
}


// returns YES if network connection found, otherwise NO.
// function taken from : http://www.iphonedevsdk.com/forum/iphone-sdk-development/7300-test-if-internet-connection-available.html
// with permission of author.
- (BOOL) connectedToNetwork {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return 0;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
	
	return ((isReachable && !needsConnection) || nonWiFi) ? YES : NO;
	
}

// display help for the load profile menu
-(IBAction) helpScreen {
	
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}

/*
- (void)_sendDidStart
{
    self.statusLabel.text = @"Please wait for transfer to complete.";
    //self.cancelButton.enabled = YES;
    [self.activityIndicator startAnimating];
   //[[AppDelegate sharedAppDelegate] didStartNetworking];
}
*/
- (void)_updateStatus:(NSString *)statusString {
	
	NSLog(@"inside _upadateStatus");
    //assert(statusString != nil);
   // self.statusLabel.text = statusString;
}

- (void)_sendDidStopWithStatus:(NSString *)statusString {
	
	NSLog(@"starting _sendDidStopWithStatus");
    if (statusString == nil) {
        //statusString = @"Put succeeded";
    }
    //self.statusLabel.text = statusString;
   // self.cancelButton.enabled = NO;
    //[self.activityIndicator stopAnimating];
	//[[AppDelegate sharedAppDelegate] didStartNetworking];
}


#pragma mark * Core transfer code

// This is the code that actually does the networking.

@synthesize bufferOffset  = _bufferOffset;
@synthesize bufferLimit   = _bufferLimit;

// Because buffer is declared as an array, you have to use a custom getter.  
// A synthesised getter doesn't compile.

- (uint8_t *)buffer {
	
	NSLog(@"inside buffer");
    return self->_buffer;
}

- (BOOL)isSending {
	
	NSLog(@"inside isSending");
    return (self.networkStreamOut != nil);
	
}

- (void)_stopSendWithStatus:(NSString *)statusString
{
    if (self.networkStreamOut != nil) {
        [self.networkStreamOut removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStreamOut.delegate = nil;
        [self.networkStreamOut close];
        self.networkStreamOut = nil;
    }
    if (self.fileStreamIn != nil) {
        [self.fileStreamIn close];
        self.fileStreamIn = nil;
    }
   // [self _sendDidStopWithStatus:statusString];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our 
// network stream.
{
#pragma unused(aStream)
	
	NSLog(@"beginning of stream");
    //assert(aStream == self.networkStream);
	
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            [self _updateStatus:@"Opened connection"];
        } break;
        case NSStreamEventHasBytesAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventHasSpaceAvailable: {
            [self _updateStatus:@"Sending"];
            
            // If we don't have any data buffered, go read the next chunk of data.
            
            if (self.bufferOffset == self.bufferLimit) {
                NSInteger   bytesRead;
                
                bytesRead = [self.fileStreamIn read:self.buffer maxLength:kSendBufferSize];
                
                if (bytesRead == -1) {
                    [self _stopSendWithStatus:@"File read error"];
                } else if (bytesRead == 0) {
                    [self _stopSendWithStatus:nil];
                } else {
                    self.bufferOffset = 0;
                    self.bufferLimit  = bytesRead;
                }
            }
            
            // If we're not out of data completely, send the next chunk.
            
            if (self.bufferOffset != self.bufferLimit) {
                NSInteger   bytesWritten;
                bytesWritten = [self.networkStreamOut write:&self.buffer[self.bufferOffset] maxLength:self.bufferLimit - self.bufferOffset];
                assert(bytesWritten != 0);
                if (bytesWritten == -1) {
                    [self _stopSendWithStatus:@"Network write error"];
                } else {
                    self.bufferOffset += bytesWritten;
                }
            }
        } break;
        case NSStreamEventErrorOccurred: {
			NSLog(@"stream event error encountered");
			[self failedConnectionResponse];
            [self _stopSendWithStatus:@"Stream open error"];
        } break;
        case NSStreamEventEndEncountered: {
			NSLog(@"stream event end encountered");
            // ignore
        } break;
        default: {
            assert(NO);
        } break;
    }
	NSLog(@"end of stream");
}

// update the label if no internet connection is found
-(void) failedConnectionResponse {
	
	[statusLabel setText: @"Couldn't connect..."];
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	connectionType = -1;
	
	[self.navigationController setTitle: @"networkView"];
	
	// initialize email
	email.text = nil;
	[email setEnabled: NO];
	email.hidden = YES;
	
	[self.navigationController setNavigationBarHidden:TRUE animated: NO ];
	
	// test for an internet connection
	// if none was found
	if (! [self connectedToNetwork]) {
		
		NSLog(@"no connection.");
		[downloadButton setEnabled: NO];
		[uploadButton setEnabled: NO];
		self.statusLabel.text = @"No Connection Available.";
	}
	else {
		NSLog(@"connection found.");
		[downloadButton setEnabled: YES];
		[uploadButton setEnabled: YES];
		self.statusLabel.text = @"";
		
	}
    
	NSLog(@"end of viewDidLoad");

}

// delegate function that runs whenever view appears (when returning from subview, etc.)
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	//self.activityIndicator.hidden = NO;
    //self.usernameText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
    //self.passwordText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Password"];
}


// delegate function that runs every time the view returns from "back" of another screen
- (void)viewDidAppear:(BOOL)animated {
    
	[super viewDidAppear:animated];
	NSLog(@"network view did appear.");
	[self.navigationController setTitle: @"networkView"];
	
}

- (void) viewWillDisappear:(BOOL)animated {
	
	// play button click
	[MindBlasterAppDelegate playButtonClick];
}

// download a file
-(IBAction) download {	
		
	assert (email.text != nil && ! [email.text isEqualToString: @""]);
	
	// run the update script before downloading
	//NSLog(@"updating the download DB script");
	//NSLog(@"email: %@",[UIAppDelegate.currentUser email]);
	//[self updateDBDownload];

	
	// save path
	NSString *fileString = [[GlobalAdmin getPath] retain];
	
	// first delete the current profile if it exists.
	if([[NSFileManager defaultManager] fileExistsAtPath: fileString ]) {
		
		if ( [[NSFileManager defaultManager] removeItemAtPath: fileString error: nil] )
			NSLog(@"existing profile deleted.");
		else
			NSLog(@"Failed to delete existing profile");
	}
	
/*
	// set the send-to-file stream
	self.fileStreamOut = [NSOutputStream outputStreamToFileAtPath: fileString append:NO];
	[self.fileStreamOut open];
*/
	
	// read plist into a dictionary
	NSString *urlString =  [[GlobalAdmin getURL] retain];
	
	// for debug: 
	NSLog(@"downloading: %@", urlString);
	
	NSURL *url = [[NSURL URLWithString: urlString] retain];
	assert (url != nil);
	
/*	
	self.connection = [NSURLConnection connectionWithRequest: request delegate: self];
	assert(self.connection != nil);
*/

	//self.activityIndicator.hidden = NO;
	//[self.activityIndicator startAnimating];
	
	//NSDictionary *profile = [[NSDictionary alloc] initWithContentsOfFile: fileString];
	NSDictionary *profile = [[NSDictionary alloc] initWithContentsOfURL: url];
	
	// start UI progress indicators
	//[self.activityIndicator stopAnimating];
	//self.activityIndicator.hidden = YES;

	NSLog(@"Saving to file: %@", fileString);

	[profile writeToFile: fileString atomically: YES];
	[profile release];
	
	self.statusLabel.text = @"Download Complete.";
	[UIAppDelegate didStartNetworking];
	
	NSLog(@"finished download");
	connectionType = -1;
}

// upload a file
-(IBAction)upload {
	
	connectionType == UPLOAD;
	
	// get the ftp url from ApplicationSettings.plist
	NSString *urlString =  [GlobalAdmin getURL];

	// get the local file path for the profile
	NSString *fileString = [GlobalAdmin getPath];
	
	NSLog(@"upload file path: %@",fileString);
	
	// create the url
	NSURL *url = [NSURL URLWithString: urlString];
	
	// make sure we have a file to upload
	if ( [[NSFileManager defaultManager] fileExistsAtPath: fileString ] ) 
	{
	
		// for debugging
		NSLog(@"uploading: %@", fileString);
		NSLog(@"to: %@", urlString);
	
		// update UI indicators
		self.statusLabel.text = @"Upload Started.";
		//self.activityIndicator.hidden = NO;
		//[self.activityIndicator startAnimating];
	
		// set the streams
		self.fileStreamIn = [NSInputStream inputStreamWithFileAtPath: fileString];
	
		[self.fileStreamIn open];
		CFWriteStreamRef ftpStream = CFWriteStreamCreateWithFTPURL(NULL, (CFURLRef) url);
	
		self.networkStreamOut = (NSOutputStream *) ftpStream;
	
		self.networkStreamOut.delegate = self;
		[self.networkStreamOut scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		
		// and send
		[self.networkStreamOut open];
	
		// Have to release ftpStream to balance out the create.  self.networkStream 
		// has retained this for our persistent use.
		CFRelease(ftpStream);
		
		self.statusLabel.text = @"Upload Complete.";
		//[self.activityIndicator stopAnimating];
		//self.activityIndicator.hidden = YES;
		
	}
	// we have no profile to upload
	else {
		
		self.statusLabel.text = @"No profile available.";
	}
	
	//[self didStartNetworking];
	 NSLog(@"end of upload");

	// update the upload script
	NSLog(@"updating upload script");
	[self updateDBUpload];
	
	connectionType = -1;
}

// to be implemented
-(void) didStartNetworking {
	NSLog(@"inside didStartNetworking");
	//[activityIndicator startAnimating];
}


// to be implemented
-(void) didStopNetworking {
	NSLog(@"inside didStopNetworking");
	//[activityIndicator stopAnimating];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	NSLog(@"inside didReceieveMemoryWatning");
	// Release any cached data, images, etc that aren't in use.
}

// plays an inside click when hitting email or name text edit panes
-(IBAction) playClick {
	
	// play inside click
	[MindBlasterAppDelegate playInsideClick];
}

- (void)viewDidUnload
{
	NSLog(@"started viewDidUnload");
    self.statusLabel = nil;
    self.activityIndicator = nil;
    //self.cancelButton = nil;
	[super viewDidUnload];
}

- (void)dealloc
{

    //[self _stopSendWithStatus:@"Stopped"];
    [super dealloc];
}


@end
