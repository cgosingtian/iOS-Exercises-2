//
//  KLBTurret.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KLBBullet;

@interface KLBTurret : NSObject

@property (nonatomic) CGFloat angle;
@property (nonatomic) CGFloat firingSpeed;
@property (nonatomic,assign) KLBBullet *bullet;

@end
