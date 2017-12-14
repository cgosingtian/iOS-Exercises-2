//
//  KLBBulletView.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLBBullet.h"

// Image filenames
extern NSString *const KLB_BULLET_DEFAULT_FILENAME;
extern NSString *const KLB_BULLET_DEFAULT_FILENAME2;
extern NSString *const KLB_BULLET_MACHINEGUN_FILENAME;
extern NSString *const KLB_BULLET_MACHINEGUN_FILENAME2;
extern NSString *const KLB_BULLET_CANNON_FILENAME;
extern NSString *const KLB_BULLET_CANNON_FILENAME2;

// Animation values
extern CGFloat const KLB_FADE_IN_DURATION;
extern CGFloat const KLB_FADE_IN_MAX_ALPHA;
extern CGFloat const KLB_BULLET_SWITCH_ANIMATION_DURATION;

@interface KLBBulletView : UIImageView

@property (unsafe_unretained,nonatomic) KLBBullet* bullet;

- (instancetype)initWithBullet:(KLBBullet *)bullet;

- (void)updateCoordinatesX:(CGFloat)x Y:(CGFloat)y;
- (void)changeBulletImage:(BulletTypes)bulletType;

- (void)animateFadeIn;
- (void)animateBulletEffects;

@end
