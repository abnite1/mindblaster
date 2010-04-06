//
//  Statistics.h
//  MindBlaster
//
//  Created by John Kehler on 4/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Statistics : NSObject {
	int shotsFired;
	int correctHits;
	int incorrectHits;
	int blankHits;
	int additionTime;
	int subtractionTime;
	int multiplicationTime;
	int divisionTime;
}
@property (nonatomic) int shotsFired;
@property (nonatomic) int correctHits;
@property (nonatomic) int incorrectHits;
@property (nonatomic) int blankHits;
@property (nonatomic) int additionTime;
@property (nonatomic) int subtractionTime;
@property (nonatomic) int multiplicationTime;
@property (nonatomic) int divisionTime;

@end
