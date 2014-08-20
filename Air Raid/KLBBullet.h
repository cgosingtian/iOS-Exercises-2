//
//  KLBBullet.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum BulletTypes : NSUInteger
{
                //Damage Velocity isAirBullet
    btDefault,    //  2    10.0        y
    btMachineGun, //  1    20.0        y
    btCannon,     //  4     5.0        y
} BulletTypes;

@interface KLBBullet : NSObject

@property (nonatomic) CGFloat velocity;
@property (nonatomic) int damage;
@property (nonatomic) bool isAirBullet;
@property (nonatomic) BulletTypes bulletType;
@property (nonatomic) bool playerBullet;

- (instancetype) initWithBulletType:(BulletTypes)b playerBullet:(bool)p;
- (bool) playerBullet;
- (CGFloat) velocity;
@end
