//
//  KLBBulletController.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBulletController.h"
#import "KLBBulletView.h"
#import <AVFoundation/AVFoundation.h>
#import "KLBConstants.h"

CGFloat const KLB_BULLET_MAXIMUM_DISTANCE = 500.0;

NSString *const KLB_BULLET_SOUND_FILENAME_NO_EXTENSION = @"laser";
NSString *const KLB_BULLET_SOUND_FILENAME_EXTENSION_ONLY = @"aifc";

CGFloat const KLB_BULLET_MAXIMUM_ANGLE = 360.0;
CGFloat const KLB_BULLET_ANGLE_INTERVAL = 45.0;
CGFloat const KLB_BULLET_MINIMUM_ANGLE = 0.0;

CGFloat const KLB_BULLET_ANGLE_LEFT = 0.0;
CGFloat const KLB_BULLET_ANGLE_UP = 90.0;
CGFloat const KLB_BULLET_ANGLE_RIGHT = 180.0;
CGFloat const KLB_BULLET_ANGLE_DOWN = 270.0;

@interface KLBBulletController () <AVAudioPlayerDelegate>

typedef enum BulletDirection {
    bdUp,
    bdDown,
    bdLeft,
    bdRight
}BulletDirection;

@property (nonatomic) BulletDirection bulletDirection;
@property (nonatomic) CGFloat traversedDistance;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) CGFloat launchAngle;
@property (nonatomic) CGPoint coordinates;
@property (retain, nonatomic) AVAudioPlayer *avPlayer;

@end

@implementation KLBBulletController

@synthesize timer = _timer; //needed due to explicit getter and setter below

- (void) dealloc {
    // NOTE ON RELEASING
    // The objects below do not need to be released explicitly.
    // They're handled by the system and by the code of other objects.
    /*
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[self timer] invalidate];
    [[self timer] release];
    [_bulletView release];
    [_bullet release];
    [_avPlayer release];
    _avPlayer = nil;
    _bulletView = nil;
    _bullet = nil;
     */
    
    [self setTimer:nil];
    
    [super dealloc];
}

#pragma mark - Initializers
- (instancetype) initWithBulletView:(KLBBulletView *)bulletView
                             bullet:(KLBBullet *)bullet
                        launchAngle:(CGFloat)angle
                        coordinates:(CGPoint)coordinates {
    self = [super init];
    if (self) {
        if (!bulletView) {
            bulletView = [[KLBBulletView alloc] initWithBullet:bullet];
        }
        _bulletView = bulletView;
        [bulletView release];
        _bullet = bullet;
        _launchAngle = [self limitAngle:angle];
        _coordinates = coordinates;
        
        _maximumDistance = KLB_BULLET_MAXIMUM_DISTANCE;
        _traversedDistance = KLB_ZERO_F;
        
        [self matchBulletWithView];
        
        [bulletView updateCoordinatesX:coordinates.x
                                     Y:coordinates.y];
        
        NSString *soundFilePath =
        [[NSBundle mainBundle] pathForResource:KLB_BULLET_SOUND_FILENAME_NO_EXTENSION
                                        ofType:KLB_BULLET_SOUND_FILENAME_EXTENSION_ONLY];
        
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
        
        _avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
                                                           error:nil];
        _avPlayer.delegate = self;
        [_avPlayer prepareToPlay];
        [fileURL release];
    }
    return self;
}

// Due to complexities with having to compute trajectory with angles, we'll just
// restrict firing to the vertical and horizontal axes
- (CGFloat) limitAngle: (CGFloat)a {
    CGFloat limitedAngle = KLB_ZERO_F;
    
    // wrap angle around 360 degrees
    if (a > KLB_BULLET_MAXIMUM_ANGLE) a = fmodf(a, KLB_BULLET_MAXIMUM_ANGLE);
    
    CGFloat lastInterval = KLB_BULLET_MAXIMUM_ANGLE - KLB_BULLET_ANGLE_INTERVAL; // 315
    CGFloat secondToTheLastInterval = lastInterval - KLB_BULLET_ANGLE_INTERVAL*2; // 225
    CGFloat thirdToTheLastInterval = secondToTheLastInterval - KLB_BULLET_ANGLE_INTERVAL*2; // 135
    
    if ((a > KLB_BULLET_MINIMUM_ANGLE &&
         a <= KLB_BULLET_ANGLE_INTERVAL) ||
        (a > lastInterval && a <= KLB_BULLET_MAXIMUM_ANGLE)) {
        limitedAngle = KLB_BULLET_ANGLE_LEFT;
        _bulletDirection = bdLeft;
    } else if (a > KLB_BULLET_ANGLE_INTERVAL && a <= thirdToTheLastInterval) {
        limitedAngle = KLB_BULLET_ANGLE_UP;
        _bulletDirection = bdUp;
    } else if (a > thirdToTheLastInterval && a <= secondToTheLastInterval) {
        limitedAngle = KLB_BULLET_ANGLE_RIGHT;
        _bulletDirection = bdRight;
    } else if (a > secondToTheLastInterval && a <= lastInterval) {
        limitedAngle = KLB_BULLET_ANGLE_DOWN;
        _bulletDirection = bdDown;
    }
    return  limitedAngle;
}

- (void) matchBulletWithView {
    [_bulletView changeBulletImage:_bullet.bulletType];
}

- (void) moveBullet:(id) sender {
    if (_traversedDistance > _maximumDistance) {
        [[self timer] invalidate];
        [self setTimer:nil];
        self = nil;
    } else if (_bullet) {
        CGFloat velocity = [_bullet velocity];
        switch (_bulletDirection) {
            case bdUp:
                _coordinates.y-=velocity;
                break;
            case bdDown:
                _coordinates.y+=velocity;
                break;
            case bdLeft:
                _coordinates.x-=velocity;
                break;
            case bdRight:
                _coordinates.x+=velocity;
                break;
        }
        [_bulletView updateCoordinatesX:(_coordinates.x) Y:_coordinates.y];
        _traversedDistance += velocity;
    }
}

- (void) launchBullet {
    if (![self timer]) {
        if (_avPlayer) {
            [_avPlayer play];
        }
        [self setTimer:[NSTimer scheduledTimerWithTimeInterval:KLB_ANIMATION_INTERVAL
                                                        target:self
                                                      selector:@selector(moveBullet:)
                                                      userInfo:nil
                                                       repeats:YES]];
        [_bulletView animateFadeIn];
    }
}

#pragma mark - AVAudioPlayer Protocol
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    _avPlayer.delegate = nil;
    [_avPlayer release];
}

#pragma mark - Getters and Setters
- (NSTimer *)timer {
    return _timer;
}
- (void) setTimer:(NSTimer *)timer {
    _timer = timer;
}

@end
