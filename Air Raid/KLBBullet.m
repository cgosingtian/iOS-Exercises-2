//
//  KLBBullet.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBullet.h"

@implementation KLBBullet

#pragma mark - Initializers
//Designated Initializer
- (instancetype) initWithBulletType:(BulletTypes)bulletType playerBullet:(BOOL)isPlayerBullet {
    self = [super init];
    _isPlayerBullet = isPlayerBullet;
    switch (bulletType) {
        case btMachineGun:
            [self setBulletType:bulletType
                       velocity:5.0
                         damage:1
                    isAirBullet:true];
            break;
        case btCannon:
            [self setBulletType:bulletType
                       velocity:0.5
                         damage:4
                    isAirBullet:true];
            break;
        case btDefaultBulletType:
            [self setBulletType:btDefaultBulletType
                       velocity:2.0
                         damage:2
                    isAirBullet:true];
            break;
        default:
            [self setBulletType:btDefaultBulletType
                       velocity:10.0
                         damage:2
                    isAirBullet:true];
    }
    return self;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self = [self initWithBulletType:btDefaultBulletType playerBullet:false];
    }
    return self;
}

#pragma mark - Getters and Setters
- (void) setBulletType:(BulletTypes)bulletType
              velocity:(CGFloat)velocity
                damage:(int)damage
           isAirBullet:(BOOL)isAirBullet {
    _bulletType = bulletType;
    _velocity = velocity;
    _damage = damage;
    _isAirBullet = isAirBullet;
}
- (BOOL) isPlayerBullet {
    return _isPlayerBullet;
}
- (CGFloat) velocity {
    return _velocity;
}

@end
