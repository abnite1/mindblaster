//
//  Ship.h
//  MindBlaster
//
//  Created by yaniv haramati on 05/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//

#import <UIKit/UIKit.h>

static const int SHIP_SIZE_X = 40;
static const int SHIP_SIZE_Y = 41;


@interface Ship : UIViewController {
	IBOutlet UIImageView *shipIcon;
	CGPoint pos;
	CGFloat direction;
	
}
@property (nonatomic,retain) IBOutlet UIImageView *shipIcon;
@property (nonatomic) CGPoint pos;
@property (nonatomic) CGFloat direction;

-(void)setIcon:(UIImageView*)icon;
-(IBAction)rotate:(CGFloat)angle;
-(IBAction)fire;


-(void)setIconUnitTest:(UIImageView*)icon ;
@end
