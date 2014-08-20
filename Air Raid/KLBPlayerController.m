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
#import "KLBTurret.h"

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
        
        _isMoving = false;
    }
    return self;
}

- (void) refreshShipView {
    CGFloat x = _playerShip.coordinates.x;
    CGFloat y = _playerShip.coordinates.y;
    [_playerView updateCoordinatesX:x Y:y];
    
    [self shipDidMove];
}

- (void) stepShipLeft {
    CGFloat velocity = _playerShip.velocity;
    CGFloat x = _playerShip.coordinates.x - velocity;
    CGFloat y = _playerShip.coordinates.y;

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    CGFloat maxWidth = window.frame.size.width - _playerView.frame.size.width;
    CGFloat minWidth = 0;
    
    if (x < maxWidth && x > minWidth) {
        _playerShip.coordinates = CGPointMake(x, y);
    }
}
- (void) stepShipRight {
    CGFloat velocity = _playerShip.velocity;
    CGFloat x = _playerShip.coordinates.x + velocity;
    CGFloat y = _playerShip.coordinates.y;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    CGFloat maxWidth = window.frame.size.width - _playerView.frame.size.width;
    CGFloat minWidth = 0;
    
    if (x < maxWidth && x > minWidth) {
        _playerShip.coordinates = CGPointMake(x, y);
    }
}

#pragma mark - Getters and Setters
- (void)setIsMoving:(bool)b {
    if (b) {
        _isMoving = true;
    }
    else {
        _isMoving = false;
        [_playerView animateNormalDirection];
    }
}

#pragma mark - Ship Control Protocol
-(void)shipDidMove {

}
-(void)shipWillMoveLeft {
    [self stepShipLeft];
    if (_isMoving) {
        [_playerView animateLeftTurn];
    }
    [self shipDidMoveLeft];
}

-(void)shipDidMoveLeft {
    [self shipDidMove];
    [self refreshShipView]; // do this last
}

-(void)shipWillMoveRight {
    [self stepShipRight];
    if (_isMoving) {
        [_playerView animateRightTurn];
    }
    [self shipDidMoveRight];
}

-(void)shipDidMoveRight {
    [self shipDidMove];
    [self refreshShipView]; // do this last
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
