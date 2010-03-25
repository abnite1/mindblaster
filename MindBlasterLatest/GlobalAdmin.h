//
//  GlobalAdmin.h
//  MindBlaster
//
//  Created by John Kehler on 3/20/10.
//  Restructured by Yaniv Haramati on 24/3/10. Added: getURL, getPic
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalAdmin : NSObject {

}

+(NSString *)getPath;
+(void)initProfile;
+(BOOL)saveSettings;
+(BOOL)loadSettings;
+(id) getPic:(int)position;
+(id)getURL;
//-(NSString)Rename;

@end
