//
//  KLBPlayer.h
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLBPlayer : NSObject

@property (assign, nonatomic) int score;
@property (retain, nonatomic) NSString *name;

- (void) setName:(NSString *)name;

@end
