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
        self.frame = CGRectMake(x, y, self.image.size.width, self.image.size.height);
        
        self.layer.zPosition = 100;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) animateNormalDirection {
    UIView *myView = self;
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 0.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}

- (void) animateRightTurn {
    UIView *myView = self;
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 45.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}

- (void) animateLeftTurn {
    UIView *myView = self;
    CALayer *layer = myView.layer;
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 125.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}

@end
