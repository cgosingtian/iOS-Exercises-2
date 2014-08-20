//
//  KLBBulletView.m
//  Air Raid
//
//  Created by Chase Gosingtian on 8/19/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBBulletView.h"
#import "KLBBullet.h"

@implementation KLBBulletView

- (instancetype) initWithBulletType:(KLBBullet *)b {
    self = [super init];
    if (self) {
        float x = 0.0;
        float y = 0.0;
        _bullet = b;
        UIImage *bulletImage = [UIImage imageNamed:@"bullet_default.png"];
        self.image = bulletImage;
        
        switch (b.bulletType) {
            case btMachineGun:
            {
                UIImage *bulletImage = [UIImage imageNamed:@"bullet_machinegun.png"];
                self.image = bulletImage;
            }
                break;
            case btCannon:
            {
                UIImage *bulletImage = [UIImage imageNamed:@"bullet_cannon.png"];
                self.image = bulletImage;
            }
                break;
            case btDefault:
                break;
            default:
                break;
        }
        self.frame = CGRectMake(x, y, self.image.size.width, self.image.size.height);

        // add self to active view
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *topView = window.rootViewController.view;
        [topView addSubview:self];
    }
    return self;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        float x = 0.0;
        float y = 0.0;
        UIImage *bulletImage = [UIImage imageNamed:@"bullet_default.png"];
        self.image = bulletImage;
        self.frame = CGRectMake(x, y, self.image.size.width, self.image.size.height);
        
        // add self to active view
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *topView = window.rootViewController.view;
        [topView addSubview:self];
    }
    return self;
}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [NSException raise:@"Wrong initializer" format:@"Use initWithCoder"];
//    }
//    return self;
//}
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [NSException raise:@"Wrong initializer" format:@"Use initWithCoder"];
//    }
//    return self;
//}

- (void)updateCoordinatesX:(CGFloat) x Y:(CGFloat) y {
    [self setFrame:CGRectMake(x, y, self.image.size.width, self.image.size.height)];
    //[self setNeedsDisplay];
}

- (void)changeBulletImage:(BulletTypes)b {
    if (b == btMachineGun)
    {
        UIImage *bulletImage = [UIImage imageNamed:@"bullet_machinegun.png"];
        self.image = bulletImage;
    }
    else if (b == btCannon) {
        UIImage *bulletImage = [UIImage imageNamed:@"bullet_cannon.png"];
        self.image = bulletImage;
    }
    else if (b == btDefault) {
        UIImage *bulletImage = [UIImage imageNamed:@"bullet_default.png"];
        self.image = bulletImage;
    }
    else {
        UIImage *bulletImage = [UIImage imageNamed:@"bullet_default.png"];
        self.image = bulletImage;
    }
}

- (void) animateFadeIn {
//    [self setAlpha:0.0];
//    [UIView animateKeyframesWithDuration:0.2 delay:0.0 options:UIViewKeyframeAnimationOptionAutoreverse
//    animations:^()
//    {
//        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^()
//         {
//             [self setAlpha:1.0];
//         }];
//    }
//    completion:^(BOOL finished)
//    {
//        if (finished) {
//            [self animateBulletEffects];
//        }
//    }];
}

- (void) animateBulletEffects {
    [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat animations:^(){
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^(){
            if (_bullet) {
                if (_bullet.bulletType == btMachineGun)
                {
                    UIImage *bulletImage = [UIImage imageNamed:@"bullet_machinegun2.png"];
                    self.image = bulletImage;
                }
                else if (_bullet.bulletType == btCannon) {
                    UIImage *bulletImage = [UIImage imageNamed:@"bullet_cannon2.png"];
                    self.image = bulletImage;
                }
                else if (_bullet.bulletType == btDefault) {
                    UIImage *bulletImage = [UIImage imageNamed:@"bullet_default2.png"];
                    self.image = bulletImage;
                }
                else {
                    UIImage *bulletImage = [UIImage imageNamed:@"bullet_default2.png"];
                    self.image = bulletImage;
                }
            }
        }];
    } completion:nil];
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
