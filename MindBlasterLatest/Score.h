//
//  Score.h
//  MindBlaster
//
//  Created by John Kehler on 3/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Score : NSObject {
	int score;
}
@property(nonatomic) int score;
-(id)initWithScore:(int)newScore;
@end
