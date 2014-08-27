//
//  KLBShip.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KLBTurret;

//Standard ship defaults
extern NSUInteger const KLB_SHIP_HEALTH_MAXIMUM;
extern NSUInteger const KLB_SHIP_AIR_BOMBS;
extern CGFloat const KLB_SHIP_VELOCITY;

//Enemy ship defaults
extern CGFloat const KLB_SHIP_ENEMY_TURRET_ANGLE;
extern CGFloat const KLB_SHIP_ENEMY_FIRING_SPEED_SECONDS;

//Player ship defaults
extern NSUInteger const KLB_SHIP_PLAYER_AIR_BOMBS;
extern CGFloat const KLB_SHIP_PLAYER_VELOCITY;
extern CGFloat const KLB_SHIP_PLAYER_TURRET_ANGLE;

@interface KLBShip : NSObject

@property (nonatomic) NSUInteger healthMaximum;
@property (nonatomic) NSUInteger healthRemaining;
@property (nonatomic) NSUInteger airBombs;
@property (nonatomic) CGFloat velocity;
@property (nonatomic) CGPoint coordinates;
@property (nonatomic) NSUInteger pointsAwarded;
@property (nonatomic) BOOL isPlayer;

@property (nonatomic,retain) NSMutableDictionary *turrets; //key:angle - value:KLBTurret

- (instancetype) initPlayerShip;

- (void) setHealthMaximum:(NSUInteger)healthMaximum;
- (void) setHealthRemaining:(NSUInteger)healthRemaining;
- (void) setAirBombs:(NSUInteger)airBombs;
- (void) setVelocity:(CGFloat)velocity;
- (void) setCoordinates:(CGPoint)coordinates;
- (CGPoint)coordinates;

- (void) addTurret:(KLBTurret *)t;
- (BOOL) isPlayer;

@end
