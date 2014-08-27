//
//  KLBPlayer.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSUInteger const KLB_STARTING_SCORE;
extern NSString *const KLB_DEFAULT_NAME;

@interface KLBPlayer : NSObject

@property (assign, nonatomic) NSUInteger score;
@property (retain, nonatomic) NSString *name;

- (void) setName:(NSString *)name;

@end
