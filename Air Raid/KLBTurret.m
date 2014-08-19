//
//  KLBTurret.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBTurret.h"
#import "KLBBullet.h"

@implementation KLBTurret

@synthesize angle = _angle,
            firingSpeed = _firingSpeed,
            bullet = _bullet,
            turretType = _turretType;

#pragma mark - Dealloc
- (void) dealloc {
    [_bullet release];
    _bullet = nil;
    
    [super dealloc];
}

#pragma mark - Initializers
// Designated Initializer
- (instancetype) init {
    self = [super init];
    if (self) {
        _angle = 0.0;
        _firingSpeed = 1.0;
        _bullet = [[KLBBullet alloc] initWithBulletType:btDefault];
        _turretType = ttDefault;
    }
    return self;
}

- (instancetype) initWithTurretType:(TurretTypes)t {
    self = [super init];
    KLBBullet *bulletInit;
    if (self) {
        switch (t)
        {
            case ttMachineGun:
                bulletInit = [[KLBBullet alloc] initWithBulletType:btMachineGun];
                [self setTurretType:t angle:0.0 firingSpeed:2.0 bullet:bulletInit];
                break;
            case ttCannon:
                bulletInit = [[KLBBullet alloc] initWithBulletType:btCannon];
                [self setTurretType:t angle:0.0 firingSpeed:0.5 bullet:bulletInit];
                break;
            case ttDefault:
                bulletInit = [[KLBBullet alloc] initWithBulletType:btDefault];
                [self setTurretType:t angle:0.0 firingSpeed:1.0 bullet:bulletInit];
                break;
                default:
                bulletInit = [[KLBBullet alloc] initWithBulletType:btDefault];
                [self setTurretType:t angle:0.0 firingSpeed:1.0 bullet:bulletInit];
                break;
        }
    }
    [bulletInit release];
    return self;
}

#pragma mark - Getters and Setters

- (void) setAngle:(CGFloat)angle {
    _angle = angle;
}

- (void) setTurretType:(TurretTypes)t angle:(CGFloat)a firingSpeed:(CGFloat)f bullet:(KLBBullet *)b {
    _turretType = t;
    _angle = a;
    _firingSpeed = f;
    _bullet = b;
}

@end
