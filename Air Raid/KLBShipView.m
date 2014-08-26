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

#pragma mark - Initializers
- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        float x = 0.0;
        float y = 0.0;
        UIImage *shipImage = [UIImage imageNamed:@"neutral.png"];
        self.image = shipImage;
        self.frame = CGRectMake(x, y, self.image.size.width, self.image.size.height);
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithCoordinates:(CGPoint)coordinates {
    self = [super init];
    if (self) {
        float x = coordinates.x;
        float y = coordinates.y;
        UIImage *shipImage = [UIImage imageNamed:@"neutral.png"];
        self.image = shipImage;
        self.frame = CGRectMake(x, y, self.image.size.width, self.image.size.height);
        // add self to active view
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *topView = window.rootViewController.view;
        [topView addSubview:self];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - View Movement
- (void)updateCoordinatesX:(CGFloat) x Y:(CGFloat) y {
    [self setFrame:CGRectMake(x, y, self.image.size.width, self.image.size.height)];
}

#pragma mark - Animation
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
