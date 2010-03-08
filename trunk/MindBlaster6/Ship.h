//
//  Ship.h
//  MindBlaster
//
//  Created by yaniv haramati on 05/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Ship : UIViewController {
	IBOutlet UIImageView *ship;
	CGPoint pos;
	CGFloat direction;
	
}
@property (nonatomic,retain) IBOutlet UIImageView *ship;

-(void)setIcon:(UIImageView*)icon;
-(IBAction)rotate:(CGFloat)angle;
-(IBAction)fire;

@end
