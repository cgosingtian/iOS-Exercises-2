//
//  KLBShip.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBShip.h"
#import "KLBTurret.h"

@implementation KLBShip

@synthesize healthMaximum = _healthMaximum,
            healthRemaining = _healthRemaining,
            airBombs = _airBombs,
            velocity = _velocity,
            coordinates = _coordinates,
            turrets = _turrets;

#pragma mark - Dealloc
- (void) dealloc {
    [_turrets release];
    _turrets = nil;
    
    [super dealloc];
}

#pragma mark - Initializers
// Designated Initializer
- (instancetype) init {
    self = [super init];
    if (self) {
        _healthMaximum = 10;
        _healthRemaining = _healthMaximum;
        _airBombs = 2;
        _velocity = 5.0;
        _coordinates.x = 0.0;
        _coordinates.y = 0.0;
        _turrets = [[NSMutableDictionary alloc] init];
        KLBTurret *defaultTurret = [[KLBTurret alloc] initWithTurretType:ttDefault];
        [_turrets setObject:defaultTurret forKey:[NSString stringWithFormat:@"%f",defaultTurret.angle]];
    }
    return self;
}

- (void) addTurret:(KLBTurret *)t
{
    [_turrets setObject:t forKey:[NSString stringWithFormat:@"%f",t.angle]];
}

@end
