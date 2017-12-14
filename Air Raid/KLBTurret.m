//
//  KLBTurret.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBTurret.h"
#import "KLBBullet.h"
#import "KLBShip.h"

CGFloat const KLB_TURRET_ANGLE_DEFAULT = 0.0;
CGFloat const KLB_TURRET_MACHINEGUN_FIRING_SPEED = 0.1;
CGFloat const KLB_TURRET_CANNON_FIRING_SPEED = 1.0;
CGFloat const KLB_TURRET_DEFAULT_FIRING_SPEED = 0.5;

@implementation KLBTurret

#pragma mark - Dealloc
- (void) dealloc {
    [_owner release];
    [_bullet release];
    
    _owner = nil;
    _bullet = nil;
    
    [super dealloc];
}

#pragma mark - Initializers
// Designated Initializer
- (instancetype) initWithTurretType:(TurretTypes)turretType owner:(KLBShip *)shipOwner {
    self = [super init];
    KLBBullet *bulletInit;
    if (self) {
        bool playerBullet = false;
        if ([shipOwner isPlayer]) playerBullet = true;
        switch (turretType)
        {
            case ttMachineGun:
                bulletInit = [[KLBBullet alloc] initWithBulletType:btMachineGun
                                                      playerBullet:playerBullet];
                [self setTurretType:turretType
                              angle:KLB_TURRET_ANGLE_DEFAULT
                        firingSpeed:KLB_TURRET_MACHINEGUN_FIRING_SPEED
                             bullet:bulletInit];
                break;
            case ttCannon:
                bulletInit = [[KLBBullet alloc] initWithBulletType:btCannon
                                                      playerBullet:playerBullet];
                [self setTurretType:turretType
                              angle:KLB_TURRET_ANGLE_DEFAULT
                        firingSpeed:KLB_TURRET_CANNON_FIRING_SPEED
                             bullet:bulletInit];
                break;
            case ttDefault:
                bulletInit = [[KLBBullet alloc] initWithBulletType:btDefaultBulletType
                                                      playerBullet:playerBullet];
                [self setTurretType:turretType
                              angle:KLB_TURRET_ANGLE_DEFAULT
                        firingSpeed:KLB_TURRET_DEFAULT_FIRING_SPEED
                             bullet:bulletInit];
                break;
                default:
                bulletInit = [[KLBBullet alloc] initWithBulletType:btDefaultBulletType
                                                      playerBullet:playerBullet];
                [self setTurretType:turretType
                              angle:KLB_TURRET_ANGLE_DEFAULT
                        firingSpeed:KLB_TURRET_DEFAULT_FIRING_SPEED
                             bullet:bulletInit];
                break;
        }
        //[bulletInit release];
        
        _owner = shipOwner;
    }
    
    return self;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self = [self initWithTurretType:ttDefault owner:nil];
    }
    return self;
}

#pragma mark - Getters and Setters
- (void) setAngle:(CGFloat)angle {
    _angle = angle;
}

- (void) setTurretType:(TurretTypes)turretType angle:(CGFloat)angle firingSpeed:(CGFloat)firingSpeed bullet:(KLBBullet *)bullet {
    _turretType = turretType;
    _angle = angle;
    _firingSpeed = firingSpeed;
    _bullet = bullet;
}

- (CGFloat) firingSpeed {
    return _firingSpeed;
}

- (KLBBullet *) bullet {
    return _bullet;
}

- (KLBShip *) owner {
    return _owner;
}

@end
