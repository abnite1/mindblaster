//
//  MindBlasterAppDelegate.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "UserProfile.h"

//this line and the method of making the profile an attribute of appdelegate
//was taken from a website by some guy (forgot where) but its not my own.
#define UIAppDelegate \
((MindBlasterAppDelegate *)[UIApplication sharedApplication].delegate)

@interface MindBlasterAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *					window;
    UINavigationController *	navigationController;
	
	NSInteger					networkingCount;
	UserProfile *				currentUser;
}

@property (nonatomic, retain) UserProfile *						currentUser;
@property (nonatomic, retain) IBOutlet UIWindow *				window;
@property (nonatomic, retain) IBOutlet UINavigationController *	navigationController;
@property (nonatomic, assign) NSInteger							networkingCount;


- (void)didStartNetworking;
- (void)didStopNetworking;


@end

