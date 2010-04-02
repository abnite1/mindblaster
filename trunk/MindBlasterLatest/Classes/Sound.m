//
//  Sound.m
//  MindBlaster
//
//  Created by yaniv haramati on 30/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sound.h"


@implementation Sound

@synthesize errorBG, errorLaser, errorExplosion, bgSoundURL;
@synthesize laserSoundURL, asteroidExplosionSoundURL, shipExplosionSoundURL;
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



// inits the next bg theme
-(void) initNextBG:(NSURL*)currentBGURL {
	
	NSArray *firstTheme = [BACKGROUND_MUSIC_1 componentsSeparatedByString: @"."];
	NSArray *secondTheme = [BACKGROUND_MUSIC_2 componentsSeparatedByString: @"."];
	NSArray *thirdTheme = [BACKGROUND_MUSIC_3 componentsSeparatedByString: @"."];
	
	NSArray *urlArray = [[NSArray alloc] initWithObjects:	[NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
																					 [firstTheme objectAtIndex: 0] ofType: [firstTheme objectAtIndex: 1]]], 
						 [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
												  [secondTheme objectAtIndex: 0] ofType: [secondTheme objectAtIndex: 1]]],
						 [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: 
												  [thirdTheme objectAtIndex: 0] ofType: [thirdTheme objectAtIndex: 1]]], nil];
	
	int index;
	
	// switch theme to any of the three that didn't just finish playing
	do {
		
		index = arc4random() % 3; // random # in the range of [0,2]
		//NSLog(@"index inside initNextBG: %d", index);
		bgSoundURL = [urlArray objectAtIndex: index]; 
		
		//NSLog(@"current path: %@\n bgSoundURL path: %@\n", [currentBGURL path], [bgSoundURL path]);
		
	}while ([[currentBGURL path] isEqual: [bgSoundURL path]]);
	
	//NSLog(@"chosen index: %d", index);
	
	[bgSoundURL retain];
	[urlArray release];
	
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
		
		NSLog(@"error playing laser sound");
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
		// switch to the next theme and restart playing
		[self initNextBG: bgSoundURL];
		[self playBG];
	}
	else {
		
		[player release];
		player = nil;
	}
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
