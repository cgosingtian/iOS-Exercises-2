//
//  KLBBackground.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBackground.h"

@interface KLBBackground ()

@property (nonatomic) int maxHeight;
@property (nonatomic) CGFloat distanceTravelled;

@end

@implementation KLBBackground

@synthesize maxHeight = _maxHeight,
            distanceTravelled = _distanceTravelled,
            moveSpeed = _moveSpeed,
            animationInterval = _animationInterval;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _distanceTravelled = 0;
        _moveSpeed = 0.5;
        _animationInterval = 0.01;
        [self resetPosition];
    }
    return self;
}

- (void)awakeFromNib {
    _maxHeight = self.image.size.height;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_animationInterval target:self selector:@selector(animateBackground) userInfo:nil repeats:YES];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) animateBackground {
    _distanceTravelled += _moveSpeed;
    float yMovement = (-1*(self.image.size.height/2)) + _distanceTravelled;
    [self setFrame:CGRectMake(0.0, yMovement, self.image.size.width, self.image.size.height)];
    
    if (_distanceTravelled >= _maxHeight/2) {
        [self resetPosition];
        _distanceTravelled = 0.0;
    }
}

- (void) resetPosition {
    [self setFrame:CGRectMake(0.0, -(self.image.size.height/2), self.image.size.width, self.image.size.height)];
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
