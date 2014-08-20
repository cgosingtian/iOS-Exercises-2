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

@property (nonatomic,retain) KLBPlayer *player;
@property (nonatomic,unsafe_unretained) KLBPlayerShipView *playerView;
@property (nonatomic,retain) KLBShip *playerShip;

@property (nonatomic) bool isMoving;

- (instancetype) initWithShipView:(KLBPlayerShipView *)shipView coordinates:(CGPoint)c;

- (void)setIsMoving:(bool)isMoving;

@end
