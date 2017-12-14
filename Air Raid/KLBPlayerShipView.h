//
//  KLBPlayerShipView.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLBShipView.h"
#import "KLBShipControlProtocol.h"

extern NSString *const KLB_PLAYER_SHIP_FILENAME;
extern CGFloat const KLB_PLAYER_LAYER_Z;

@interface KLBPlayerShipView : KLBShipView

- (void)animateRightTurn;
- (void)animateLeftTurn;
- (void)animateNormalDirection;

@end
