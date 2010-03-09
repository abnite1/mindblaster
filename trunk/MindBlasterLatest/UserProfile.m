//
//  UserProfile.m
//  MindBlaster
//
//  Created by John Kehler on 3/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

- (void)setPic: (UIImage *) newPic {
	profilePic = newPic;
}
- (UIImage *)getPic {
	return profilePic;
}
-(void)setName: (NSString *) newName {
	userName=newName;
}
-(NSString *) getName {
	return userName;
}
-(void) setStage: (int) newStage {
	stageChosen=newStage;
}
-(int) getStage {
	return stageChosen;
}
-(void) setDiff: (int) newDiff {
	diffChosen=newDiff;
}
-(int) getDiff {
	return diffChosen;
}
-(void) setScore: (int) newScore {
	score=newScore;
}
-(int) getScore {
	return score;
}

- (void) setHighStage: (int) newHighStage {
	highestStageComplete = newHighStage;
}
- (int) getHighStage {
	return highestStageComplete;
}
- (void) setHighStageOneDiff: (int) newDiff {
	highestStageOneDiff = newDiff;
}
- (void) setHighstageTwoDiff: (int) newDiff {
	highestStageTwoDiff = newDiff;
}
- (void) setHighstageThreeDiff: (int) newDiff {
	highestStageThreeDiff  = newDiff;
}
- (void) setHighstageFourDiff: (int) newDiff {
	highestStageFourDiff = newDiff;
}
- (int) getHighStageOneDiff {
	return highestStageOneDiff;
}
- (int) getHighStageTwoDiff {
	return highestStageTwoDiff;
}
- (int) getHighStageThreeDiff {
	return highestStageThreeDiff;
}
- (int) getHighStageFourDiff {
	return highestStageFourDiff;
}

@end