//
//  KLBEnemyShipController.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/26/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBEnemyShipController.h"
#import "KLBTurretController.h"

@interface KLBEnemyShipController ()
@property (nonatomic,retain) NSTimer *aiTimer;
@property (nonatomic,retain) NSTimer *waitTimer;
@property (nonatomic) float waitSeconds; // ship will wait this long before moving again
@end

@implementation KLBEnemyShipController

#pragma mark - Initializers
// Designated Initializer
- (instancetype) initWithShipView:(KLBShipView *)shipView coordinates:(CGPoint)c {
    self = [super init];
    if (self) {
        if (!shipView) {
            shipView = [[KLBShipView alloc] initWithCoordinates:c];
            shipView.image = [UIImage imageNamed:@"enemy.png"];
        }
        _shipView = shipView;
        _destinationCoordinates = c;
        
        //Flip the ship's view vertically
        [_shipView.layer setAffineTransform:CGAffineTransformMakeScale(1,-1)];
        
        if (!_ship) {
            _ship = [[KLBShip alloc] init];
            _ship.coordinates = c;
            [self refreshShipView];
        }
        
        _waitSeconds = 1.0;
        _isMoving = false;
    }
    return self;
}

- (void)activateAI {
    if (!_aiTimer) {
        _aiTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(randomMove) userInfo:nil repeats:YES];
        
        //weapons
        NSMutableDictionary *turretDict = _ship.turrets;
        for (NSString *key in turretDict) {
            KLBTurretController *tc = [[[KLBTurretController alloc] initWithTurret:[turretDict objectForKey:key] owner:_ship] autorelease];
            [tc activateTurret];
        }
    }
}

#pragma mark - Ship View Updates
- (void) refreshShipView {
    CGFloat x = _ship.coordinates.x;
    CGFloat y = _ship.coordinates.y;
    [_shipView updateCoordinatesX:x Y:y];
}

#pragma mark - Movement
- (void) doneWaiting {
    //generate random coordinates
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    float maxX = window.frame.size.width - _shipView.frame.size.width;
    float maxY = window.frame.size.height - _shipView.frame.size.height;
    
    float randomX = arc4random_uniform(maxX);
    float randomY = arc4random_uniform(maxY);
    
    _destinationCoordinates = CGPointMake(randomX, randomY);
    
    [_waitTimer invalidate];
    _waitTimer = nil;
}

- (void) randomMove {
    if (_ship.healthRemaining > 0) {
        _isMoving = true;
        //if destinationCoordinates == _ship.coordinates
        if (CGPointEqualToPoint(_destinationCoordinates, _ship.coordinates)) {
            // wait for waitSeconds time
            if (!_waitTimer) {
                _waitTimer = [NSTimer scheduledTimerWithTimeInterval:_waitSeconds target:self selector:@selector(doneWaiting) userInfo:nil repeats:NO];
            }
            // then generate random coordinates (in the doneWaiting method)
        }
        else {
            //move ship towards destinationCoordinates
            if (_ship.coordinates.x > _destinationCoordinates.x) {
                CGFloat velocity = _ship.velocity;
                CGFloat x = _ship.coordinates.x - velocity;
                CGFloat y = _ship.coordinates.y;
                
                if (x < _destinationCoordinates.x) //don't overshoot coordinates
                    x = _destinationCoordinates.x;
                
                _ship.coordinates = CGPointMake(x, y);
            } else if (_ship.coordinates.x < _destinationCoordinates.x) {
                CGFloat velocity = _ship.velocity;
                CGFloat x = _ship.coordinates.x + velocity;
                CGFloat y = _ship.coordinates.y;
                
                if (x > _destinationCoordinates.x) //don't overshoot coordinates
                    x = _destinationCoordinates.x;
                
                _ship.coordinates = CGPointMake(x, y);
            }
            
            if (_ship.coordinates.y > _destinationCoordinates.y) {
                CGFloat velocity = _ship.velocity;
                CGFloat x = _ship.coordinates.x;
                CGFloat y = _ship.coordinates.y - velocity;
                
                if (y < _destinationCoordinates.y) //don't overshoot coordinates
                    y = _destinationCoordinates.y;
                
                _ship.coordinates = CGPointMake(x, y);
            } else if (_ship.coordinates.y < _destinationCoordinates.y) {
                CGFloat velocity = _ship.velocity;
                CGFloat x = _ship.coordinates.x;
                CGFloat y = _ship.coordinates.y + velocity;
                
                if (y > _destinationCoordinates.y) //don't overshoot coordinates
                    y = _destinationCoordinates.y;
                
                _ship.coordinates = CGPointMake(x, y);
            }
            
            [_shipView updateCoordinatesX:_ship.coordinates.x Y:_ship.coordinates.y];
        }
    } else {
        _isMoving = false;
        [_aiTimer invalidate];
        _aiTimer = nil;
        
        //perform death stuff here
    }
}

@end
