//
//  GlobalAdmin.h
//  MindBlaster
//
//  Created by John Kehler on 3/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalAdmin : NSObject {
}

-(void)InitProfile;
-(BOOL)WriteToFile;
-(BOOL)ReadFromFile;
//-(NSString)Rename;

@end
