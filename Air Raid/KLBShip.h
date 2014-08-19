//
//  KLBShip.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLBShip : NSObject

@property (nonatomic) int healthMaximum;
@property (nonatomic) int healthRemaining;
@property (nonatomic) int airBombs;
@property (nonatomic) CGFloat velocity;
@property (nonatomic) CGFloat xCoordinate;
@property (nonatomic) CGFloat yCoordinate;

@property (nonatomic,retain) NSMutableArray *turrets;

@end
