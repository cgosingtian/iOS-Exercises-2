//
//  KLBBackground.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const KLB_BACKGROUND_DISTANCE_TRAVELLED_START;
extern CGFloat const KLB_BACKGROUND_MOVE_SPEED;

@interface KLBBackgroundView : UIImageView

@property (nonatomic) CGFloat moveSpeed;

- (void) animateBackground;

@end
