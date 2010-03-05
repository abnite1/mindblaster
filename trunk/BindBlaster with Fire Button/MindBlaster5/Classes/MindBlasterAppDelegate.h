//
//  MindBlasterAppDelegate.h
//  MindBlaster
//
//  Created by Steven Verner on 2/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface MindBlasterAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

