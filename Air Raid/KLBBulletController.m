//
//  KLBBulletController.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBulletController.h"
#import "KLBBulletView.h"

@interface KLBBulletController ()

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

@end

@implementation KLBBulletController

@synthesize maximumDistance = _maximumDistance,
            bulletView = _bulletView,
            bullet = _bullet,
            launchAngle = _launchAngle,
            bulletDirection = _bulletDirection,
            coordinates = _coordinates,
            traversedDistance = _traversedDistance,
            timer = _timer;

- (void) dealloc {
    [[self timer] invalidate];
    [[self timer] release];
    [_bulletView release];
    [_bullet release];
    
    [self setTimer:nil];
    _bulletView = nil;
    _bullet = nil;
    
    [super dealloc];
}

#pragma mark - Initializers
- (instancetype) initWithBulletView:(KLBBulletView *)bv bullet:(KLBBullet *)b launchAngle:(CGFloat)a coordinates:(CGPoint)c {
    self = [super init];
    if (self) {
        if (!bv) {
            bv = [[KLBBulletView alloc] initWithBulletType:b];
        }
        _bulletView = bv;
        _bullet = b;
        _launchAngle = [self limitAngle:a];
        _coordinates = c;
        
        _maximumDistance = 500.0;
        _traversedDistance = 0.0;
        
        [self matchBulletWithView];
        
        [bv updateCoordinatesX:c.x Y:c.y];
    }
    return self;
}

// Due to complexities with having to compute trajectory with angles, we'll just
// restrict firing to the vertical and horizontal axes
- (CGFloat) limitAngle: (CGFloat)a {
    CGFloat limitedAngle = 0.0;
    
    // wrap angle around 360 degrees
    if (a > 360) a = fmodf(a, 360.0);
    
    if ((a > 0.0 && a <= 45) || (a > 315 && a <= 360)) {
        limitedAngle = 0.0;
        _bulletDirection = bdLeft;
    } else if (a > 45 && a <= 135) {
        limitedAngle = 90.0;
        _bulletDirection = bdUp;
    } else if (a > 135 && a <= 225) {
        limitedAngle = 180.0;
        _bulletDirection = bdRight;
    } else if (a > 225 && a <= 315) {
        limitedAngle = 270.0;
        _bulletDirection = bdDown;
    }
    return  limitedAngle;
}

- (void) matchBulletWithView {
    [_bulletView changeBulletImage:_bullet.bulletType];
}

- (void) moveBullet:(id) sender {
    CGFloat velocity = _bullet.velocity;
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
    if (_traversedDistance >= _maximumDistance) {
        [[self timer] invalidate];
//        [[self timer ] release];
//        [self setTimer:nil];
        self = nil;
    }
}

- (void) launchBullet {
    if (![self timer]) {
        [self setTimer:[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveBullet:) userInfo:nil repeats:YES]];
        [_bulletView animateFadeIn];
    }
}

#pragma mark - Getters and Setters
- (NSTimer *)timer {
    return _timer;
}
- (void) setTimer:(NSTimer *)timer {
    _timer = timer;
}

@end
