//
//  KLBTurret.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KLBBullet;

typedef enum TurretTypes : NSUInteger
{
                  //Firing Speed
    ttDefault,    //    1.0
    ttMachineGun, //    2.0
    ttCannon,     //    0.5
} TurretTypes;

@interface KLBTurret : NSObject

@property (nonatomic) CGFloat angle;
@property (nonatomic) CGFloat firingSpeed;
@property (nonatomic,assign) KLBBullet *bullet;
@property (nonatomic) TurretTypes turretType;

- (instancetype) initWithTurretType:(TurretTypes)t;
- (void) setAngle:(CGFloat)angle;

@end
