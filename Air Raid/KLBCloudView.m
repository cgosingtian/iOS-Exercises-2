//
//  KLBClouds.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBCloudView.h"
#import <QuartzCore/QuartzCore.h>

float const KLB_CLOUD_ANIMATION_DURATION = 5.0;
float const KLB_CLOUD_MAX_OPACITY = 0.5;
float const KLB_CLOUD_MAX_HEIGHT_MULTIPLIER = 2.0; //versus image height
float const KLB_CLOUD_WIDTH_MULTIPLIER = 2.5; //versus cloud height
float const KLB_CLOUD_MAX_Y_ADJUSTMENT = 50;

@implementation KLBCloudView

#pragma mark - Initializers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - View States
- (void)awakeFromNib {
    [self addFallAnimationForLayer:self.layer];
}

#pragma mark - Animation
- (void)addFallAnimationForLayer:(CALayer *)layer{
    [CATransaction begin];

    NSString *keyPathTranslationY = @"transform.translation.y";
    NSString *keyPathTransparency = @"opacity";
    
    // --- TRANSLATION KEYFRAME SETUP START ---
    CAKeyframeAnimation *translation = [[CAKeyframeAnimation alloc] init];
    [translation setKeyPath:keyPathTranslationY];
    translation.duration = KLB_CLOUD_ANIMATION_DURATION;
    
    // Allocate array to hold the values to interpolate
    NSMutableArray *values = [[NSMutableArray alloc] init];
    [values addObject:[NSNumber numberWithFloat:KLB_ZERO_F]];
    CGFloat height = [[UIScreen mainScreen] applicationFrame].size.height + layer.frame.size.height;
    [values addObject:[NSNumber numberWithFloat:height]];
    
    // Set the values that should be interpolated during the animation
    translation.values = values;
    // --- TRANSLATION KEYFRAME SETUP END ---
    
    // --- TRANSPARENCY KEYFRAME SETUP START ---
    CAKeyframeAnimation *transparency = [[CAKeyframeAnimation alloc] init];

    [transparency setKeyPath:keyPathTransparency];
    transparency.duration = KLB_CLOUD_ANIMATION_DURATION;
    
    NSMutableArray *transparencyValues = [[NSMutableArray alloc] init];
    [transparencyValues addObject:[NSNumber numberWithFloat:KLB_ZERO_F]];
    [transparencyValues addObject:[NSNumber numberWithFloat:KLB_CLOUD_MAX_OPACITY]];
    [transparencyValues addObject:[NSNumber numberWithFloat:KLB_ZERO_F]];
    transparency.values = transparencyValues;
    
    // --- TRANSPARENCY KEYFRAME SETUP START ---
    
    // This block repeats the animation but also randomizes the location and size of the cloud
    [CATransaction setCompletionBlock:^()
     {
         [values release];
         [transparencyValues release];
         [transparency release];
         [translation release];
         [self addFallAnimationForLayer:self.layer];
         
         int screenHeight = (int)[[UIScreen mainScreen] applicationFrame].size.height;
         int screenWidth = (int)[[UIScreen mainScreen] applicationFrame].size.width;
         
         CGPoint randomPoint;
         randomPoint.x = arc4random() % screenWidth;
         randomPoint.y = arc4random() % screenHeight - KLB_CLOUD_MAX_Y_ADJUSTMENT;
         
         CGSize randomSize;
         randomSize.height = arc4random() % (int)self.image.size.height * KLB_CLOUD_MAX_HEIGHT_MULTIPLIER;
         randomSize.width = randomSize.height * KLB_CLOUD_WIDTH_MULTIPLIER;
         
         self.frame = CGRectMake(randomPoint.x, randomPoint.y, randomSize.width, randomSize.height);
     }];
    
    [layer addAnimation:translation forKey:keyPathTranslationY];
    [layer addAnimation:transparency forKey:keyPathTransparency];
    
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
