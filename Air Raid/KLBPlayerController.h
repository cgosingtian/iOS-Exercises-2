//
//  KLBPlayerController.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBShipControlProtocol.h"
#import "KLBPlayer.h"
#import "KLBShip.h"
#import "KLBPlayerShipView.h"

@interface KLBPlayerController : NSObject <KLBShipControlProtocol>

@property (retain, nonatomic) KLBPlayer *player;
@property (unsafe_unretained, nonatomic) KLBPlayerShipView *playerView;
@property (retain, nonatomic) KLBShip *playerShip;

- (instancetype) initWithShipView:(KLBPlayerShipView *)shipView coordinates:(CGPoint)c;

@property (nonatomic) bool isMoving;
- (void)setIsMoving:(bool)isMoving;

@end
