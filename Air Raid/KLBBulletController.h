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

@property (nonatomic) CGFloat maximumDistance; //destroy bullet after reaching this
@property (retain, nonatomic) KLBBulletView *bulletView;
@property (retain, nonatomic) KLBBullet *bullet;

- (instancetype) initWithBulletView:(KLBBulletView *)bulletView
                             bullet:(KLBBullet *)bullet
                        launchAngle:(CGFloat)angle
                        coordinates:(CGPoint)coordinates;
- (void)launchBullet;

@end
