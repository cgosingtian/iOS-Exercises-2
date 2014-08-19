//
//  KLBPlayerController.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBPlayerController.h"
#import "KLBPlayer.h"
#import "KLBPlayerShipView.h"

@implementation KLBPlayerController

@synthesize player = _player,
            playerView = _playerView,
            playerShip = _playerShip;

- (instancetype) initWithShipView:(KLBPlayerShipView *)shipView coordinates:(CGPoint)c {
    self = [super init];
    if (self) {
        if (!_player) {
            _player = [[KLBPlayer alloc] init];
        }
        _playerView = shipView;
        if (!_playerShip) {
            _playerShip = [[KLBShip alloc] init];
            _playerShip.coordinates = c;
            [self refreshShipView];
        }
    }
    return self;
}

- (void) refreshShipView {
    NSLog(@"Refreshing ship view...");
    CGFloat x = _playerShip.coordinates.x;
    CGFloat y = _playerShip.coordinates.y;
    [_playerView updateCoordinatesX:x Y:y];
}

- (void) stepShipLeft {
    CGFloat velocity = _playerShip.velocity;
    CGFloat x = _playerShip.coordinates.x - velocity;
    CGFloat y = _playerShip.coordinates.y;
    _playerShip.coordinates = CGPointMake(x, y);
    NSLog(@"player coordinates [left]: %f,%f",x,y);
}
- (void) stepShipRight {
    CGFloat velocity = _playerShip.velocity;
    CGFloat x = _playerShip.coordinates.x + velocity;
    CGFloat y = _playerShip.coordinates.y;
    _playerShip.coordinates = CGPointMake(x, y);
    NSLog(@"player coordinates [right]: %f,%f",x,y);
}

#pragma mark - Ship Control Protocol
-(void)shipWillMoveLeft {
    NSLog(@"SHIP WILL MOVE LEFT");
    [self stepShipLeft];
    
    [self shipDidMoveLeft];
}

-(void)shipDidMoveLeft {
    NSLog(@"SHIP DID MOVE LEFT");
    [self refreshShipView];
}

-(void)shipWillMoveRight {
    NSLog(@"SHIP WILL MOVE RIGHT");
    [self stepShipRight];
    
    [self shipDidMoveRight];
}

-(void)shipDidMoveRight {
    NSLog(@"SHIP DID MOVE RIGHT");
    
    [self refreshShipView];
}

-(void)shipWillFire {
    NSLog(@"SHIP WILL FIRE");
    
    [self shipDidFire];
}

-(void)shipDidFire {
    NSLog(@"SHIP DID FIRE");
}

-(void)shipWillLaunchBomb {
    NSLog(@"SHIP WILL LAUNCH BOMB");
    
    [self shipDidLaunchBomb];
}

-(void)shipDidLaunchBomb {
    NSLog(@"SHIP DID LAUNCH BOMB");
}
@end
