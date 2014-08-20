//
//  KLBClouds.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBClouds.h"
#import <QuartzCore/QuartzCore.h>

@implementation KLBClouds

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [self addFallAnimationForLayer:self.layer];
}

- (void)addFallAnimationForLayer:(CALayer *)layer{
    [CATransaction begin];
    // The keyPath to animate
    NSString *keyPath = @"transform.translation.y";
    
    // Allocate a CAKeyFrameAnimation for the specified keyPath.
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    // Set animation duration and repeat
    translation.duration = 5.0f;
    //translation.repeatCount = HUGE_VAL;
    
    // Allocate array to hold the values to interpolate
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    // Add the start value
    // The animation starts at a y offset of 0.0
    [values addObject:[NSNumber numberWithFloat:0.0f]];
    
    // Add the end value
    // The animation finishes when the ball would contact the bottom of the screen
    // This point is calculated by finding the height of the applicationFrame
    // and subtracting the height of the ball.
    CGFloat height = [[UIScreen mainScreen] applicationFrame].size.height + layer.frame.size.height;
    [values addObject:[NSNumber numberWithFloat:height]];
    
    // Set the values that should be interpolated during the animation
    translation.values = values;
    
    CAKeyframeAnimation *transparency = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    transparency.duration = translation.duration;
    //transparency.repeatCount = HUGE_VAL;
    transparency.values = @[@0.0,@0.5,@0.0];
    
    //translation.autoreverses = NO;
    //transparency.autoreverses = YES;
    
    [CATransaction setCompletionBlock:^()
     {
         [self addFallAnimationForLayer:self.layer];
         
         CGPoint randomPoint;
         randomPoint.x = arc4random() % (int)[[UIScreen mainScreen] applicationFrame].size.width;
         randomPoint.y = arc4random() % (int)[[UIScreen mainScreen] applicationFrame].size.height-50;
         CGSize randomSize;
         //randomSize.width = arc4random() % (int)self.image.size.width;
         randomSize.height = arc4random() % (int)self.image.size.height*2;
         randomSize.width = randomSize.height * 2.5;
         
         self.frame = CGRectMake(randomPoint.x, randomPoint.y, randomSize.width, randomSize.height);
     }];
    [layer addAnimation:translation forKey:keyPath];
    [layer addAnimation:transparency forKey:@"opacity"];
    [CATransaction commit];
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
