//
//  KLBPlayerShipView.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBPlayerShipView.h"
#import "KLBShip.h"
#import "KLBConstants.h"

NSString *const KLB_PLAYER_SHIP_FILENAME = @"player.png";
CGFloat const KLB_PLAYER_LAYER_Z = 100;

@implementation KLBPlayerShipView

#pragma mark - Initializers
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        float x = KLB_ZERO_F;
        float y = KLB_ZERO_F;
        UIImage *shipImage = [UIImage imageNamed:KLB_PLAYER_SHIP_FILENAME];
        self.image = shipImage;
        self.frame = CGRectMake(x, y, self.image.size.width, self.image.size.height);
        
        self.layer.zPosition = KLB_PLAYER_LAYER_Z;
    }
    return self;
}

#pragma mark - Animation
- (void)animateNormalDirection {
    UIView *myView = self;
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 0.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}

- (void)animateRightTurn {
    UIView *myView = self;
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 45.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}

- (void)animateLeftTurn {
    UIView *myView = self;
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 125.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
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
