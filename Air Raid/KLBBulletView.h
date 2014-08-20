//
//  KLBBulletView.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLBBullet.h"

@interface KLBBulletView : UIImageView

- (void)updateCoordinatesX:(CGFloat)x Y:(CGFloat)y;
- (void)changeBulletImage:(BulletTypes)b;

@end
