//
//  KLBClouds.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/20/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBCloudView.h"
#import <QuartzCore/QuartzCore.h>

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
    translation.duration = 5.0f;
    
    // Allocate array to hold the values to interpolate
    NSMutableArray *values = [[NSMutableArray alloc] init];
    [values addObject:[NSNumber numberWithFloat:0.0f]];
    CGFloat height = [[UIScreen mainScreen] applicationFrame].size.height + layer.frame.size.height;
    [values addObject:[NSNumber numberWithFloat:height]];
    
    // Set the values that should be interpolated during the animation
    translation.values = values;
    // --- TRANSLATION KEYFRAME SETUP END ---
    
    // --- TRANSPARENCY KEYFRAME SETUP START ---
    CAKeyframeAnimation *transparency = [[CAKeyframeAnimation alloc] init];

    [transparency setKeyPath:keyPathTransparency];
    transparency.duration = translation.duration;
    
    NSMutableArray *transparencyValues = [[NSMutableArray alloc] init];
    [transparencyValues addObject:[NSNumber numberWithFloat:0.0]];
    [transparencyValues addObject:[NSNumber numberWithFloat:0.5]];
    [transparencyValues addObject:[NSNumber numberWithFloat:0.0]];
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
         
         CGPoint randomPoint;
         randomPoint.x = arc4random() % (int)[[UIScreen mainScreen] applicationFrame].size.width;
         randomPoint.y = arc4random() % (int)[[UIScreen mainScreen] applicationFrame].size.height-50;
         CGSize randomSize;
         //randomSize.width = arc4random() % (int)self.image.size.width;
         randomSize.height = arc4random() % (int)self.image.size.height*2;
         randomSize.width = randomSize.height * 2.5;
         
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
