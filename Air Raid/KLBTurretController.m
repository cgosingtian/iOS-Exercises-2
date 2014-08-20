//
//  KLBTurretController.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBTurretController.h"
#import "KLBBulletController.h"
#import "KLBShip.h"
#import "KLBTurret.h"

@interface KLBTurretController ()

@property (nonatomic) NSTimer *timer;

@end

@implementation KLBTurretController

- (void) dealloc {
    [_timer invalidate];
    [_timer release];
    [_turret release];
    _turret = nil;
    _timer = nil;
    [super dealloc];
}

- (instancetype) initWithTurret:(KLBTurret *)t owner:(KLBShip *)o {
    self = [super init];
    if (self) {
        _canFire = true;
        _coordinates = [o coordinates];
        if (!t) {
            t = [[KLBTurret alloc] initWithTurretType:ttDefault owner:o];
        }
        _turret = t;
    }
    return self;
}

- (void) activateTurret {
    if (!_timer) {
        CGFloat speed = [_turret firingSpeed];
        _timer = [NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(fireBullets:) userInfo:nil repeats:YES];
    }
}

- (void) fireBullets: (id)sender {
    if (_canFire) {
        _coordinates = [[_turret owner] coordinates];
        KLBBulletController *bulletController = [[KLBBulletController alloc] initWithBulletView:nil bullet:[_turret bullet] launchAngle:[_turret angle] coordinates:_coordinates];
        [bulletController launchBullet];
//        [bulletController release];
    }
}

@end
