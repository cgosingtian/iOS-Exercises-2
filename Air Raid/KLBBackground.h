//
//  KLBBackground.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLBBackground : UIImageView

@property (nonatomic) CGFloat moveSpeed;
@property (nonatomic) float animationInterval;

- (void) animateBackground;

@end
