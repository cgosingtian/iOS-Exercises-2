//
//  KLBBullet.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBullet.h"

float const KLB_BULLET_MACHINEGUN_VELOCITY = 5.0;
float const KLB_BULLET_MACHINEGUN_DAMAGE = 1;
float const KLB_BULLET_CANNON_VELOCITY = 0.5;
float const KLB_BULLET_CANNON_DAMAGE = 4;
float const KLB_BULLET_DEFAULT_VELOCITY = 2.0;
float const KLB_BULLET_DEFAULT_DAMAGE = 2;

@implementation KLBBullet

#pragma mark - Initializers
//Designated Initializer
- (instancetype) initWithBulletType:(BulletTypes)bulletType playerBullet:(BOOL)isPlayerBullet {
    self = [super init];
    _isPlayerBullet = isPlayerBullet;
    switch (bulletType) {
        case btMachineGun:
            [self setBulletType:bulletType
                       velocity:KLB_BULLET_MACHINEGUN_VELOCITY
                         damage:KLB_BULLET_MACHINEGUN_DAMAGE
                    isAirBullet:true];
            break;
        case btCannon:
            [self setBulletType:bulletType
                       velocity:KLB_BULLET_CANNON_VELOCITY
                         damage:KLB_BULLET_CANNON_DAMAGE
                    isAirBullet:true];
            break;
        case btDefaultBulletType:
            [self setBulletType:btDefaultBulletType
                       velocity:KLB_BULLET_DEFAULT_VELOCITY
                         damage:KLB_BULLET_DEFAULT_DAMAGE
                    isAirBullet:true];
            break;
        default:
            [self setBulletType:btDefaultBulletType
                       velocity:KLB_BULLET_DEFAULT_VELOCITY
                         damage:KLB_BULLET_DEFAULT_DAMAGE
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
