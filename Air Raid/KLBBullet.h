//
//  KLBBullet.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern float const KLB_BULLET_MACHINEGUN_VELOCITY;
extern float const KLB_BULLET_MACHINEGUN_DAMAGE;
extern float const KLB_BULLET_CANNON_VELOCITY;
extern float const KLB_BULLET_CANNON_DAMAGE;
extern float const KLB_BULLET_DEFAULT_VELOCITY;
extern float const KLB_BULLET_DEFAULT_DAMAGE;

typedef enum BulletTypes : NSUInteger
{
    btDefaultBulletType,
    btMachineGun,
    btCannon,
} BulletTypes;

@interface KLBBullet : NSObject

@property (nonatomic) CGFloat velocity;
@property (nonatomic) int damage;
@property (nonatomic) BOOL isAirBullet;
@property (nonatomic) BulletTypes bulletType;
@property (nonatomic) BOOL isPlayerBullet;

- (instancetype) initWithBulletType:(BulletTypes)bulletType playerBullet:(BOOL)isPlayerBullet;
- (BOOL) isPlayerBullet;
- (CGFloat) velocity;
@end
