//
//  KLBPlayer.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBPlayer.h"

NSUInteger const KLB_STARTING_SCORE = 0;
NSString *const KLB_DEFAULT_NAME = @"Player";

@implementation KLBPlayer

#pragma mark - Initializers
- (instancetype) init {
    self = [super init];
    if (self) {
        _score = KLB_STARTING_SCORE;
        _name = KLB_DEFAULT_NAME;
    }
    return self;
}

#pragma mark - Getters and Setters
- (void) setName:(NSString *)name {
    _name = name;
}

@end
