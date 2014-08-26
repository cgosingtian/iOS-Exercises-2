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
@class KLBShip;

@interface KLBPlayerShipView : KLBShipView

- (void)animateRightTurn;
- (void)animateLeftTurn;
- (void)animateNormalDirection;

@end
