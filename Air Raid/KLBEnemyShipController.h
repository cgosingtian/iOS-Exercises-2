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

@interface KLBEnemyShipController : NSObject

@property (retain, nonatomic) KLBShip *ship;
@property (retain, nonatomic) KLBShipView *shipView;
@property (nonatomic) CGPoint destinationCoordinates;

- (instancetype) initWithShipView:(KLBShipView *)shipView coordinates:(CGPoint)c;

@property (nonatomic) bool isMoving;
- (void)setIsMoving:(bool)isMoving;

- (void)activateAI;

@end
