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

//@synthesize fileStreamIn, fileStreamOut;
@synthesize fileStreamIn, fileStreamOut, networkStreamIn, networkStreamOut; 
@synthesize connection;
@synthesize statusLabel, titleLabel;
@synthesize activityIndicator, emailDown, emailUp;
@synthesize webView;
@synthesize uploadButton, downloadButton, backButton, helpButton;


#pragma mark * Status management

// These methods are used by the core transfer code to update the UI.

// navigate back to the root menu
-(IBAction) backScreen {
	
	// navigate to the help menu
	[self.navigationController popViewControllerAnimated:TRUE];
}

// show the text field after the keyboard is gone
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[emailDown resignFirstResponder];
	[emailUp resignFirstResponder];
	return YES;
}

// updates the DB by accessing the update php URL
-(void) updateDBUpload {
	
	NSString *urlString = [[NSString alloc] initWithFormat: @"%@%@", [GlobalAdmin getUploadUpdateURL], emailUp.text];
	NSLog(@"upload url: %@", urlString);
	NSURL *url = [NSURL URLWithString: urlString];
	[urlString release];
	NSURLRequest *request = [NSURLRequest requestWithURL: url];
	
	// make sure connection established
	NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: YES];
	if (urlConnection ){
		NSLog(@"upload script invoked.");
	}
	else {
		NSLog(@"upload script failed to invoke.");
	}
	NSLog(@"before urlConnection release in updateDBUpload");
	[urlConnection release];
	//[webView loadRequest: request];
	
}

// updates the DB by accessing the update php URL with email as parameter
-(void) updateDBDownload {
	
	// attach the email to the url
	NSString *urlWithEmail = [[NSString alloc] initWithFormat: @"%@%@", 
							  [GlobalAdmin getDownloadUpdateURL], emailDown.text];
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
- (void)connectionDidFinishLoading:(NSURLConnection *)connectionID {
	NSLog(@"connection did finish loading");
	if (connectionType == DOWNLOAD) {
		
		NSLog(@"finished loading download update script");
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

// checks if a current profile exists and warns the user that it's about to be lost before continuing.
-(IBAction) downloadRequestAlert {
	
	NSLog(@"download requested");
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle: @"Alert!"
													 message: @"If you continue, your current profile will be lost. \n Do you wish to continue?"
													delegate: self
										   cancelButtonTitle: @"Cancel"
										   otherButtonTitles: @"Continue", nil] autorelease];
	[self disableButtons];
	[alert show];
}

// responds to alert option chosen
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		
		NSLog(@"user chose to cancel");
		[self enableButtons];
		emailDown.text = @"";
		emailDown.hidden = YES;
		statusLabel.text = @"";
		
	}
	if (buttonIndex == 1) {
		
		NSLog(@"user chose to continue");
		[self disableButtons];
		activityIndicator.hidden = NO;
		[activityIndicator startAnimating];
		connectionType = DOWNLOAD;
		
		if ( [self getEmailFromHiddenField]) {
			
			[UIAppDelegate.currentUser setEmail: emailDown.text];
			[statusLabel setText: @""];
			
			// disable all buttons
			[self disableButtons];
			
			// start processing download
			[self download];
			
			// no longer necessary
			//[self updateDBDownload];
		}
		else
			[statusLabel setText: @"Must enter email."];
	}
}

// disables and hides all buttons
-(void) disableButtons {
	
	titleLabel.hidden = YES;
	[emailDown setEnabled: NO];
	emailDown.hidden = YES;
	[downloadButton setEnabled: NO];
	downloadButton.hidden = YES;
	[uploadButton setEnabled: NO];
	uploadButton.hidden = YES;
	[backButton setEnabled: NO];
	backButton.hidden = YES;
	[helpButton setEnabled: NO];
	helpButton.hidden = YES;
}

// enables all buttons and sets them visible
-(void) enableButtons {
	
	titleLabel.hidden = NO;
	[emailDown setEnabled: YES];
	emailDown.hidden = NO;
	[downloadButton setEnabled: YES];
	downloadButton.hidden = NO;
	[uploadButton setEnabled: YES];
	uploadButton.hidden = NO;
	[backButton setEnabled: YES];
	backButton.hidden = NO;
	[helpButton setEnabled: YES];
	helpButton.hidden = NO;
}


// user pressed the download button
// get their email before progressing
-(IBAction) downloadRequested {
	
	// if email hasn't been entered yet, or is empty, raise alert.
	if (emailDown.text == nil || emailDown.text == @""){
		
		[self downloadRequestAlert];
	}
	else {
		
		connectionType = DOWNLOAD;
		[statusLabel setText: @""];
		
		[self disableButtons];
		if (![activityIndicator isAnimating]) [activityIndicator startAnimating];
		NSLog(@"starting download 228");
		
		
		[self download];
		
	}

}



// user pressed the upload button
// get their email before progressing, either from profile or from text box.
-(IBAction) uploadRequestedInitialAction {
	
	// if the current email isn't empty or nil
	if ( [UIAppDelegate currentUser] != nil && [UIAppDelegate.currentUser email] != nil) { 
		
		emailUp.hidden = NO;
		[emailUp setEnabled: YES];
		emailUp.text = [UIAppDelegate.currentUser email];
		// start processing
		[self uploadRequested];
	}
	else {
		statusLabel.text = @"There is no profile to upload.";
	}

}

// we have the email, get the rest done.
-(IBAction) uploadRequested {
	
	// if email hasn't been entered do nothing
	if (emailUp.text == nil || [emailUp.text isEqual: @""]) {
		
		// do nothing
	}
	
	// otherwise check if folder exists, and if it does, write to it.
	else {
	
		if (![activityIndicator isAnimating]) {
			
			activityIndicator.hidden = NO;
			[activityIndicator startAnimating];
		}
		connectionType = UPLOAD;

		
		// attach the email as the url parameter
		NSString *urlWithEmail = [[NSString alloc] initWithFormat: @"%@%@", 
							  [GlobalAdmin getUploadFolderCheckURL], emailUp.text];
		NSLog(@"%@", urlWithEmail);
	
		NSURL *url = [NSURL URLWithString: urlWithEmail];
		[urlWithEmail release];
		NSURLRequest *request = [NSURLRequest requestWithURL: url];
	
		// load the url and parse the reponse to see if folder was created so we can write to it.
		NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: YES];
	
		if (urlConnection ){
			NSLog(@"upload folder check URL connected.");
		}
		else {
			NSLog(@"upload folder check URL failed to connect.");
		}
	
		NSError *fcError;
		NSURLResponse *fcResponse;
	
		// get response
		NSData *fcData = [NSURLConnection sendSynchronousRequest: request
											   returningResponse: &fcResponse error: &fcError];
	
		// response positive => folder created. write to it.
		if ([self parseFolderCheckResponse: fcData]) {
		
			NSLog(@"folder created.");
			//[activityIndicator startAnimating];
			[self upload];
		}
		// response negative => folder not created. fail.
		else {
		
			NSLog(@"failed to create folder.");
			[statusLabel setText: @"Error while uploading, try again."];
		
		}
	
		// release connection
		NSLog(@"before urlConnection release in uploadrequested");
		[urlConnection release];
	}
}

// check response of folder check URL
// returns YES if folder was created, NO otherwise.
-(BOOL) parseFolderCheckResponse: (NSData*)data {

	NSString *webpageResponse = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
	if (webpageResponse == nil) return NO;
	NSLog(@"response: %@", webpageResponse);
	// if response is empty, return NO
	
	
	// if response contains "folder created." return YES
	NSRange correctResponse =[[webpageResponse lowercaseString] rangeOfString:[@"yes" lowercaseString]];
	NSLog(@"before webresponse release");
	[webpageResponse release];
	
	if(correctResponse.location != NSNotFound) {
		
		return YES;
	}
	else {
		
		return NO;
	}
}



// prompt the user for an email address
// or notify them of failure
- (BOOL) getEmailFromHiddenField {
	
	UITextField *email;
	if (connectionType == UPLOAD){
		email = emailUp;
	}
	else {
		email = emailDown;
	}
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



// display help for the load profile menu
-(IBAction) helpScreen {
	
	// Navigation logic may go here -- for example, create and push another view controller.
	HelpScreenController *helpView = [[HelpScreenController alloc] initWithNibName:@"HelpScreenController" bundle:nil];
	[self.navigationController pushViewController:helpView animated:YES];
	[helpView release];
}


- (void)_updateStatus:(NSString *)statusString {
	if (statusString != nil)
		NSLog(@"inside _upadateStatus with status: %@", statusString);
	else NSLog(@"update status with nil statusstring");
    //assert(statusString != nil);
   // self.statusLabel.text = statusString;
}

- (void)_sendDidStopWithStatus:(NSString *)statusString {
	
	
    if (statusString == nil) {
		NSLog(@"starting _sendDidStopWithStatus: %@", statusString);
        //statusString = @"Put succeeded";
    }
	else NSLog(@"send did stop with status = nil");
    //self.statusLabel.text = statusString;
   // self.cancelButton.enabled = NO;
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
		NSLog(@"closing networkStreamOut");
    }
    if (self.fileStreamIn != nil) {
        [self.fileStreamIn close];
        self.fileStreamIn = nil;
		NSLog(@"closing filestreamin");
    }
	if (statusString != nil) NSLog(@"stop send with status: %@", statusString);
	
	// completed upload, update UI.
	else [self uploadComplete];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our 
// network stream.
{
#pragma unused(aStream)
	
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
                    [self _stopSendWithStatus: nil];
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
			// stop in-progress animation
			[activityIndicator stopAnimating];
			
			// enable buttons
			[downloadButton setEnabled: YES];
			[uploadButton setEnabled: YES];
			[helpButton setEnabled: YES];
			[backButton setEnabled: YES];
			
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
	
}

// update the label if no internet connection is found
-(void) failedConnectionResponse {
	
	[statusLabel setText: @"Couldn't connect..."];
	[self enableButtons];
	emailUp.hidden = YES;
	emailDown.hidden = YES;
	
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
	emailDown.text = nil;
	[emailDown setEnabled: NO];
	emailDown.hidden = YES;
	
	emailUp.text = nil;
	[emailUp setEnabled: NO];
	emailUp.hidden = YES;
	
	[self.navigationController setNavigationBarHidden:TRUE animated: NO ];
	
	// test for an internet connection
	// if none was found
	if (! [GlobalAdmin connectedToNetwork]) {
		
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
	
}


// delegate function that runs every time the view returns from "back" of another screen
- (void)viewDidAppear:(BOOL)animated {
    
	[super viewDidAppear:animated];
	
	[[UIApplication sharedApplication] setStatusBarHidden: YES animated: NO];
	NSLog(@"network view did appear.");
	[self.navigationController setTitle: @"networkView"];
	
	// load the current profile
	[GlobalAdmin loadSettings];
	
	
}

- (void) viewWillDisappear:(BOOL)animated {
	
	// play button click
	[MindBlasterAppDelegate playButtonClick];
}


// converts email string to md5 string
-(NSString*) emailToMD5: (NSString*) email {

	const char *cStr = [email UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, [email length], result );
	NSString *tempString = [[NSString alloc] initWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
							result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
							result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
							];
	NSLog(@"before md5 autorelease");
	[tempString autorelease];
	
	// return in lowercase
	return [tempString lowercaseString];
}
 

// download a file
-(IBAction) download {	
		
	assert (emailDown.text != nil && ! [emailDown.text isEqualToString: @""]);
	
	NSString *md5Email = [self emailToMD5: emailDown.text];
	NSLog(@"email: %@ md5: %@", emailDown.text, md5Email);
	
	// run the update script before downloading
	//NSLog(@"updating the download DB script");
	//NSLog(@"email: %@",[UIAppDelegate.currentUser email]);
	//[self updateDBDownload];

	
	// save path
	//NSString *fileString = [[GlobalAdmin getPath] retain];
	NSString *fileString = [GlobalAdmin getPath];
	
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
	
	NSLog(@"md5: %@",[GlobalAdmin getURL]);
	
	// read plist into a dictionary
	NSString *urlString = [[NSString alloc] initWithFormat: @"%@%@/UserProfile.plist", [GlobalAdmin getURL],  md5Email];
	
	// for debug: 
	NSLog(@"downloading: %@", urlString);
	
	NSURL *url = [[NSURL URLWithString: urlString] retain];
	assert (url != nil);
	NSLog(@"before urlString release in download");
	[urlString release];
	
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

	[url release];
	[profile release];
	
	self.statusLabel.text = @"Download Complete.";
	activityIndicator.hidden = NO;
	[activityIndicator stopAnimating];
	
	[self enableButtons];
	emailDown.text = @"";
	emailDown.hidden = YES;
	
	[UIAppDelegate didStartNetworking];
	
	NSLog(@"finished download");
	connectionType = -1;
}

// upload a file
-(IBAction)upload {
	
	connectionType == UPLOAD;
	
	NSString *md5Email = [self emailToMD5: emailUp.text];
	NSLog(@"email: %@ md5(32): %@", emailUp.text, md5Email);


	
	// get the ftp url from ApplicationSettings.plist
	NSString *urlString = [[NSString alloc] initWithFormat: @"%@%@/UserProfile.plist", [GlobalAdmin getURL],  md5Email];
	NSLog(@"upload URL path: %@",urlString);

	// get the local file path for the profile
	NSString *fileString = [GlobalAdmin getPath];
	
	NSLog(@"upload file path: %@",fileString);
	
	// create the url
	NSURL *url = [NSURL URLWithString: urlString];
	NSLog(@"before urlString release in upload");
	[urlString release];
	
	// make sure we have a file to upload
	if ( [[NSFileManager defaultManager] fileExistsAtPath: fileString ] ) 
	{
	
		// for debugging
		NSLog(@"uploading: %@", fileString);
		NSLog(@"to: %@", urlString);
	
		// update UI indicators
		self.statusLabel.text = @"Upload Started.";
		if (![activityIndicator isAnimating]) {
			
			activityIndicator.hidden = NO;
			[activityIndicator startAnimating];
		}
		[self disableButtons];
		emailUp.hidden = YES;
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
		
	}
	// we have no profile to upload
	else {
		
		self.statusLabel.text = @"No profile available.";
	}
	
	//[self didStartNetworking];
	 NSLog(@"end of upload");
	
	connectionType = -1;
}

// stop activity indicator and update the db script
-(void)uploadComplete {
	
	self.statusLabel.text = @"Upload Complete.";
	[self enableButtons];
	emailUp.hidden = YES;
	emailDown.hidden = YES;
	
	NSLog(@"upload complete.");
	[backButton setEnabled: YES];
	[helpButton setEnabled: YES];
	[downloadButton setEnabled: YES];
	[uploadButton setEnabled: YES];
	
	[activityIndicator stopAnimating];
	//activityIndicator.hidden = YES;
	
	// update the upload script
	NSLog(@"updating upload script");
	
	[self updateDBUpload];

}
 

// to be implemented
-(void) didStartNetworking {
	NSLog(@"inside didStartNetworking");
	//[activityIndicator startAnimating];
}


// to be implemented
-(void) didStopNetworking {
	NSLog(@"inside didStopNetworking");
	
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

	//NSLog(@"starting indicator");
	
	//activityIndicator.hidden = NO;
	//[activityIndicator startAnimating];
	
	// disable buttons while processing request
	//[downloadButton setEnabled: NO];
	//[uploadButton setEnabled: NO];
	//[backButton setEnabled: NO];
	//[helpButton setEnabled: NO];

	
	// play inside click
	[MindBlasterAppDelegate playInsideClick];
}

// start progress indicator animation
-(IBAction)startIndicator{

	//activityIndicator.hidden = NO;
	//[activityIndicator startAnimating];
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
