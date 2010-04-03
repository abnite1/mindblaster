//
//  Bullet.h
//  MindBlaster
//
//  Created by yaniv haramati on 19/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Bullet : NSObject {

	

	IBOutlet UIImageView *bulletIcon;
	CGPoint bulletPosition;
	CGPoint bulletDirection;
	
}

@property (nonatomic,retain) IBOutlet UIImageView *bulletIcon;
@property (nonatomic) CGPoint bulletDirection;
@property (nonatomic) CGPoint bulletPosition;

-(void)setBulletPosition:(int)x :(int)y;
-(void)setBulletDirection:(int)x :(int)y;
-(IBAction)move;

//unit tests
-(void) moveUnitTest;
-(void) rotate: (CGFloat)angle;
@end
