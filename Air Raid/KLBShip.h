//
//  KLBShip.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KLBTurret;

@interface KLBShip : NSObject

@property (nonatomic) int healthMaximum;
@property (nonatomic) int healthRemaining;
@property (nonatomic) int airBombs;
@property (nonatomic) CGFloat velocity;
@property (nonatomic) CGPoint coordinates;

@property (nonatomic,retain) NSMutableDictionary *turrets; //key:angle - value:KLBTurret

- (void) setHealthMaximum:(int)healthMaximum;
- (void) setHealthRemaining:(int)healthRemaining;
- (void) setAirBombs:(int)airBombs;
- (void) setVelocity:(CGFloat)velocity;
- (void) setCoordinates:(CGPoint)coordinates;

- (void) addTurret:(KLBTurret *)t;

@end
