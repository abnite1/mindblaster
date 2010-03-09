//
//  UserProfile.h
//  MindBlaster
//
//  Created by John Kehler on 3/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject {
	NSString *userName;
	UIImage *profilePic;
	int score;
	int stageChosen;
	int diffChosen;
	NSString *email;
	int highestStageComplete;
	
	int highestStageOneDiff;
	int highestStageTwoDiff;
	int highestStageThreeDiff;
	int highestStageFourDiff;
}

//public method signatures
- (void)setPic: (UIImage *) newPic;
- (UIImage *)getPic;
- (void)setName: (NSString *) newName;
- (NSString *) getName;
- (void) setStage: (int)  newStage;
- (int) getStage;
- (void) setDiff: (int) newDiff;
- (int) getDiff;
- (void) setScore: (int) newScore;
- (int) getScore;

- (void) setHighStage: (int) newHighStage;
- (int) getHighStage;
- (void) setHighStageOneDiff: (int) newDiff;
- (void) setHighstageTwoDiff: (int) newDiff;
- (void) setHighstageThreeDiff: (int) newDiff;
- (void) setHighstageFourDiff: (int) newDiff;
- (int) getHighStageOneDiff;
- (int) getHighStageTwoDiff;
- (int) getHighStageThreeDiff;
- (int) getHighStageFourDiff;



@end
