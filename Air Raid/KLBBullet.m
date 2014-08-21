//
//  KLBBullet.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBullet.h"

@implementation KLBBullet

@synthesize velocity = _velocity,
            damage = _damage,
            isAirBullet = _isAirBullet,
            bulletType = _bulletType;

#pragma mark - Initializers
//Designated Initializer
- (instancetype) initWithBulletType:(BulletTypes)b playerBullet:(bool)p {
    self = [super init];
    _playerBullet = p;
    switch (b) {
        case btMachineGun:
            [self setBulletType:b velocity:5.0 damage:1 isAirBullet:true];
            break;
        case btCannon:
            [self setBulletType:b velocity:0.5 damage:4 isAirBullet:true];
            break;
        case btDefault:
            [self setBulletType:btDefault velocity:2.0 damage:2 isAirBullet:true];
            break;
        default:
            [self setBulletType:btDefault velocity:10.0 damage:2 isAirBullet:true];
    }
    return self;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self = [self initWithBulletType:btDefault playerBullet:false];
    }
    return self;
}

#pragma mark - Getters and Setters
- (void) setBulletType:(BulletTypes)b velocity:(CGFloat)v damage:(int)d isAirBullet:(bool)a {
    _bulletType = b;
    _velocity = v;
    _damage = d;
    _isAirBullet = a;
}
- (bool) playerBullet {
    return _playerBullet;
}
- (CGFloat) velocity {
    return _velocity;
}

@end
