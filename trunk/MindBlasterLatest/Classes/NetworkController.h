//
//  NetworkController.h
//  MindBlaster
//
//  Created by yaniv haramati on 21/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalAdmin.h"

enum {
    kSendBufferSize = 32768
};

@interface NetworkController : UIViewController <UITextFieldDelegate> {

    UITextField *               _urlText;
    UITextField *               _usernameText;
    UITextField *               _passwordText;
    UILabel *                   _statusLabel;
    UIActivityIndicatorView *   _activityIndicator;
    UIBarButtonItem *           _cancelButton;
    
    NSOutputStream *            _networkStream;
    NSInputStream *             _fileStream;
    uint8_t                     _buffer[kSendBufferSize];
    size_t                      _bufferOffset;
    size_t                      _bufferLimit;
	
	IBOutlet UIImageView *imageView;
	IBOutlet UITextField *fileText;

}

@property (nonatomic, retain) IBOutlet UITextField *               fileText;
@property (nonatomic, retain) IBOutlet UITextField *               urlText;
@property (nonatomic, retain) IBOutlet UITextField *               usernameText;
@property (nonatomic, retain) IBOutlet UITextField *               passwordText;
@property (nonatomic, retain) IBOutlet UILabel *                   statusLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *   activityIndicator;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *           cancelButton;

//-(IBAction)sendAction;
//-(IBAction)cancelAction:(id)sender;
-(IBAction)download;
-(IBAction)upload;


@end