//
//  Sound.h
//  MindBlaster
//
//  Created by yaniv haramati on 30/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

// constants\

// effects
#define	LASER_EFFECT_1			@"LaserEffect1.caf"
#define ASTEROID_EXPLOSION_1	@"Explosion1.caf"
#define ASTEROID_EXPLOSION_2	@"Explosion1.caf"
#define ASTEROID_EXPLOSION_3	@"Explosion1.caf"
#define SHIP_EXPLOSION_1		@"Explosion1.caf"

// BG music
#define BACKGROUND_MUSIC_1		@"AsteroidLevel1.m4a"
#define BACKGROUND_MUSIC_2		@"AsteroidLevel2.m4a"
#define BACKGROUND_MUSIC_3		@"AsteroidLevel3.m4a"


@interface Sound : NSObject <AVAudioPlayerDelegate>{

	NSError *error;
	NSURL *bgSoundURL;
	NSURL *laserSoundURL;
	NSURL *asteroidExplosionSoundURL;
	NSURL *shipExplosionSoundURL;
	
	AVAudioPlayer *bgPlayer;
	AVAudioPlayer *laserPlayer;
	AVAudioPlayer *explosionPlayer;
	
	BOOL			bgIsPlaying;
	
}

@property (nonatomic, retain) NSError *error;
@property (nonatomic, retain) NSURL *bgSoundURL;
@property (nonatomic, retain) NSURL *laserSoundURL;
@property (nonatomic, retain)  NSURL *asteroidExplosionSoundURL;
@property (nonatomic, retain)  NSURL *shipExplosionSoundURL;
@property (nonatomic, retain) AVAudioPlayer *bgPlayer;
@property (nonatomic, retain) AVAudioPlayer *laserPlayer;
@property (nonatomic, retain) AVAudioPlayer *explosionPlayer;
@property (nonatomic) BOOL			bgIsPlaying;

-(id)initWithSoundFiles	:(NSString*)newBackground bgExt:(NSString*)newBGExtension 
				   laser:(NSString*)newLaser lasterExt:(NSString*)newLaserExtension
		   shipExplosion:(NSString*)newShipExplosion shipExplosionExt:(NSString*)newShipExplosionExtension
	   asteroidExplosion:(NSString*)newAsteroidExplosion asteroidExplosionExt:(NSString*)newAsteroidExplosionExtension; 


-(void) playBG;
-(void) playLaser;
-(void) playAsteroidExplosion;
-(void) dealloc;

@end
