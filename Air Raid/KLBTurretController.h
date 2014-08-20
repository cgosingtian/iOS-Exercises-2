//
//  KLBTurretController.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBTurret.h"
#import "KLBShip.h"

@interface KLBTurretController : NSObject

@property (nonatomic) bool canFire;
@property (nonatomic,retain) KLBTurret *turret;
@property (nonatomic) CGPoint coordinates;

- (instancetype) initWithTurret:(KLBTurret *)t owner:(KLBShip *)o;
- (void) activateTurret;

@end
