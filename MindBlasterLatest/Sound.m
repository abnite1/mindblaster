//
//  Sound.m
//  MindBlaster
//
//  Created by yaniv haramati on 30/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sound.h"


@implementation Sound

@synthesize errorBG, errorLaser, errorExplosion, bgSoundURL, laserSoundURL, asteroidExplosionSoundURL, shipExplosionSoundURL;
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
		[bgSoundURL retain];
		
		laserSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
												 newLaser ofType: newLaserExtension]];
		[laserSoundURL retain];
		
		asteroidExplosionSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
															 newAsteroidExplosion ofType: newAsteroidExplosionExtension]];
		[asteroidExplosionSoundURL retain];

		shipExplosionSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
														 newShipExplosion ofType: newShipExplosionExtension]];
		[shipExplosionSoundURL retain];
		
	
    }
	
    return self;
}


// play a sound file for background
-(void) playBG{
	
	NSLog(@"inside playBG");
	bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: bgSoundURL error: &errorBG];
	
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
	
	laserPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: laserSoundURL error: &errorLaser];
	NSLog(@"inside playLaser and after alloc");
	
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
	explosionPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: asteroidExplosionSoundURL error: &errorExplosion];
	
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
		//[self playBG];
	}
	[player release];
	player = nil;
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player {
	
	NSLog(@"audio player end interrruption for player with url: %@", [player.url path]);
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
	
	NSLog(@"audio player begin interruption for player with url: %@", [player.url path]);
}

// dealloc block
-(void) dealloc {
	
	NSLog(@"in sound dealloc");
	[bgSoundURL release];
	[laserSoundURL release];
	[asteroidExplosionSoundURL release];
	[shipExplosionSoundURL release];
	[super dealloc];
	
}



@end
