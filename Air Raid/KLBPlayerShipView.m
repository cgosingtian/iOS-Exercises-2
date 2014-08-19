//
//  KLBPlayerShipView.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBPlayerShipView.h"
#import "KLBShip.h"

@implementation KLBPlayerShipView

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        float x = 0.0;
        float y = 0.0;
        UIImage *shipImage = [UIImage imageNamed:@"player.png"];
        self.image = shipImage;
        self.frame = CGRectMake(x, y, shipImage.size.width, shipImage.size.height);
//        self.ship = [[KLBShip alloc] init];
//        [self.ship setCoordinates:CGPointMake(x, y)];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [NSException raise:@"Wrong initializer" format:@"Use initWithCoder"];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [NSException raise:@"Wrong initializer" format:@"Use initWithCoder"];
    }
    return self;
}

- (void)viewDidAppear {
    NSLog(@"PLAYER SHIP VIEW LOADED");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
