//
//  Sound.m
//  MindBlaster
//
//  Created by yaniv haramati on 30/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sound.h"


@implementation Sound

@synthesize error, bgSoundURL, laserSoundURL, asteroidExplosionSoundURL, shipExplosionSoundURL;
@synthesize bgPlayer, laserPlayer, explosionPlayer;
@synthesize bgIsPlaying;


// initialize with a new background sound file
-(id)initWithSoundFiles	:(NSString*)newBackground bgExt:(NSString*)newBGExtension 
				   laser:(NSString*)newLaser lasterExt:(NSString*)newLaserExtension
		   shipExplosion:(NSString*)newShipExplosion shipExplosionExt:(NSString*)newShipExplosionExtension
	   asteroidExplosion:(NSString*)newAsteroidExplosion asteroidExplosionExt:(NSString*)newAsteroidExplosionExtension {
	
	if ( self = [super init] ) {
		
		NSLog(@"inside sound init");		
		bgSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
											  newBackground ofType: newBGExtension]];
		
		laserSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
												 newLaser ofType: newLaserExtension]];
		
		asteroidExplosionSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
															 newAsteroidExplosion ofType: newAsteroidExplosionExtension]];

		shipExplosionSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
														 newShipExplosion ofType: newShipExplosionExtension]];
		
	
    }
	
    return self;
}



// play a sound file for background
-(void) playBG{
	
	NSLog(@"inside playBG");
	bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: bgSoundURL error: &error];
	
	if (!bgPlayer) {
		
		NSLog(@"error tyring to play background sound");
	}
	
	[bgPlayer setDelegate: self];
	
	// set the isPlaying flag
	bgIsPlaying = YES;

	[bgPlayer prepareToPlay];
	[bgPlayer play];

	
}

// play a laser sound
-(void) playLaser{
	
	NSLog(@"inside playLaser");
	laserPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: laserSoundURL error: &error];
	
	if (!laserPlayer) {
		
		NSLog(@"error player laser sound");
	}
	
	[laserPlayer setDelegate: self];
	[laserPlayer prepareToPlay];
	[laserPlayer play];

}

// play an asteroid explosion
-(void) playAsteroidExplosion {
	
	NSLog(@"inside playAsteroidExplosion");
	explosionPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: asteroidExplosionSoundURL error: &error];
	
	if (!explosionPlayer) {
		
		NSLog(@"error player laser sound");
	}
	
	[explosionPlayer setDelegate: self];
	[explosionPlayer prepareToPlay];
	[explosionPlayer play];
	
}


// delegate function to take effect when player finishes playing
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	
	if (flag) NSLog(@"finished playing successfully.");
	else NSLog(@"Error while playing.");
	
	if ([player url] == bgSoundURL) {
		
		NSLog(@"background just finished playing");
		// restart background
		[self playBG];
	}
	[player release];
}



@end
