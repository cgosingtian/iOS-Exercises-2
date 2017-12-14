//
//  KLBShipControlProtocol.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KLBShipControlProtocol <NSObject>
-(void)shipDidMove;
-(void)shipWillMoveLeft;
-(void)shipDidMoveLeft;
-(void)shipWillMoveRight;
-(void)shipDidMoveRight;
@optional
-(void)shipWillFire;
-(void)shipDidFire;
-(void)shipWillLaunchBomb;
-(void)shipDidLaunchBomb;
@end
