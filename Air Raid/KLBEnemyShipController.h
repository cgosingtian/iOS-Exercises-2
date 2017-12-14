//
//  KLBEnemyShipController.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/26/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBShip.h"
#import "KLBShipView.h"

extern NSString *const KLB_ENEMY_SHIP_FILENAME;

@interface KLBEnemyShipController : NSObject

@property (retain, nonatomic) KLBShip *ship;
@property (retain, nonatomic) KLBShipView *shipView;
@property (nonatomic) CGPoint destinationCoordinates;

- (instancetype) initWithShipView:(KLBShipView *)shipView coordinates:(CGPoint)c;

@property (nonatomic) BOOL isMoving;
- (void)setIsMoving:(BOOL)isMoving;

- (void)activateAI;

@end
