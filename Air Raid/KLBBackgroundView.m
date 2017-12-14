//
//  KLBBackground.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBackgroundView.h"
#import "KLBConstants.h"

CGFloat const KLB_BACKGROUND_DISTANCE_TRAVELLED_START = 0.0;
CGFloat const KLB_BACKGROUND_MOVE_SPEED = 0.5;

@interface KLBBackgroundView ()

@property (nonatomic) NSUInteger maxHeight;
@property (nonatomic) CGFloat distanceTravelled;

@end

@implementation KLBBackgroundView

#pragma mark - Initializers
// Designated Initializer
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _distanceTravelled = KLB_BACKGROUND_DISTANCE_TRAVELLED_START; // 0.0
        _moveSpeed = KLB_BACKGROUND_MOVE_SPEED; // 0.5
        //[self resetPosition];
        [self setAutoresizingMask:UIViewAutoresizingNone];
    }
    return self;
}

#pragma mark - View States
- (void)awakeFromNib {
    CGFloat imageHeight = self.image.size.height;
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height * screenScale;
    
    CGFloat screenImageHeightDiscrepancy = [self computeScreenImageHeightDiscrepancy];
    
    if (screenHeight > imageHeight) {
        imageHeight += screenImageHeightDiscrepancy;
    } else {
        imageHeight -= screenImageHeightDiscrepancy;
    }
    
    _maxHeight = imageHeight;
    
    [self resetPosition];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:KLB_ANIMATION_INTERVAL
                                                      target:self
                                                    selector:@selector(animateBackground)
                                                    userInfo:nil
                                                     repeats:YES];
}

#pragma mark - Animation
- (void) animateBackground {
    CGFloat frameWidth = self.frame.size.width;
    CGFloat frameHeight = self.frame.size.height;
    CGFloat currentYPosition = self.frame.origin.y;
    CGPoint startLocation = CGPointMake(KLB_ZERO_F, currentYPosition);
    CGFloat yMovement = startLocation.y + _moveSpeed;
    
    _distanceTravelled += _moveSpeed;
    
    CGRect nextMoveFrame = CGRectMake(startLocation.x, yMovement, frameWidth, frameHeight);
    
    [self setFrame:nextMoveFrame];
    
    if (_distanceTravelled >= (_maxHeight/2)) {
        [self resetPosition];
        _distanceTravelled = KLB_BACKGROUND_DISTANCE_TRAVELLED_START; // 0.0
    }
}

- (void) resetPosition {
    CGFloat imageWidth = self.image.size.width;
    
    CGPoint startLocation = CGPointMake(KLB_ZERO_F, -(_maxHeight/2.0));
    
    CGRect imageRect = CGRectMake(startLocation.x, startLocation.y, imageWidth, _maxHeight);
    [self setFrame:imageRect];
}

- (CGFloat) computeScreenImageHeightDiscrepancy {
    CGFloat imageHeight = self.image.size.height;
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height * screenScale;
    
    return ABS(screenHeight- imageHeight);
}

@end
