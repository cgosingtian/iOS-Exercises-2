//
//  KLBBulletController.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBBulletView.h"

@interface KLBBulletController : NSObject

@property (nonatomic) float maximumDistance; //destroy bullet after reaching this
@property (nonatomic, retain) KLBBulletView *bulletView;
@property (nonatomic,retain) KLBBullet *bullet;

- (instancetype) initWithBulletView:(KLBBulletView *)bv bullet:(KLBBullet *)b launchAngle:(CGFloat)a coordinates:(CGPoint)c;
- (void)launchBullet;

@end
