//
//  KLBShipView.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBShipView.h"
#import "KLBShip.h"

@implementation KLBShipView

//@synthesize ship = _ship;

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        float x = 0.0;
        float y = 0.0;
        UIImage *shipImage = [UIImage imageNamed:@"neutral.png"];
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

- (void)updateCoordinatesX:(CGFloat) x Y:(CGFloat) y {
    NSLog(@"Updating ship view coordinates...");
    [self setFrame:CGRectMake(x, y, self.image.size.width, self.image.size.height)];
    [self setNeedsDisplay];
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
