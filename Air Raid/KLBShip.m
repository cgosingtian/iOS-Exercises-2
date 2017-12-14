//
//  KLBShip.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBShip.h"
#import "KLBTurret.h"
#import "KLBConstants.h"

//Standard ship defaults
NSUInteger const KLB_SHIP_HEALTH_MAXIMUM = 10;
NSUInteger const KLB_SHIP_AIR_BOMBS = 0;
CGFloat const KLB_SHIP_VELOCITY = 1.0;

//Enemy ship defaults
CGFloat const KLB_SHIP_ENEMY_TURRET_ANGLE = 270.0;
CGFloat const KLB_SHIP_ENEMY_FIRING_SPEED_SECONDS = 2.0;

//Player ship defaults
NSUInteger const KLB_SHIP_PLAYER_AIR_BOMBS = 2;
CGFloat const KLB_SHIP_PLAYER_VELOCITY = 2.0;
CGFloat const KLB_SHIP_PLAYER_TURRET_ANGLE = 90.0;

@implementation KLBShip

#pragma mark - Dealloc
- (void) dealloc {
    for (KLBTurret *turret in _turrets) {
        [turret setOwner:nil];
    }
    [_turrets release];
    _turrets = nil;
    
    [super dealloc];
}

#pragma mark - Initializers
// Designated Initializer
- (instancetype) init {
    self = [super init];
    if (self) {
        _healthMaximum = KLB_SHIP_HEALTH_MAXIMUM;
        _healthRemaining = _healthMaximum;
        _airBombs = KLB_SHIP_AIR_BOMBS;
        _velocity = KLB_SHIP_VELOCITY;
        _coordinates.x = KLB_ZERO_F;
        _coordinates.y = KLB_ZERO_F;
        _turrets = [[NSMutableDictionary alloc] init];
        KLBTurret *defaultTurret = [[KLBTurret alloc] initWithTurretType:ttDefault
                                                                   owner:self];
        [defaultTurret setAngle:KLB_SHIP_ENEMY_TURRET_ANGLE];
        [defaultTurret setFiringSpeed:KLB_SHIP_ENEMY_FIRING_SPEED_SECONDS];
        [_turrets setObject:defaultTurret
                     forKey:[NSString stringWithFormat:@"%f",KLB_SHIP_ENEMY_TURRET_ANGLE]];
        _isPlayer = false;
        [defaultTurret release];
    }
    return self;
}
// Designated Initializer for Player
- (instancetype) initPlayerShip {
    self = [super init];
    if (self) {
        _healthMaximum = KLB_SHIP_HEALTH_MAXIMUM;
        _healthRemaining = _healthMaximum;
        _airBombs = KLB_SHIP_PLAYER_AIR_BOMBS;
        _velocity = KLB_SHIP_PLAYER_VELOCITY;
        _coordinates.x = KLB_ZERO_F;
        _coordinates.y = KLB_ZERO_F;
        _turrets = [[NSMutableDictionary alloc] init];
        KLBTurret *defaultTurret = [[KLBTurret alloc] initWithTurretType:ttMachineGun
                                                                   owner:self];
        [_turrets setObject:defaultTurret
                     forKey:[NSString stringWithFormat:@"%f",KLB_SHIP_PLAYER_TURRET_ANGLE]];
        _isPlayer = YES;
        [defaultTurret release];
    }
    return self;
}

#pragma mark - Utility
- (void) addTurret:(KLBTurret *)t
{
    [_turrets setObject:t
                 forKey:[NSString stringWithFormat:@"%f",t.angle]];
}

#pragma mark - Getters and Setters
- (CGPoint) coordinates {
    return _coordinates;
}

- (BOOL) isPlayer {
    return _isPlayer;
}

@end
