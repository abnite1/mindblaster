//
//  NetworkController.m
//  MindBlaster
//
//  Created by yaniv haramati on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NetworkController.h"
#include <CFNetwork/CFNetwork.h>

@interface NetworkController ()
// Properties that don't need to be seen by the outside world.



@property (nonatomic, readonly) BOOL              isSending;
@property (nonatomic, retain)   NSOutputStream *  networkStream;
@property (nonatomic, retain)   NSInputStream *   fileStream;
@property (nonatomic, readonly) uint8_t *         buffer;
@property (nonatomic, assign)   size_t            bufferOffset;
@property (nonatomic, assign)   size_t            bufferLimit;

@end

@implementation NetworkController

@synthesize fileText;


#pragma mark * Status management

// These methods are used by the core transfer code to update the UI.



- (void)_sendDidStart
{
    self.statusLabel.text = @"Please wait for transfer to complete.";
    //self.cancelButton.enabled = YES;
    [self.activityIndicator startAnimating];
   //[[AppDelegate sharedAppDelegate] didStartNetworking];
}

- (void)_updateStatus:(NSString *)statusString
{
    assert(statusString != nil);
    self.statusLabel.text = statusString;
}

- (void)_sendDidStopWithStatus:(NSString *)statusString
{
    if (statusString == nil) {
        statusString = @"Put succeeded";
    }
    self.statusLabel.text = statusString;
   // self.cancelButton.enabled = NO;
    //[self.activityIndicator stopAnimating];
	//[[AppDelegate sharedAppDelegate] didStartNetworking];
}


#pragma mark * Core transfer code

// This is the code that actually does the networking.

@synthesize networkStream = _networkStream;
@synthesize fileStream    = _fileStream;
@synthesize bufferOffset  = _bufferOffset;
@synthesize bufferLimit   = _bufferLimit;

// Because buffer is declared as an array, you have to use a custom getter.  
// A synthesised getter doesn't compile.

- (uint8_t *)buffer
{
    return self->_buffer;
}

- (BOOL)isSending
{
    return (self.networkStream != nil);
}

/*
- (void)_startSend:(NSString *)filePath
{
    BOOL                    success;
    NSURL *                 url;
    CFWriteStreamRef        ftpStream;
//	NSString*				stringUrl;
    
    assert(filePath != nil);

	// test that the file exists
	// get the local path for the file from the /Documents directory
 
	
	NSArray *paths =	NSSearchPathForDirectoriesInDomains(
															NSDocumentDirectory, 
															NSUserDomainMask, YES); 
	NSString* docDir = [paths objectAtIndex:0];
	 
	
	// get it from the local path
	NSString *finalPath = [docDir stringByAppendingPathComponent:self.fileText.text];
	assert ([[NSFileManager defaultManager] fileExistsAtPath: finalPath ]);

    
	// assert( [filePath.pathExtension isEqual:@"plist"] )
    
    //assert(self.networkStream == nil);      // don't tap send twice in a row!
    //assert(self.fileStream == nil);         // ditto
	
    // First get and check the URL.
   // url = [[AppDelegate sharedAppDelegate] smartURLForString:self.urlText.text];
	//stringUrl = @"fraser.sfu.ca/";
	url = [NSURL URLWithString:[NSString  stringWithString : finalPath]];
    success = (url != nil);

    if (success) {
		NSLog(@"url: %@", url);
        // Add the last part of the file name to the end of the URL to form the final 
        // URL that we're going to put to.
        
        url = [NSMakeCollectable(
								 CFURLCreateCopyAppendingPathComponent(NULL, (CFURLRef) url, (CFStringRef) [filePath lastPathComponent], false)
								 ) autorelease];
		 
        success = (url != nil);
    }
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
	
    if ( ! success) {
        NSLog(@"Invalid URL: %@", url);
    } else {
		
        // Open a stream for the file we're going to send.  We do not open this stream; 
        // NSURLConnection will do it for us.
        
        self.fileStream = [NSInputStream inputStreamWithFileAtPath:filePath];
        assert(self.fileStream != nil);
        
        [self.fileStream open];
        
        // Open a CFFTPStream for the URL.
		
        ftpStream = CFWriteStreamCreateWithFTPURL(NULL, (CFURLRef) url);
        assert(ftpStream != NULL);
        
        self.networkStream = (NSOutputStream *) ftpStream;
		
        if (self.usernameText.text.length != 0) {
            success = [self.networkStream setProperty:self.usernameText.text forKey:(id)kCFStreamPropertyFTPUserName];
            assert(success);
            success = [self.networkStream setProperty:self.passwordText.text forKey:(id)kCFStreamPropertyFTPPassword];
            assert(success);
        }
		
        self.networkStream.delegate = self;
        [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.networkStream open];
		NSLog(@"before stream release.");
		
        // Have to release ftpStream to balance out the create.  self.networkStream 
        // has retained this for our persistent use.
        
        CFRelease(ftpStream);
		
        // Tell the UI we're sending.
        
        //[self _sendDidStart];
    }
}
*/

- (void)_stopSendWithStatus:(NSString *)statusString
{
    if (self.networkStream != nil) {
        [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStream.delegate = nil;
        [self.networkStream close];
        self.networkStream = nil;
    }
    if (self.fileStream != nil) {
        [self.fileStream close];
        self.fileStream = nil;
    }
   // [self _sendDidStopWithStatus:statusString];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our 
// network stream.
{
#pragma unused(aStream)
    assert(aStream == self.networkStream);
	
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
                
                bytesRead = [self.fileStream read:self.buffer maxLength:kSendBufferSize];
                
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
                bytesWritten = [self.networkStream write:&self.buffer[self.bufferOffset] maxLength:self.bufferLimit - self.bufferOffset];
                assert(bytesWritten != 0);
                if (bytesWritten == -1) {
                    [self _stopSendWithStatus:@"Network write error"];
                } else {
                    self.bufferOffset += bytesWritten;
                }
            }
        } break;
        case NSStreamEventErrorOccurred: {
            [self _stopSendWithStatus:@"Stream open error"];
        } break;
        case NSStreamEventEndEncountered: {
            // ignore
        } break;
        default: {
            assert(NO);
        } break;
    }
}
 

#pragma mark * Actions

/*
- (IBAction)sendAction {
	
    if ( ! self.isSending ) {
        
        // User the tag on the UIButton to determine which image to send.
		// get the local path for the file from documents folder
		
		NSArray *paths =	NSSearchPathForDirectoriesInDomains(
																NSDocumentDirectory, 
																NSUserDomainMask, YES); 
		NSString* docDir = [paths objectAtIndex:0];
		 
		NSString *path = [[NSBundle mainBundle] bundlePath];
		NSString *finalPath = [path stringByAppendingPathComponent:	self.fileText.text];
		assert([[NSFileManager defaultManager] fileExistsAtPath:finalPath ]);
        
        assert(_urlText.text != nil);
        NSString *filePath = finalPath;
        [self _startSend: filePath];
    }
}
*/

/*
- (IBAction)cancelAction:(id)sender
{
#pragma unused(sender)
    [self _stopSendWithStatus:@"Cancelled"];
}
 */

- (void)textFieldDidEndEditing:(UITextField *)textField
// A delegate method called by the URL text field when the editing is complete. 
// We save the current value of the field in our settings.
{
	/*
    NSString *  defaultsKey;
    NSString *  newValue;
    NSString *  oldValue;
	
    
    if (textField == self.urlText) {
        defaultsKey = @"CreateDirURLText";
    } else if (textField == self.usernameText) {
        defaultsKey = @"Username";
    } else if (textField == self.passwordText) {
        defaultsKey = @"Password";
    } else {
        //assert(NO);
        defaultsKey = nil;          // quieten warning
    }
	
    newValue = textField.text;
    oldValue = [[NSUserDefaults standardUserDefaults] stringForKey:defaultsKey];
	
    // Save the URL text if it's changed.
    
    //assert(newValue != nil);        // what is UITextField thinking!?!
    //assert(oldValue != nil);        // because we registered a default
    
    if ( ! [newValue isEqual:oldValue] ) {
        [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:defaultsKey];
    }
	 */
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
// A delegate method called by the URL text field when the user taps the Return 
// key.  We just dismiss the keyboard.
{
#pragma unused(textField)
   assert( (textField == self.urlText) || (textField == self.usernameText) || 
		  (textField == self.passwordText) || textField == self.fileText);
	   
	[textField resignFirstResponder];
   
    return NO;
}

#pragma mark * View controller boilerplate

@synthesize urlText           = _urlText;
@synthesize usernameText      = _usernameText;
@synthesize passwordText      = _passwordText;
@synthesize statusLabel       = _statusLabel;
@synthesize activityIndicator = _activityIndicator;
@synthesize cancelButton      = _cancelButton;



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	/*
    assert(self.urlText != nil);
    assert(self.usernameText != nil);
    assert(self.passwordText != nil);
    assert(self.statusLabel != nil);
    assert(self.activityIndicator != nil);
    assert(self.cancelButton != nil);
	 */
	
    //self.urlText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"PutURLText"];
	
    // The setup of usernameText and passwordText deferred to -viewWillAppear: 
    // because those values are shared by multiple tabs.
    
	self.urlText.text = @"fraser.sfu.ca/leftwheel.png";
	
    self.activityIndicator.hidden = YES;
    self.statusLabel.text = @"file transfer";
   // self.cancelButton.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.usernameText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Username"];
    self.passwordText.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Password"];
}

// download a file
-(IBAction) download {

	// read plist into a dictionary
	NSString *ftpURL =  [GlobalAdmin getURL];
	//NSString *urlString = [ftpURL stringByAppendingPathComponent: @"userProfile.plist"];
	NSString *urlString = [ftpURL stringByAppendingPathComponent: @"TestImage3.png"];
	
	
	// format the url to contain an ftp://user:pass@url/file.ext format
	//NSString *urlString = [[NSString alloc] initWithFormat: @"ftp://%@:%@@%@", 
	//					   self.usernameText.text, self.passwordText.text, self.urlText.text];
	// for debug: 
	NSLog(@"%@", urlString);

	NSURL *url = [NSURL URLWithString: urlString];
	
	NSMutableDictionary *profile = [NSMutableDictionary dictionaryWithContentsOfURL: url];
	[profile writeToFile: [GlobalAdmin getPath] atomically: YES];
	
	NSData *dataImage = [NSData dataWithContentsOfURL:url];
	imageView.image=[UIImage imageWithData:dataImage];    
	
	//[self.activityIndicator startAnimating];
	//[[AppDelegate sharedAppDelegate] didStartNetworking];
	

}

// upload a file
-(IBAction)upload {
	
	// format the url to conform to the proper format for ftp authentication
	//NSString *urlString = [[NSString alloc] initWithFormat: @"ftp://%@:%@@%@", 
	//					   self.usernameText.text, self.passwordText.text, self.urlText.text];
	
	// read plist into a dictionary
	NSString *ftpURL =  [GlobalAdmin getURL];
	
	// use this function instead
	//NSString *renamedFile = [GlobalAdmin renameProfile];
	
	// temporary
	NSString *renamedFile = [[NSString alloc] initWithString: @"userProfile.plist"];
	
	NSString *urlString = [ftpURL stringByAppendingPathComponent: renamedFile];
	
	// create the url
	NSURL *url = [NSURL URLWithString: urlString];
	
	// upload from the ~/Documents/ folder 
	
	/*NSArray *paths =	NSSearchPathForDirectoriesInDomains(
						NSDocumentDirectory, 
						NSUserDomainMask, YES); 
	NSString* docDir = [paths objectAtIndex:0];
	NSString *finalPath = [docDir stringByAppendingPathComponent: self.fileText.text];*/
	
	
	
	assert([[NSFileManager defaultManager] fileExistsAtPath: renamedFile ]);
	NSLog(@"uploading: %@", [GlobalAdmin  getPath]);
	NSLog(@"to: %@", urlString);
	
	// upload from current folder
	//NSString *path = [[NSBundle mainBundle] bundlePath];
	
	// create an NSData object to store the file
	//NSData *dataImage = [NSData dataWithContentsOfFile: finalPath];
	
	self.statusLabel.text = @"starting upload";
	
	// and upload the file
	//[dataImage writeToURL:url atomically:YES];
	
	self.fileStream = [NSInputStream inputStreamWithFileAtPath: renamedFile];
	[self.fileStream open];
	CFWriteStreamRef ftpStream = CFWriteStreamCreateWithFTPURL(NULL, (CFURLRef) url);
	
	self.networkStream = (NSOutputStream *) ftpStream;
	
	self.networkStream.delegate = self;
	[self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[self.networkStream open];
	
	// Have to release ftpStream to balance out the create.  self.networkStream 
	// has retained this for our persistent use.
	
	CFRelease(ftpStream);
	
	self.statusLabel.text = @"finished upload";
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
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	
    self.urlText = nil;
    self.usernameText = nil;
	self.fileText = nil;
    self.passwordText = nil;
    self.statusLabel = nil;
    self.activityIndicator = nil;
    //self.cancelButton = nil;
}

- (void)dealloc
{
    [self _stopSendWithStatus:@"Stopped"];
	
    [self->_urlText release];
    [self->_usernameText release];
    [self->_passwordText release];
    [self->_statusLabel release];
    [self->_activityIndicator release];
	
    //[self->_cancelButton release];
	
    [super dealloc];
}


@end
