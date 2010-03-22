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

-(void)initProfile;
-(BOOL)writeToFile;
-(BOOL)readFromFile;
//-(NSString)Rename;

@end
